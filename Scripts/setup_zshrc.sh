#!/bin/bash

# ==================================
# 🧰 zshrc設定スクリプト
# リポジトリのzshrcをホームディレクトリにシンボリックリンクします
# さらに Homebrew と mise がインストールされていない場合は自動でセットアップします
# ==================================

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ZSHRC="$SCRIPT_DIR/../Files/zshrc"
HOME_ZSHRC="$HOME/.zshrc"

echo "=================================="
echo "🔧 zshrc設定を開始します"
echo "=================================="
echo ""

# --- Homebrew の確認・インストール ---
if ! command -v brew &>/dev/null; then
    echo "🍺 Homebrew が見つかりません。インストールを開始します..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo "✅ Homebrew のインストールが完了しました。"

    # パスを通す（Intel / Apple Silicon 両対応）
    if [ -d "/opt/homebrew/bin" ]; then
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
        eval "$(/opt/homebrew/bin/brew shellenv)"
    elif [ -d "/usr/local/bin" ]; then
        echo 'eval "$(/usr/local/bin/brew shellenv)"' >> ~/.zprofile
        eval "$(/usr/local/bin/brew shellenv)"
    fi
else
    echo "✅ Homebrew は既にインストールされています。"
fi

echo ""

# --- mise の確認・インストール ---
if ! command -v mise &>/dev/null; then
    echo "📦 mise が見つかりません。Homebrewでインストールします..."
    brew install mise
    echo "✅ mise のインストールが完了しました。"
else
    echo "✅ mise は既にインストールされています。"
fi

echo ""

# --- zshrc ファイルのセットアップ ---
# リポジトリの zshrc が存在するか確認
if [ ! -f "$REPO_ZSHRC" ]; then
    echo "❌ エラー: $REPO_ZSHRC が見つかりません"
    exit 1
fi

# 既存の .zshrc の処理
if [ -e "$HOME_ZSHRC" ] || [ -L "$HOME_ZSHRC" ]; then
    echo "⚠️  既存の .zshrc が見つかりました"

    if [ -L "$HOME_ZSHRC" ]; then
        CURRENT_TARGET=$(readlink "$HOME_ZSHRC")
        if [ "$CURRENT_TARGET" = "$REPO_ZSHRC" ]; then
            echo "✅ 既に正しいシンボリックリンクが設定されています"
            echo ""
            echo "🔄 設定を反映します..."
            zsh -c "source $HOME_ZSHRC" 2>/dev/null || true
            echo "✅ 完了しました！"
            exit 0
        fi
    fi

    read -p "既存の .zshrc をバックアップして置き換えますか？ (y/n): " confirm
    if [[ "$confirm" =~ ^[Yy]$ ]]; then
        BACKUP_FILE="$HOME/.zshrc.backup.$(date +%Y%m%d_%H%M%S)"
        echo "📦 バックアップを作成します: $BACKUP_FILE"

        if [ -L "$HOME_ZSHRC" ]; then
            rm "$HOME_ZSHRC"
        else
            mv "$HOME_ZSHRC" "$BACKUP_FILE"
            echo "✅ バックアップ完了: $BACKUP_FILE"
        fi
    else
        echo "❌ セットアップをキャンセルしました"
        exit 0
    fi
    echo ""
fi

# --- シンボリックリンク作成 ---
echo "🔗 シンボリックリンクを作成します..."
ln -s "$REPO_ZSHRC" "$HOME_ZSHRC"
echo "✅ シンボリックリンク作成完了"
echo "   $HOME_ZSHRC -> $REPO_ZSHRC"
echo ""

# --- 設定を反映 ---
# 設定を反映
echo "🔄 設定を反映します..."
if command -v zsh &>/dev/null; then
    zsh -c "source $HOME_ZSHRC" 2>/dev/null || true
else
    echo "⚠️ Zsh がインストールされていないため設定を反映できません。"
fi
echo ""


echo "=================================="
echo "✅ zshrc設定が完了しました！"
echo "=================================="
echo ""
