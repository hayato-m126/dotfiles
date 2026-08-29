#!/bin/bash

if [[ "$OSTYPE" == "msys"* ]]; then
  export MSYS=winsymlinks:nativestrict
fi

mkdir -p ~/.config/ghostty
mkdir -p ~/.config/git
mkdir -p ~/.config/mise
mkdir -p ~/.config/cspell/dictionaries
mkdir -p ~/.ros
mkdir -p ~/.ssh/conf.d

SCRIPT_DIR=$(cd $(dirname $0); pwd)

cd ${SCRIPT_DIR}/HOME
for file in `find . -type f` ; do
  # escape . and /, replace ./ to ""
  relative_path=`echo $file | sed s@\.\/@@`
  # echo ${HOME}/$relative_path
  ln -snfv `realpath $file` ${HOME}/$relative_path
done

if [[ "$OSTYPE" == "darwin"* ]]; then
  # cspell looks up its global config at ~/Library/Preferences/cspell on macOS
  # (XDG's ~/.config/cspell is only honored on Linux), so link the whole
  # directory there too, keeping cspell.json and dictionaries/ together.
  mkdir -p ~/Library/Preferences
  ln -snfv `realpath ${SCRIPT_DIR}/HOME/.config/cspell` ~/Library/Preferences/cspell
fi

if [ -f "/.dockerenv" ] || [ -n "$REMOTE_CONTAINERS" ] || [ -n "$DEVCONTAINER" ]; then
  echo "devcontainer detected, installing extra tools..."

  # install fzf to use history search in devcontainer
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install --all
fi
