# sshのオススメ設定集

## 使い方

```shell
% git clone https://gitlab.com/clear-code/ssh.d.git ~/.ssh
```

すでにsshを運用中の場合、以下のようにすると既存の設定を自動的に引き継ぐ形でインストールできます。

```shell
% curl https://gitlab.com/clear-code/ssh.d/-/raw/main/install.sh | bash
```

## カスタマイズ

`~/.ssh/conf.d`配下に任意の設定ファイル(拡張子が`.conf`)を配置すると
適用されます。

```shell
.
├── LICENSE
├── README.md
├── conf.d      # 設定ファイル置き場
│   └── template.conf # サンプル設定
├── global.conf # オススメな設定
└── config      # conf.d配下を読み込ませる
```

## githubへのssh接続時にstrict checkingで引っかかる

```shell
hyt@MBA-M3 ~/.ssh> ssh -T git@github.com
No ED25519 host key is known for github.com and you have requested strict checking.
Host key verification failed.
```

<https://docs.github.com/ja/authentication/keeping-your-account-and-data-secure/githubs-ssh-key-fingerprints>

$HOME/.ssh/known_hostsを作って、上記の内容を入力しておけばよい。
