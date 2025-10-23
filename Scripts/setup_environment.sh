#!/bin/bash

# Mac環境セットアップスクリプト
# SSH鍵の生成と0xProtoフォントのインストールを実行します

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "=================================="
echo "🚀 Mac環境セットアップを開始します"
echo "=================================="
echo ""

# メニュー表示
echo "実行する項目を選択してください:"
echo "  1) SSH鍵の生成"
echo "  2) 0xProto フォントのインストール"
echo "  3) 両方実行"
echo "  4) キャンセル"
echo ""
read -p "選択 (1-4): " choice

case $choice in
    1)
        echo ""
        echo "📌 SSH鍵の生成を実行します..."
        echo ""
        bash "$SCRIPT_DIR/setup_ssh.sh"
        ;;
    2)
        echo ""
        echo "📌 0xProto フォントのインストールを実行します..."
        echo ""
        bash "$SCRIPT_DIR/install_0xproto_font.sh"
        ;;
    3)
        echo ""
        echo "📌 すべてのセットアップを実行します..."
        echo ""

        # SSH鍵の生成
        echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        echo "1/2: SSH鍵の生成"
        echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        echo ""
        bash "$SCRIPT_DIR/setup_ssh.sh"

        echo ""
        echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        echo "2/2: 0xProto フォントのインストール"
        echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        echo ""
        bash "$SCRIPT_DIR/install_0xproto_font.sh"

        echo ""
        echo "=================================="
        echo "✅ すべてのセットアップが完了しました！"
        echo "=================================="
        ;;
    4)
        echo ""
        echo "❌ セットアップをキャンセルしました"
        exit 0
        ;;
    *)
        echo ""
        echo "❌ 無効な選択です"
        exit 1
        ;;
esac

echo ""
echo "🎉 完了しました！"
echo ""
