# Environment
source ~/.paths.zsh
export EDITOR="nvim"
export TERMINAL="ghostty"
export BROWSER="chromium"
export ZSH="$HOME/.oh-my-zsh"
export SUDO_EDITOR="$EDITOR"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export OMARCHY_PATH=$HOME/.local/share/omarchy
export PATH=$OMARCHY_PATH/bin:$PATH:$HOME/.local/bin

# Functions
fzdir(){
  find -L $1 -maxdepth 1 -type d | fzf --reverse --height=10
}
fzdir_deep(){
  find -L $1 -type d | fzf --reverse --height=10
}

to(){
  input=$1
  if [[ -z $input ]]; then
    input="$HOME"
    base_n="Home"
  else
    base_n=$(basename $input)
  fi
  if [[ -n $(pgrep tmux) ]]; then
    if [[ -z $TMUX ]]; then
      tmux a -t "default" \; neww -n $base_n -c "$input" \;
    else
      tmux rename-window $base_n \;
      cd $input
    fi
  else
    cd
    tmux new -s default \; neww -n $base_n -c $input \; kill-window -t 1 \;
  fi
}

fman() {
  man -k . | fzf --prompt='Man> ' | awk '{print $1}' | xargs -r man
}

fins() {
  local pkgs
  pkgs=$(pacman -Slq | sort -u | fzf -m) || return
  sudo pacman -S $pkgs
}

function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
    [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'

  elif [[ ${KEYMAP} == main ]] ||
    [[ ${KEYMAP} == viins ]] ||
    [[ ${KEYMAP} = '' ]] ||
    [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}

# Oh my zsh
ZSH_THEME="robbyrussell"
plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
  zsh-history-substring-search
  fzf
)
bindkey '^ ' autosuggest-accept
source $ZSH/oh-my-zsh.sh

# Aliases
alias grep='grep --color=auto'
alias r='ranger'
alias t='tmux -u a'
alias td='tmux -u new -s default'
alias c='to `fzdir ~/.config`'
alias o='to `fzdir ~/personal`'
alias gits='to `fzdir ~/git/`'

# Vim Mode
zle -N zle-keymap-select
zle-line-init() {
zle -K viins
echo -ne "\e[5 q"
}
zle -N zle-line-init
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char
export KEYTIMEOUT=1

# History
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000
setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.
