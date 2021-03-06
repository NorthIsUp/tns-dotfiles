# install

Add this to `.zshrc`

```zsh
# ------------------------- xdg evnironment variables ------------------------ #
# lots of modern apps will put their config in the apropriate dir, but only if you tell them to...

# XDG_CONFIG_HOME defines the base directory relative to which user specific configuration files should be stored. If XDG_CONFIG_HOME is either not set or empty, a default equal to $HOME/.config should be used.
export XDG_CONFIG_HOME="$HOME/.config"

# XDG_DATA_HOME defines the base directory relative to which user specific data files should be stored. If XDG_DATA_HOME is either not set or empty, a default equal to $HOME/.local/share should be used.
export XDG_DATA_HOME="$HOME/.local/share"

# XDG_CACHE_HOME defines the base directory relative to which user specific non-essential data files should be stored. If XDG_CACHE_HOME is either not set or empty, a default equal to $HOME/.cache should be used.
export XDG_CACHE_HOME="$HOME/.cache"

# XDG_RUNTIME_DIR defines the base directory relative to which user-specific non-essential runtime files and other file objects (such as sockets, named pipes, ...) should be stored. The directory MUST be owned by the user, and they MUST be the only one having read and write access to it. Its Unix access mode MUST be 0700.
export XDG_RUNTIME_DIR="$HOME/.runtime"

# ensure all the XDG dirs exist
mkdir -p "$XDG_CONFIG_HOME" "$XDG_DATA_HOME" "$XDG_CACHE_HOME" "$XDG_RUNTIME_DIR"
[[ -e "$XDG_RUNTIME_DIR" ]] && chmod 0700 "$XDG_RUNTIME_DIR"

# ---------------------------------------------------------------------------- #
#                               Zinit and Plugins                              #
# ---------------------------------------------------------------------------- #

# config map
declare -gA ZINIT

# these will fully rebuild if they are missing, so cache
ZINIT[HOME_DIR]="$XDG_CACHE_HOME/zinit"
ZINIT[BIN_DIR]="$XDG_CACHE_HOME/zinit.git"

# install zinit if missing
[[ -d "$ZINIT[BIN_DIR]" ]] || {
    mkdir -p "$ZINIT[BIN_DIR]"
    git clone https://github.com/zdharma/zinit "${ZINIT[BIN_DIR]}"
}

source "$ZINIT[BIN_DIR]/zinit.zsh" || {
    print -u2 "${ZINIT[BIN_DIR]}/zinit.zsh not found, exiting in 5s"
    sleep 5
    return 1
}

zinit wait lucid for load northisup/tns-dotfiles
