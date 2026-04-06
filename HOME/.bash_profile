# .bash_profile: ログインシェルで実行される

if [[ "$OSTYPE" == "darwin"* ]]; then
  export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
  export PATH="/Users/hyt/.antigravity/antigravity/bin:$PATH"
  source ~/.bashrc
fi
