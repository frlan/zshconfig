# Set up the prompt

autoload -Uz promptinit
promptinit
prompt bigfade

setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end

# Use modern completion system
autoload -Uz compinit
compinit

setopt \
    APPENDHISTORY \
    AUTOCD \
    BEEP \
    EXTENDEDGLOB \
    COMPLETE_ALIASES \
    HIST_IGNORE_ALL_DUPS \
    HIST_SAVE_NO_DUPS \
    HIST_REDUCE_BLANKS \
    HIST_EXPIRE_DUPS_FIRST \
    SHARE_HISTORY \
    EXTENDED_HISTORY

export PKG_CONFIG_PATH=/home/frlan/local/lib/pkgconfig/:/usr/lib/pkgconfig

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# http://www.princeton.edu/~kmccarty/zsh.html
# http://www.semicomplete.com/blog/2006/Jun/29
case $TERM in
  xterm*|rxvt)
    precmd () { print -Pn "\e]0;(%m) %~\a" }
    preexec ()
    {
        # escape '%' chars in $1, make nonprintables visible
        local a=${(V)1//\%/\%\%}
        printf '\e]0;%s\a' "$(print -Pn "(%m) %40>...>$a" | tr -d "\n")"
    }
    ;;
esac

alias 2screens='sudo xrandr --output VGA1 --auto --left-of LVDS1'

LANG=C fortune -s
export PATH="/home/frlan/bin:/home/frlan/local/bin/:$PATH"

