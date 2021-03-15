# better ls
(( $+commands[exa] )) && {
    export LS_OPTIONS="$LS_OPTIONS --git --color-scale --color=auto"
    alias ls="exa $LS_OPTIONS"
    alias ll="exa $LS_OPTIONS --long --all --header"
    alias lg="ll --git-ignore --git"
}

# better ls colors
if [[ "$TERM" != "dumb" ]] {
    # export LS_OPTIONS='--color=auto'
    if (( $+commands[gdircolors] )) {
        __dircolors=gdircolors
    } elif (( $+commands[dircolors] )) {
        __dircolors=dircolors
    }

    [[ -e "$__dircolors" ]] && eval "$("$__dircolors" $XDG_CONFIG_HOME/dir_colors)"
}
