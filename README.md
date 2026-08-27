# dotfiles

Repository for managing configuration files

## environment

- Ubuntu 24.04 / 26.04
- macOS Tahoe 26
- Windows 11 (Git bash)

## usage

1. Place configuration files in the HOME directory
2. Apply settings using ./install.sh

### Windows (Git Bash)

Creating symbolic links with `ln -s` requires elevated privileges, so run `install.sh` from a Git Bash launched as Administrator.
(Elevated privileges are only needed when `install.sh` must be re-run, e.g. after adding new config files. Regular editing of config files works fine without elevation.)

## reference

- <https://gitlab.com/clear-code/ssh.d>
- <https://github.com/kenji-miyake/dotfiles>

## VSCode Git Settings

Configure VSCode to always add signed-off-by to git commits

<https://qiita.com/ItSANgo/items/135f91c08cf8380cab82>

Once configured, these settings will be synchronized through VSCode's sync feature.
