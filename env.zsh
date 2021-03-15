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

# ---------------------------------- editor ---------------------------------- #
# change this to vim, emacs, subl, etc. as you wish
# nano is a super easy cli editor that is good for git commits
export EDITOR=nano

# ---------------------------------- history --------------------------------- #
export HISTFILE="$HOME/.zsh_history" # The path to the history file.
export HISTSIZE=${INT_MAX:-100000}        # The maximum number of events to save in the internal history.
export SAVEHIST=${INT_MAX:-100000}        # The maximum number of events to save in the history file.

setopt APPEND_HISTORY
setopt BANG_HIST
setopt EXTENDED_HISTORY
setopt HIST_BEEP
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FCNTL_LOCK
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_LEX_WORDS
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY
setopt SHARE_HISTORY

# ----------------------------- Zsh Z (Autojump) ----------------------------- #
# tool to help jumping around the shell

ZSHZ_CMD=j # changes the command name (default: z)
# ZSHZ_COMPLETION can be 'frecent' (default) or 'legacy', depending on whether you want your completion results sorted according to frecency or simply sorted alphabetically
ZSHZ_DATA="$XDG_DATA_HOME/z" # changes the database file (default: ~/.z)
# ZSHZ_EXCLUDE_DIRS is an array of directories to keep out of the database (default: empty)
# ZSHZ_KEEP_DIRS is an array of directories that should not be removed from the database, even if they are not currently available (useful when a drive is not always mounted) (default: empty)
# ZSHZ_MAX_SCORE is the maximum combined score the database entries can have before they begin to age and potentially drop out of the database (default: 9000)
# ZSHZ_NO_RESOLVE_SYMLINKS prevents symlink resolution (default: 0)
# ZSHZ_OWNER allows usage when in sudo -s mode (default: empty)

# ---------------------------------- prompt ---------------------------------- #
POWERLEVEL9K_CONFIG_DIR="$XDG_CONFIG_HOME/p10k"

if [[ ! -e "$POWERLEVEL9K_CONFIG_FILE" ]] {
    mkdir -p "${POWERLEVEL9K_CONFIG_FILE:h}"
} else {
    POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true
    source $POWERLEVEL9K_CONFIG_FILE
}

# install fonts for powerline
_POWERLINE_FONTS=(
    "MesloLGS NF Regular.ttf"
    "MesloLGS NF Bold.ttf"
    "MesloLGS NF Italic.ttf"
    "MesloLGS NF Bold Italic.ttf"
)
for font in $_POWERLINE_FONTS ; {
    [[ -e "$HOME/Library/Fonts/$font" ]] ||() {
        [[ -d "$HOME/Library/Fonts/" ]] || mkdir -p "$HOME/Library/Fonts/"
        curl "https://github.com/romkatv/powerlevel10k-media/raw/master/${font:gs/ /%20}" -o "$HOME/Library/Fonts/$font"
        echo "for more info on setting up fonts go here https://github.com/romkatv/powerlevel10k#automatic-font-installation"
    }
}
