#!/bin/false
# shellcheck shell=bash

# load shared shell configuration
# shellcheck source=.shprofile
source ~/.shprofile

# shopts
shopt -s checkwinsize histappend cmdhist cdspell

# Bash completion
# shellcheck source=/dev/null
[ -f /etc/profile.d/bash-completion ] && source /etc/profile.d/bash-completion

if type brew &>/dev/null; then
  # shellcheck source=/dev/null
  [ -f "$(brew --prefix)/etc/bash_completion" ] && source "$(brew --prefix)/etc/bash_completion" >/dev/null
fi

[[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]] && . "/opt/homebrew/etc/profile.d/bash_completion.sh"

# Cargo (guarded)
# shellcheck source=/dev/null
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"

# Self-completing tools
for self_complete in bindown octo; do
  if command -v "$self_complete" >/dev/null 2>&1; then
    complete -C "$(command -v "$self_complete")" "$self_complete"
  fi
done

# Source interactive config
# shellcheck source=.bashrc
source ~/.bashrc
