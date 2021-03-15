# ---------------------------------------------------------------------------- #
#                                  git config                                  #
# ---------------------------------------------------------------------------- #
# if we have not set it up before set this config globally
(( $+commands[git] )) && [[ ! "$(git config --get alias.log-helper)" ]] && {
    function _gcg() {
        [[ "$2" == '=' ]] && 2=''
        key=$1
        shift
        arg="${@//[[:space:]][[:space:]]/ }"
        echo $arg
        git config --global $key "$arg"
    }
    ##### HELPERS
    ## @helpers shows the current name and email that git is using
    _gcg alias.whoami = '!echo "<$(git config user.name)> $(git config user.email)"'

    ## @hub
    _gcg alias.browse-pulls = "!hub browse -- pulls"

    ## @diff diff HEAD against master, only show current branch's changes
    _gcg alias.branchlog = '!git log $(git oldest-ancestor)..'
    _gcg alias.branchdiff = '!git diff $(git oldest-ancestor)..'

    _gcg alias.dm = branchdiff
    _gcg alias.dh = diff HEAD

    ## @util print files changed vs master
    _gcg alias.changed = '!f() { \
            main=${1:-$(git current-branch)} ; \
            other=${2:-origin/master} ; \
            merge_base=$(git merge-base $other $main) ; \
            git diff --name-only $main $merge_base ; \
        }; \
        f'

    ## @util print the current branch name
    _gcg alias.current-branch = rev-parse --abbrev-ref HEAD

    ##### LOGGING

    ## @logging base logging info for making other aliases (graph, decorate, etc.)
    _gcg alias.log-helper = log --graph --abbrev-commit --decorate --color --branches

    ## @logging The one log command to rule them all
    _gcg alias.log-all = !git log-helper --format=format:'%C(yellow)%h%C(reset) %C(blue)%ad%C(reset) %C(white)%s%C(reset)%C(auto)%d%C(reset) %C(dim white)- %an%C(reset)\n%><(43,ltrunc)%B'

    ## @logging most used log line (top 40 nodes)
    _gcg alias.ll = '!f() { : git log ; \
            git log-helper --format=format:"%C(auto)%h %d %s %C(dim white)- %an %ar %C(reset)" $@ \
            | git recolor \
            | less --tabs=1,5 -R ; \
        } ;\
        f'

    ## @logging most used log line (without truncating)
    _gcg alias.lg = '!f() { : git log ; \
                local l=$(tput lines) ; \
                lines=$((l - (l * 1 / 10))) ; \
                git ll $@ | head -$lines ; \
            }; f'

    _gcg alias.lgs = lg -- discord_smite_*

    ## @logging most used log line (without truncating)
    _gcg alias.la = "!f() { : git log ; git lg --all ; }; f"

    ## @logging with stat info
    _gcg alias.ls = '!f() { : git log ; git ll $@ --stat --graph; }; f'

    ## @logging with author info
    _gcg alias.lw = log --graph --all --abbrev-commit --pretty=format:'%C(auto)%h%C(reset) -%C(auto)%d%C(reset) %s %C(yellow)<%C(green)%cd%C(reset) by %C(blue)%aE%C(yellow)>%C(reset)'

    ## @logging with time info
    _gcg alias.when = log --graph --all --abbrev-commit --pretty=format:'%C(auto)%h%C(reset) - %cd %C(auto)%d%C(reset) %s by %C(blue)%aE%C(reset)'

    ##### TREE
    # aliases to hep with navigation

    ## @tree
    _gcg alias.co = checkout

    ## @tree
    _gcg alias.df = diff

    ## @tree
    _gcg alias.fa = fetch --all

    ## @tree
    _gcg alias.rom = rebase origin/master

    ## @tree
    _gcg alias.update = !"\
        f() {\
            git fa \
            && git um \
            && git rom \
        } ; f"

    ## @tree cherry pick a branch and rebase it on top (while keeping branch name)

    _gcg alias.rebase-range = '!f() { : git rebase ; \
            STARTING=${1:-$(git current-branch)} ; \
            BRANCH=${2:-$(git current-branch)} ; \
            git rebase --onto origin/master ${STARTING}~1 ${BRANCH} $@ ; \
            }; f'

    ## @tree
    _gcg alias.rcp = cherry-pick-rebase

    ## @tree
    _gcg alias.st = status

    ##### DEVELOPMENT

    ## @init create a gitignore file from sane defaults for python, frameworks, and editors
    _gcg alias.ignore-defaults = '!gi(){ \
        base="https://www.toptal.com/developers/gitignore/api" ; \
        [[ $1 == list ]] && \
            curl -sL $base/list | tr "," "\n" | grep \"^$2\" | column \
            || curl -sL $base/$(echo \"$@\" | tr " " ",") \
        ; } ; gi'
    _gcg alias.ignore-defaults-python = !"git ignore-defaults python pycharm vscode > .gitignore ; cat .gitignore"

    ## @reset
    _gcg alias.unstage = reset HEAD

    ## @branch Find sha of the oldest commit on both this branch and master
    # https://stackoverflow.com/questions/1527234/finding-a-branch-point-with-git
    _gcg alias.oldest-ancestor = '!\
        diff \
            --old-line-format="" \
            --new-line-format="" \
            <(git rev-list --first-parent "${1:-master}") \
            <(git rev-list --first-parent "${2:-HEAD}") \
        | head -1 -'

    ## @utilities
    _gcg alias.amend = '!a() {\
        set -x ; \
        git commit --amend "${@:---reuse-message}" HEAD ; \
        }; a'

    ## @fetch update master
    _gcg alias.um = '!f() { \
            if [[ $(git current-branch) == master ]] ; then \
                set -x ; \
                git pull ; \
            else \
                set -x ; \
                git fetch origin master:master ; \
                git branch -f master origin/master >/dev/null; \
            fi \
        }; f'

    ##### MISC

    ## Push the current new branch and start tracking to origin
    _gcg alias.push-new-branch = !"git push -u origin \$(git symbolic-ref HEAD | awk 'BEGIN { FS=\"/\" }; {print \$3}')"

    ## @stash List all stashes
    _gcg alias.stashes = stash list --oneline

    ## @stash reverse changes from stash apply
    _gcg alias.stash-unapply = !"git stash show -p | git apply -R"

    ## @stash stash ; rebase ; pop
    _gcg alias.stash-rom = !"git stash && git rom && git stash pop"

    ## @conflict test
    _gcg alias.mergetest = !"f() { \
        git merge --no-commit --no-ff \"$1\" || { \
            git merge --abort ; echo \"Merge aborted\" ; \
        }; \
    }; f"

    ##
    _gcg alias.ci = commit
    _gcg alias.empty = commit --allow-empty
    unfunction _gcg
}
