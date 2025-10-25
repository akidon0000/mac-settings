#!/bin/bash

# zshrc設定スクリプト
# リポジトリのzshrcをホームディレクトリにシンボリックリンクします

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ZSHRC="$SCRIPT_DIR/../Files/zshrc"
HOME_ZSHRC="$HOME/.zshrc"

echo "=================================="
echo "🔧 zshrc設定を開始します"
echo "=================================="
echo ""

# リポジトリのzshrcファイルが存在するか確認
if [ ! -f "$REPO_ZSHRC" ]; then
    echo "❌ エラー: $REPO_ZSHRC が見つかりません"
    exit 1
fi

# 既存の.zshrcがある場合の処理
if [ -e "$HOME_ZSHRC" ] || [ -L "$HOME_ZSHRC" ]; then
    echo "⚠️  既存の .zshrc が見つかりました"

    # シンボリックリンクの場合
    if [ -L "$HOME_ZSHRC" ]; then
        CURRENT_TARGET=$(readlink "$HOME_ZSHRC")
        if [ "$CURRENT_TARGET" = "$REPO_ZSHRC" ]; then
            echo "✅ 既に正しくシンボリックリンクが設定されています"
            echo ""
            echo "🔄 設定を反映します..."
            zsh -c "source $HOME_ZSHRC" 2>/dev/null || true
            echo "✅ 完了しました！"
            exit 0
        fi
    fi

    # バックアップを作成するか確認
    read -p "既存の .zshrc をバックアップして置き換えますか？ (y/n): " confirm
    if [ "$confirm" != "y" ] && [ "$confirm" != "Y" ]; then
        echo "❌ セットアップをキャンセルしました"
        exit 0
    fi

    # バックアップを作成
    BACKUP_FILE="$HOME/.zshrc.backup.$(date +%Y%m%d_%H%M%S)"
    echo "📦 バックアップを作成します: $BACKUP_FILE"

    if [ -L "$HOME_ZSHRC" ]; then
        rm "$HOME_ZSHRC"
    else
        mv "$HOME_ZSHRC" "$BACKUP_FILE"
        echo "✅ バックアップ完了: $BACKUP_FILE"
    fi
    echo ""
fi

# シンボリックリンクを作成
echo "🔗 シンボリックリンクを作成します..."
ln -s "$REPO_ZSHRC" "$HOME_ZSHRC"
echo "✅ シンボリックリンク作成完了"
echo "   $HOME_ZSHRC -> $REPO_ZSHRC"
echo ""

# 設定を反映
echo "🔄 設定を反映します..."
zsh -c "source $HOME_ZSHRC" 2>/dev/null || true
echo ""

echo "=================================="
echo "✅ zshrc設定が完了しました！"
echo "=================================="
echo ""
echo "📝 次のコマンドで設定を反映してください:"
echo "   source ~/.zshrc"
echo ""
echo "または新しいターミナルを開いてください。"
echo ""
