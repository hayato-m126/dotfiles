# Recommended SSH Configuration Collection

## Usage

```shell
% git clone https://gitlab.com/clear-code/ssh.d.git ~/.ssh
```

If you are already using SSH, you can install while automatically inheriting existing settings as follows:

```shell
% curl https://gitlab.com/clear-code/ssh.d/-/raw/main/install.sh | bash
```

## Customization

Place any configuration files (with `.conf` extension) under `~/.ssh/conf.d` to apply them.

```shell
.
├── LICENSE
├── README.md
├── conf.d      # Configuration files directory
│   └── template.conf # Sample configuration
├── global.conf # Recommended settings
└── config      # Loads files from conf.d
```

## When SSH connection to GitHub fails due to strict checking

```shell
hyt@MBA-M3 ~/.ssh> ssh -T git@github.com
No ED25519 host key is known for github.com and you have requested strict checking.
Host key verification failed.
```

<https://docs.github.com/ja/authentication/keeping-your-account-and-data-secure/githubs-ssh-key-fingerprints>

Create $HOME/.ssh/known_hosts and input the content from the above link.
