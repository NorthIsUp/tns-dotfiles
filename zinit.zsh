# - pretty shell
#       romkatv/powerlevel10k
# - shell improvments
#       zdharma/history-search-multi-word
#       zdharma/fast-syntax-highlighting
#       zsh-users/zsh-completions
#       zsh-users/zsh-autosuggestions
# - pretty git
#       northisup/git-by-id
# - autojump
#       agkozak/zsh-z
# - better ls
#       ogham/exa


# needed for shell startup
zinit wait lucid for \
    light-mode romkatv/powerlevel10k

# do async
zinit lucid wait'1' for \
    load northisup/git-by-id \
    load agkozak/zsh-z \
    light-mode zsh-users/zsh-completions \
    light-mode from'gh-r' as'program' mv'exa* -> exa' \
        ogham/exa \
    load zdharma/history-search-multi-word \
    atinit'ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay' \
        zdharma/fast-syntax-highlighting \
    blockf \
        zsh-users/zsh-completions \
    atload'!_zsh_autosuggest_start' \
        zsh-users/zsh-autosuggestions

# configure history-search-multi-word
zstyle :plugin:history-search-multi-word reset-prompt-protect 1


# run silent updates in the background for next time
{
    # freeze the zinit version and block updates by putting a sha in ~/.zinit_version
    if [[ -f ~/.zinit_version ]] {
        git \
            --work-tree="${ZINIT[BIN_DIR]}" \
            --git-dir="${ZINIT[BIN_DIR]}/.git" \
            reset --hard "$(cat ~/.zinit_version)"
    } else {
        zinit self-update >/dev/null 2>/dev/null \
        && zinit update --all >/dev/null 2>/dev/null
    }
}&!
