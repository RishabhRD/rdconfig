export XDG_DESKTOP_DIR="$HOME/Desktop"
export XDG_DOCUMENTS_DIR="$HOME/Documents"
export XDG_DOWNLOAD_DIR="$HOME/Downloads"
export XDG_MUSIC_DIR="$HOME/Music"
export XDG_PICTURES_DIR="$HOME/Pictures"
export XDG_TEMPLATES_DIR="$HOME/Templates"
export XDG_VIDEOS_DIR="$HOME/Videos"
export XDG_CONFIG_HOME="$HOME"/.config
export XDG_CACHE_HOME="$HOME"/.cache
export XDG_DATA_HOME="$HOME"/.local/share
export EDITOR="nvim"
export TERMINAL="alacritty"
export BROWSER="brave-browser"
export LESS=-R
export LESS_TERMCAP_mb=$'\E[1;31m'
export LESS_TERMCAP_md=$'\E[1;36m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_us=$'\E[1;32m'
export LESS_TERMCAP_ue=$'\E[0m'
export FZF_DEFAULT_COMMAND='fd --type f --exclude .git'
export GTK_THEME="Adwaita:dark"

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git vi-mode)
source $ZSH/oh-my-zsh.sh


alias grep='grep --color=auto'
alias r='ranger'
alias t='tmux -u a'
alias td='tmux -u new -s default'
alias c='to `fzdir ~/.config`'
alias o='to `fzdir ~/personal`'
alias gits='to `fzdir ~/git/`'
alias tmux='tmux -u'

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

fins(){
  local t
  t=$(apt-cache pkgnames | fzf --multi | tr '\n' ' ')
  if [ ! -z "$t" ]; then
    echo $t | xargs -o sudo apt install
  fi
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
zle -N zle-keymap-select
zle-line-init() {
zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
echo -ne "\e[5 q"
}
zle -N zle-line-init
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

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

autoload -U compinit && compinit

export KEYTIMEOUT=1

source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
bindkey '^ ' autosuggest-accept

export PATH=$PATH:$HOME/.local/bin/scripts
source ~/.paths.zsh
