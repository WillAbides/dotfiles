#!/bin/false
# shellcheck shell=bash

# check if this is a login shell
[ "$0" = "-bash" ] && export LOGIN_BASH="1"

# run bash_profile if this is not a login shell
# shellcheck source=.bash_profile
[ -z "$LOGIN_BASH" ] && source ~/.bash_profile

# History
export HISTFILE=~/.bash_history
export HISTCONTROL=ignoredups
export PROMPT_COMMAND='history -a'
export HISTIGNORE="&:ls:[bf]g:exit"

eval "$(direnv hook bash)"

# Generated for envman. Do not edit.
#[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
# . "$HOME/.cargo/env"

# Created by `pipx` on 2025-02-23 00:41:46
# export PATH="$PATH:/Users/will.roden/.local/bin"

export STARSHIP_CONFIG="$HOME/dotfiles/starship.toml"
eval "$(starship init bash)"
