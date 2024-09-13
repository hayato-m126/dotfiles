# dotfiles

設定ファイルを管理するリポジトリ

## environment

- Ubuntu 22.04 / 24.04
- macOS Sonoma

## usage

1. HOMEフォルダ内に、設定ファイルを置く。
2. ./install.shで設定を反映させる。

## reference

ssh設定は以下のものを参考にした
https://gitlab.com/clear-code/ssh.d

## vscodeのgit設定

vscodeでgit commitで常にsinged-offをつける

<https://qiita.com/ItSANgo/items/135f91c08cf8380cab82>

一度設定したら、vscodeの同期機能で同期される。

## macの場合

macのデフォルトのシェルはzshなので、ubuntuと同じbashに直しておくことで、共通化する。
実際はbashからfishを呼んでいる

```shell
chsh -s /bin/bash
```
