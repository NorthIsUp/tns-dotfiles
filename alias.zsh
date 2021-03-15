# ---------------------------------------------------------------------------- #
#                                    Aliases                                   #
# ---------------------------------------------------------------------------- #

alias -g ......='../../../../..'
alias -g .....='../../../..'
alias -g ....='../../..'
alias -g ...='../..'
alias -g 1DN="1>/dev/null"
alias -g 21="2>&1"
alias -g 2DN="2>/dev/null"
alias -g NUL="> /dev/null 2>&1"

alias -g CP='| pbcopy'
alias -g PV='pbpaste |'

alias -g PIPE='|'

alias -g G='| egrep -i'
alias -g GV='| grep -v'
alias -g A='| awk'
alias -g H='| head'
alias -g L='| less'
alias -g JQ='| jq'
alias -g S='| sed'
alias -g T='| tail'
alias -g NS='| sort -n'
alias -g US='| sort -u'

alias -g X='| xargs'
alias -g X0='| xargs -0'
alias -g X0G='| xargs -0 egrep'
alias -g XG='| xargs egrep'
alias -g XG="| xargs grep -ni"

alias -s py=python
alias -s rb=ruby
alias -s txt=subl
alias -s html=subl
alias -s java=open
alias -s org=open
alias -s com=open

# don't correct spelling on ...
alias git='nocorrect git'
alias mv='nocorrect mv'
alias cp='nocorrect cp'
alias mkdir='nocorrect mkdir'
