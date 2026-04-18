# .bash_profile: ログインシェルで実行される

if [[ "$OSTYPE" == "darwin"* ]]; then
  export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
  # Added by OrbStack: command-line tools and integration
  # This won't be added again if you remove it.
  source ~/.orbstack/shell/init.bash 2>/dev/null || :
  if type brew &>/dev/null
  then
    HOMEBREW_PREFIX="$(brew --prefix)"
    if [[ -r "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" ]]
    then
      source "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"
    else
      for COMPLETION in "${HOMEBREW_PREFIX}/etc/bash_completion.d/"*
      do
        [[ -r "${COMPLETION}" ]] && source "${COMPLETION}"
      done
    fi
  fi
fi

source ~/.bashrc
