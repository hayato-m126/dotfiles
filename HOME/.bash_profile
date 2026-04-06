# .bash_profile: ログインシェルで実行される

export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"

# .bashrc を読み込む
if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi
