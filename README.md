# dotfiles

Nix flake + Home Manager による dotfiles 管理。

## セットアップ

### 1. Nix のインストール

[公式 Nix Installer](https://github.com/NixOS/nix-installer) を使用:

```sh
curl -sSfL https://artifacts.nixos.org/nix-installer | sh -s -- install
```

- インストール中に flakes を有効化するか聞かれるので `Y` を選択する

### 2. リポジトリのクローンと symlink 作成

```sh
git clone git@github.com:kshiva1126/dotfiles.git ~/path/to/dotfiles
ln -s ~/path/to/dotfiles ~/dotfiles
```

### 3. Home Manager の適用

```sh
nix run home-manager -- switch --flake ~/dotfiles -b backup
```

## 設定の変更

`~/dotfiles/` 内のファイルを編集して再適用:

```sh
home-manager switch --flake ~/dotfiles -b backup
```

## 構成

```
flake.nix          # エントリポイント
home.nix           # パッケージ・セッション変数・モジュール読み込み
modules/
  zsh.nix          # zsh 設定
  neovim.nix       # Neovim 設定
  ghostty.nix      # Ghostty 設定
  starship.nix     # Starship 設定
  git.nix          # Git 設定
config/
  nvim/            # Neovim 設定ファイル群
  starship.toml    # Starship テーマ設定
```
