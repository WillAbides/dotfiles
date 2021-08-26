#!/bin/false
# shellcheck shell=bash

# load shared shell configuration
# shellcheck source=.shprofile
source ~/.shprofile

# check if this is a login and/or interactive shell
[ "$0" = "-bash" ] && export LOGIN_BASH="1"
echo "$-" | grep -q "i" && export INTERACTIVE_BASH="1"

# run bashrc if this is a login, interactive shell
if [ -n "$LOGIN_BASH" ] && [ -n "$INTERACTIVE_BASH" ]; then
  # shellcheck source=.bashrc
  source ~/.bashrc
fi

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Enable history appending instead of overwriting.
shopt -s histappend

# Save multiline commands
shopt -s cmdhist

# Correct minor directory changing spelling mistakes
shopt -s cdspell

# Bash completion
# shellcheck source=/dev/null
[ -f /etc/profile.d/bash-completion ] && source /etc/profile.d/bash-completion

if type brew &>/dev/null; then
  # shellcheck source=/dev/null
  [ -f "$(brew --prefix)/etc/bash_completion" ] && source "$(brew --prefix)/etc/bash_completion" >/dev/null
fi

# shellcheck source=.gitstatus-enhanced
source ~/.gitstatus-enhanced

# List directory contents
alias sl=ls
alias ls='ls -G'
alias la='ls -AF'
alias ll='ls -al'
alias l='ls -a'
alias l1='ls -1'
alias lh='ll -htr'

alias ghcop='bin/rubocop $(git ls-files --modified)'

for self_complete in bindown octo; do
  if which "$self_complete" >/dev/null; then
    complete -C "$(which "$self_complete")" "$self_complete"
  fi
done

# shellcheck source=/dev/null
source ~/.dotfiles/iterm2_shell_integration.bash
