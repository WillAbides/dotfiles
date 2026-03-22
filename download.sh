#!/bin/sh

# download.sh will download the main branch of https://github.com/WillAbides/dotfiles to
# $HOME/dotfiles using the first available option of git, wget and curl.

set -e

DOTFILES_REF="${DOTFILES_COMMIT:-refs/heads/main}"
tarball_url="https://github.com/WillAbides/dotfiles/archive/$DOTFILES_REF.tar.gz"
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
  if ! download_tarball || ! tar -xzf "$tarball_name" --strip-components=1; then
    rm -f "$tarball_name"
    cd ..
    rmdir "$TARGET" 2>/dev/null
    exit 1
  fi
  rm "$tarball_name"
}

if [ -e "$TARGET" ]; then
  >&2 echo "$TARGET already exists."
  exit 1
fi

target_parent="$(dirname "$TARGET")"

mkdir -p "$target_parent"

use_git=""
if [ "${DOTFILES_USE_TARBALL-}" != "1" ] && type git >/dev/null 2>&1; then
  use_git=1
fi

if [ -n "$use_git" ]; then
  cd "$target_parent"
  git clone "$git_url" "$TARGET"
  cd "$TARGET"
  if [ -n "${DOTFILES_COMMIT-}" ]; then
    git checkout "$DOTFILES_COMMIT"
  fi
  git remote set-url --push origin "$git_push_url"
else
  download_and_extract
fi
