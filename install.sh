#!/bin/bash

mkdir -p ~/.ssh
mkdir -p ~/.config/fish
mkdir -p ~/.config/terminator/plugins
mkdir -p ~/.config/git
mkdir -p ~/.ros

SCRIPT_DIR=$(cd $(dirname $0); pwd)

cd ${SCRIPT_DIR}/HOME
for file in `find . -type f` ; do
  # escape . and /, replace ./ to ""
  relative_path=`echo $file | sed s@\.\/@@`
  # echo ${HOME}/$relative_path
  ln -snfv `realpath $file` ${HOME}/$relative_path
done
