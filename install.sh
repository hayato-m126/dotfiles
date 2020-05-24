cd HOME
for file in `find . -type f` ; do
  relative_path=`echo $file | sed s@\.\/@@`
  # echo ${HOME}/$relative_path
  ln -snfv `realpath $file` ${HOME}/$relative_path
done
