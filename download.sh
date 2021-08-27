#!/bin/sh

# download.sh will download the main branch of https://github.com/WillAbides/dotfiles to
# $HOME/dotfiles using the first available option of git, wget and curl.

set -e

tarball_url="https://github.com/WillAbides/dotfiles/archive/refs/heads/main.tar.gz"
tarball_name="dotfiles.tar.gz"
git_url="https://github.com/WillAbides/dotfiles.git"
git_push_url="git@github.com:WillAbides/dotfiles.git"

TARGET="${TARGET:-"$HOME/dotfiles"}"

download_tarball() {
  if [ -e "$tarball_name" ]; then
    >&2 echo "$(pwd)/$tarball_name already exists. Please remove it and try again."
    exit 1
  fi
  if type wget >/dev/null 2>&1; then
    wget -O "$tarball_name" "$tarball_url"
    return
  fi
  if type curl >/dev/null 2>&1; then
    curl -Lo "$tarball_name" "$tarball_url"
    return
  fi
  >&2 echo "cannot download because neither git, wget nor curl are available"
  exit 1
}

download_and_extract() {
  mkdir -p "$TARGET"
  cd "$TARGET"
  download_tarball
  tar -xzf "$tarball_name" --strip-components=1
  rm "$tarball_name"
}

if [ -e "$TARGET" ]; then
  >&2 echo "$TARGET already exists."
  exit 1
fi

target_parent="$(dirname "$TARGET")"

mkdir -p "$target_parent"

if type git >/dev/null 2>&1; then
    cd "$target_parent"
    git clone "$git_url" "$TARGET"
    cd "$TARGET"
    git remote set-url --push origin "$git_push_url"
else
  download_and_extract
fi
