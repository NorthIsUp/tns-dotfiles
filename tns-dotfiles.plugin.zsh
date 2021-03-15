0="${ZERO:-${${0:#$ZSH_ARGZERO}:-${(%):-%N}}}"
0="${${(M)0:#/*}:-$PWD/$0}"

# Then ${0:h} to get plugin’s directory
local _root=${0:h}

source \
    $_root/env.zsh \
    $_root/alias.zsh \
    $_root/git.zsh \
    $_root/polyfill.zsh \
    $_root/zinit.zsh
