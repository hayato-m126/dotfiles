function gitca
  git reset --hard HEAD
  git clean -df
  git submodule foreach git reset --hard HEAD
  git submodule foreach git clean -df
end
