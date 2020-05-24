# cd HOME
# for file in `find . -type f` ; do
#     # echo `realpath $file`
#     echo `$file | tr -d ./`
#     # ln -snfv `realpath $file` ${HOME}/$file
# done

ln -snfv `realpath ./HOME/.gitconfig` ${HOME}/.gitconfig
ln -snfv `realpath ./HOME/.editorconfig` ${HOME}/.editorconfig
ln -snfv `realpath ./HOME/.bashrc` ${HOME}/.bashrc
ln -snfv `realpath ./HOME/.tmux.conf` ${HOME}/.tmux.conf
ln -snfv `realpath ./HOME/.ssh/config` ${HOME}/.ssh/config
ln -snfv `realpath ./HOME/.config/fish/fishfile` ${HOME}/.config/fish/fishfile
ln -snfv `realpath ./HOME/.config/fish/conf.d/config.fish` ${HOME}/.config/fish/conf.d/config.fish
