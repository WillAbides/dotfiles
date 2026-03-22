#!/bin/false
# shellcheck shell=bash

# If not interactive, do nothing
[[ $- != *i* ]] && return

# History
export HISTFILE=~/.bash_history
export HISTCONTROL=ignoredups
export PROMPT_COMMAND='history -a'
export HISTIGNORE="&:ls:[bf]g:exit"

# Aliases
alias sl=ls
alias ls='ls -G'
alias la='ls -AF'
alias ll='ls -al'
alias l='ls -a'
alias l1='ls -1'
alias lh='ll -htr'

# direnv
eval "$(direnv hook bash)"

# Starship prompt
export STARSHIP_CONFIG="$HOME/.dotfiles/starship.toml"
eval "$(starship init bash)"

export PATH="$HOME/.local/bin:$PATH"
