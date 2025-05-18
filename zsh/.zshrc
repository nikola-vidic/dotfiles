#!/usr/bin/env bash

env_path="/home/nidzo/.config/dotfiles/zsh/.env"
[ -f $env_path ] && source "$env_path"

export EDITOR="code --wait" # Ctrl + x Ctrl + e
export FCEDIT=nvim          # fc in cli
export ZYPP_PCK_PRELOAD=1
export ZYPP_CURL2=1

# set zinit dir
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share/zinit/zinit.git}"
if [ ! -d "$ZINIT_HOME" ]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "${ZINIT_HOME}/zinit.zsh"

# Load starship theme
# line 1: `starship` binary as command, from github release
# line 2: starship setup at clone(create init.zsh, completion)
# line 3: pull behavior same as clone, source init.zsh
zinit ice as"command" from"gh-r" \
  atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
  atpull"%atclone" src"init.zsh"
zinit light starship/starship

zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit snippet OMZP::sudo
zinit snippet OMZL::completion.zsh
zinit snippet OMZL::key-bindings.zsh
zinit ice depth=1

alias yt="yt-dlp -ic"                      #
alias yta="yt-dlp -xic --audio-format mp3" #
alias de="trans :de"                       #
alias en="trans :en"                       #
alias sr="trans :sr"                       #

bindkey jj vi-cmd-mode

# zsh options
HISTSIZE=10000
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
alias ls='ls --color'
alias dotfiles="code ~/.config/dotfiles"

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
