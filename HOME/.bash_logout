# ~/.bash_logout: executed by bash(1) when login shell exits.
# when leaving the console clear the screen to increase privacy
if [ "$SHLVL" = 1 ]; then
    [ -x /usr/bin/clear_console ] && /usr/bin/clear_console -q
fi

# reset backgournd color, default color of ghostty
if [ -n "$SSH_CONNECTION" ]; then
  printf '\e]11;rgb:2828/2c2c/3434\a'
fi
