#!/bin/sh

set -e

CDPATH="" cd -- "$(dirname -- "$0")"
DOTFILESDIR="$(pwd -P)"

needs_dotfiles_link() {
  if [ ! -e "$HOME/.dotfiles" ]; then
    return 0
  fi
  if [ -L "$HOME/.dotfiles" ]; then
    target="$(cd "$(readlink "$HOME/.dotfiles" || "")" && pwd -P)"
    if [ "$target" = "$DOTFILESDIR" ]; then
      return 1
    fi
  fi
  echo "$HOME/.dotfiles exists. Please remove it and try again." 1>&2
  exit 1
}

if needs_dotfiles_link; then
  ln -s "$DOTFILESDIR" "$HOME/.dotfiles"
fi

mkdir -p "$HOME/bin"
mkdir -p "$HOME/go/bin"

script/bindown install gitstatus --output ./gitstatus
script/bindown install direnv --output "$HOME/bin/direnv"

files_to_link='
.shprofile
.bashrc
.bash_profile
.gitconfig
.gitignore_global
.gitstatus-enhanced
'

for file_to_link in $files_to_link; do
  rm -f "$HOME/$file_to_link"
  ln -s "$HOME/.dotfiles/$file_to_link" "$HOME/$file_to_link"
done

# only set up .ssh if we aren't in an ssh session
if [ -z "$SSH_CLIENT" ] && [ -z "$SSH_TTY" ]; then
  rm -f "$HOME/.ssh"
  ln -s "$HOME/.dotfiles/ssh" "$HOME/.ssh"
  mkdir -p ~/.ssh/ctl
fi
