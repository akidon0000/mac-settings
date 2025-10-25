# mac-settings

Mac環境のセットアップと設定を自動化するスクリプト集です。

## 📋 目次

- [概要](#概要)
- [セットアップスクリプト](#セットアップスクリプト)
- [使い方](#使い方)
- [スクリプト詳細](#スクリプト詳細)

## 概要

このリポジトリには、新しいMacのセットアップや既存環境の管理を効率化するための各種スクリプトが含まれています。

## セットアップスクリプト

### 🚀 環境構築

#### `setup_environment.sh` - 統合セットアップスクリプト

SSH鍵の生成とフォントのインストールを対話式メニューで実行できます。

```bash
./Scripts/setup_environment.sh
```

**含まれる機能:**
- SSH鍵の生成（GitHub用）
- 0xProto フォントのインストール
- zshrc設定のセットアップ

---

### 🔑 SSH鍵の設定

#### `setup_ssh.sh` - SSH鍵生成スクリプト

GitHub用のSSH鍵を生成し、公開鍵をクリップボードにコピーします。

```bash
./Scripts/setup_ssh.sh
```

**機能:**
- RSA 4096ビット鍵の生成
- 公開鍵を自動的にクリップボードにコピー
- GitHub登録手順の表示
- 既存の鍵がある場合の上書き確認

**実行後の手順:**
1. https://github.com/settings/ssh にアクセス
2. "New SSH key" をクリック
3. クリップボードの内容を貼り付けて保存

---

### 🔤 フォントのインストール

#### `install_0xproto_font.sh` - 0xProto フォントインストール

プログラミング向けフォント「0xProto v2.100」をインストールします。

```bash
./Scripts/install_0xproto_font.sh
```

**機能:**
- GitHubから最新版を自動ダウンロード
- `~/Library/Fonts` に自動インストール
- TTF/OTF形式に対応

**参考:** [0xProto GitHub](https://github.com/0xType/0xProto)

---

### ⚙️ zshrc設定のセットアップ

#### `setup_zshrc.sh` - zshrc設定スクリプト

リポジトリの `Files/zshrc` を `~/.zshrc` にシンボリックリンクします。

```bash
./Scripts/setup_zshrc.sh
```

**機能:**
- `Files/zshrc` を `~/.zshrc` にシンボリックリンク
- 既存の `.zshrc` がある場合は自動バックアップ
- 設定の自動反映

**含まれる設定:**
- Gitアカウント切り替え関数
- Java/Android環境変数
- コマンドエイリアス（cd, vi, sourceなど）
- mise（バージョン管理ツール）
- Homebrew
- GHQ & peco（リポジトリ管理）
- Starship（プロンプトカスタマイズ）
- Zinit（プラグインマネージャー）
  - シンタックスハイライト
  - 入力補完

---

### 📦 アプリケーションのインストール

#### `install_apps.sh` - アプリケーション一括インストール

Homebrewを使用して、開発環境に必要なアプリケーションを一括インストールします。

```bash
./Scripts/install_apps.sh
```

---

### 💾 Xcode設定のバックアップ・リストア

#### `backup_xcode.sh` - Xcode設定のバックアップ

Xcodeの設定やスニペットをバックアップします。

```bash
./Scripts/backup_xcode.sh
```

#### `restore_xcode.sh` - Xcode設定のリストア

バックアップしたXcodeの設定を復元します。

```bash
./Scripts/restore_xcode.sh
```

---

## 使い方

### 初回セットアップ

1. リポジトリをクローン
```bash
git clone git@github.com:akidon0000/mac-settings.git
cd mac-settings
```

2. 統合セットアップスクリプトを実行
```bash
./Scripts/setup_environment.sh
```

3. メニューから必要な項目を選択

### 個別スクリプトの実行

各スクリプトは個別に実行することも可能です。

```bash
# SSH鍵のみ生成
./Scripts/setup_ssh.sh

# フォントのみインストール
./Scripts/install_0xproto_font.sh

# zshrc設定のみセットアップ
./Scripts/setup_zshrc.sh

# アプリケーションのインストール
./Scripts/install_apps.sh
```

---

## スクリプト詳細

### ディレクトリ構成

```
mac-settings/
├── README.md
├── Scripts/
│   ├── setup_environment.sh      # 統合セットアップスクリプト
│   ├── setup_ssh.sh              # SSH鍵生成
│   ├── setup_zshrc.sh            # zshrc設定
│   ├── install_0xproto_font.sh   # フォントインストール
│   ├── install_apps.sh           # アプリ一括インストール
│   ├── backup_xcode.sh           # Xcode設定バックアップ
│   └── restore_xcode.sh          # Xcode設定リストア
└── Files/                         # 設定ファイル保存用
    ├── zshrc                      # zsh設定ファイル
    ├── vscode/                    # VSCode設定
    └── iTerm2/                    # iTerm2設定
```

### 必要な環境

- macOS
- Bash
- curl（フォントインストール用）
- Homebrew（アプリインストール用）

---

## ライセンス

このプロジェクトは個人用設定管理リポジトリです。

## 貢献

プルリクエストやIssueは歓迎します。
