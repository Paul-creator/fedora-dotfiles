# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(
    git
    dnf
    zsh-autosuggestions
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# check the dnf plugins commands here
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/dnf


# Display Pokemon-colorscripts
# Project page: https://gitlab.com/phoneybadger/pokemon-colorscripts#on-other-distros-and-macos
# pokemon-colorscripts --no-title -s -r #without fastfetch
# pokemon-colorscripts --no-title -s -r | fastfetch -c $HOME/.config/fastfetch/config-pokemon.jsonc --logo-type file-raw --logo-height 10 --logo-width 5 --logo -

# fastfetch. Will be disabled if above colorscript was chosen to install
# fastfetch -c $HOME/.config/fastfetch/config-compact.jsonc

# Set-up FZF key bindings (CTRL R for fuzzy history finder)
source <(fzf --zsh)

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

# Set-up icons for files/directories in terminal using lsd
alias ls='lsd'
alias l='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias lt='ls --tree'


export PDK_ROOT="$HOME/pdks"
export PATH="$HOME/.local/bin:$PATH"

export EDITOR="nvim"
export VISUAL="nvim"

alias sak-pdk="source ~/.local/bin/sak-pdk.sh"


condainit() {
  unset -f conda
  unset -f condainit

  __conda_setup="$("$HOME/Programs/miniconda3/bin/conda" shell.zsh hook 2>/dev/null)"
  if [ $? -eq 0 ]; then
    eval "$__conda_setup"
  else
    if [ -f "$HOME/Programs/miniconda3/etc/profile.d/conda.sh" ]; then
# . "$HOME/Programs/miniconda3/etc/profile.d/conda.sh"  # commented out by conda initialize
    else
# export PATH="$HOME/Programs/miniconda3/bin:$PATH"  # commented out by conda initialize
    fi
  fi
  unset __conda_setup
}

conda() {
  condainit
  conda "$@"
}

# nvim
export PATH="$PATH:/opt/nvim-linux-x86_64/bin"

# doom 
alias doom=$HOME/.config/emacs/bin/doom

# dotfiles
alias dot='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
alias lzdot='GIT_DIR=$HOME/.dotfiles GIT_WORK_TREE=$HOME lazygit'
dot config --local status.showUntrackedFiles no
dotuntracked() {
  dot status -uall -- "$1"
}

# cargo
. "$HOME/.cargo/env"

alias nano=nvim

eval "$(zoxide init zsh)"

# for tmux renaming tabs
precmd() {
  printf  "\033]2;%s\033\\" "${PWD:t}"
}

if command -v tmux >/dev/null 2>&1 && [ -z "$TMUX" ]; then
  exec tmux
fi


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/paul/Programs/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/paul/Programs/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/paul/Programs/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/paul/Programs/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

