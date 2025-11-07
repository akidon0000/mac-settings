#!/bin/bash

# Mac環境セットアップスクリプト（自動実行版）
# SSH鍵の生成、フォントインストール、zshrc設定、アプリインストールをすべて自動で実行します

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "=================================="
echo "🚀 Mac環境セットアップを開始します"
echo "=================================="
echo ""

# 確認関数
confirm_step() {
    local STEP_DESC="$1"
    read -p "▶ $STEP_DESC を実行しますか？ [y/N]: " CONFIRM
    if [[ ! "$CONFIRM" =~ ^[Yy]$ ]]; then
        echo "  ⚠️ $STEP_DESC はスキップされました。"
        return 1
    fi
    return 0
}

# 1. SSH鍵の生成
if confirm_step "1/4: SSH鍵の生成"; then
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "1/4: SSH鍵の生成"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""
    bash "$SCRIPT_DIR/setup_ssh.sh"
fi

# 2. 0xProto フォントのインストール
if confirm_step "2/4: 0xProto フォントのインストール"; then
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "2/4: 0xProto フォントのインストール"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""
    bash "$SCRIPT_DIR/install_0xproto_font.sh"
fi

# 3. zshrc設定のセットアップ
if confirm_step "3/4: zshrc設定のセットアップ"; then
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "3/4: zshrc設定のセットアップ"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""
    bash "$SCRIPT_DIR/setup_zshrc.sh"
fi

# 4. アプリのインストール
if confirm_step "4/4: アプリのインストール"; then
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "4/4: アプリのインストール"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""
    bash "$SCRIPT_DIR/install_apps.sh"
fi

# 完了メッセージ
echo ""
echo "=================================="
echo "✅ すべてのセットアップが完了しました！"
echo "=================================="
echo ""
echo "🎉 お疲れさまでした！"
echo ""
