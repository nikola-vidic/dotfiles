#!/usr/bin/env bash

env_path="/home/nidzo/.config/dotfiles/zsh/.env"
[ -f $env_path ] && source "$env_path"

export EDITOR="code --wait" # Ctrl + x Ctrl + e
export FCEDIT=nvim          # fc in cli
export ZYPP_PCK_PRELOAD=1
export ZYPP_CURL2=1
export PATH=$PATH:$HOME/.local/bin:$HOME/.dotnet

# set zinit dir
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share/zinit/zinit.git}"
if [ ! -d "$ZINIT_HOME" ]; then
  mkdir -p "$(dirname "$ZINIT_HOME")"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "${ZINIT_HOME}/zinit.zsh"

# zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit snippet OMZP::sudo
zinit snippet OMZL::completion.zsh
zinit snippet OMZL::key-bindings.zsh
zinit ice depth=1

bindkey jj vi-cmd-mode

alias de="trans :de"
alias en="trans :en"
alias sr="trans :sr"
alias dotfiles="code ~/.config/dotfiles"

bindkey '\t' menu-complete

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
source <(COMPLETE=zsh dev)
