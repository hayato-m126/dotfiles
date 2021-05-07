#!/bin/bash

mkdir -p ~/.config/terminator
cd HOME
for file in `find . -type f` ; do
  # escape . and /, replace ./ to ""
  relative_path=`echo $file | sed s@\.\/@@`
  # echo ${HOME}/$relative_path
  ln -snfv `realpath $file` ${HOME}/$relative_path
done
