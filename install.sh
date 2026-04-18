#!/bin/bash

mkdir -p ~/.config/ghostty
mkdir -p ~/.config/git
mkdir -p ~/.config/mise
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

if [ -f "/.dockerenv" ] || [ -n "$REMOTE_CONTAINERS" ] || [ -n "$DEVCONTAINER" ]; then
  echo "devcontainer detected, installing extra tools..."

  # mise
  # curl https://mise.run | sh

  # install claude binary version
  curl -fsSL https://claude.ai/install.sh | bash
fi
