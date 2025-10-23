#!/bin/bash

# Xcodeの設定を復元するスクリプト

set -e

# 使い方を表示
if [ $# -eq 0 ]; then
    echo "使い方: $0 <バックアップディレクトリのパス>"
    echo ""
    echo "例:"
    echo "  $0 ~/Downloads/xcode_backup_20231023_123456"
    echo ""
    echo "または、このスクリプトと同じディレクトリにある xcode フォルダから復元:"
    echo "  $0 --from-repo"
    exit 1
fi

# バックアップ元の決定
if [ "$1" = "--from-repo" ]; then
    SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
    BACKUP_DIR="$SCRIPT_DIR/xcode"
    echo "📦 リポジトリ内のXcode設定から復元します..."
else
    BACKUP_DIR="$1"
    echo "📦 指定されたディレクトリからXcode設定を復元します..."
fi

echo "復元元: $BACKUP_DIR"

# バックアップディレクトリの存在確認
if [ ! -d "$BACKUP_DIR" ]; then
    echo "❌ エラー: バックアップディレクトリが見つかりません: $BACKUP_DIR"
    exit 1
fi

# 確認メッセージ
echo ""
echo "⚠️  この操作により、現在のXcode設定が上書きされます。"
read -p "続行しますか？ (y/N): " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "キャンセルされました。"
    exit 0
fi

echo ""
echo "復元を開始します..."

# Xcodeが起動している場合は警告
if pgrep -x "Xcode" > /dev/null; then
    echo "⚠️  Xcodeが起動しています。設定を反映するために、復元後にXcodeを再起動してください。"
    echo ""
fi

# 必要なディレクトリを作成
mkdir -p "$HOME/Library/Developer/Xcode/UserData"

# Preferences ファイルの復元
echo "- Preferences を復元中..."
if [ -f "$BACKUP_DIR/com.apple.dt.Xcode.plist" ]; then
    cp "$BACKUP_DIR/com.apple.dt.Xcode.plist" "$HOME/Library/Preferences/"
    echo "  ✓ com.apple.dt.Xcode.plist"
fi

if [ -f "$BACKUP_DIR/com.apple.dt.xcodebuild.plist" ]; then
    cp "$BACKUP_DIR/com.apple.dt.xcodebuild.plist" "$HOME/Library/Preferences/"
    echo "  ✓ com.apple.dt.xcodebuild.plist"
fi

# KeyBindings の復元
if [ -d "$BACKUP_DIR/KeyBindings" ]; then
    echo "- KeyBindings を復元中..."
    rm -rf "$HOME/Library/Developer/Xcode/UserData/KeyBindings"
    cp -r "$BACKUP_DIR/KeyBindings" "$HOME/Library/Developer/Xcode/UserData/"
    echo "  ✓ KeyBindings"
fi

# CodeSnippets の復元
if [ -d "$BACKUP_DIR/CodeSnippets" ]; then
    echo "- CodeSnippets を復元中..."
    rm -rf "$HOME/Library/Developer/Xcode/UserData/CodeSnippets"
    cp -r "$BACKUP_DIR/CodeSnippets" "$HOME/Library/Developer/Xcode/UserData/"
    echo "  ✓ CodeSnippets"
fi

# FontAndColorThemes の復元
if [ -d "$BACKUP_DIR/FontAndColorThemes" ]; then
    echo "- FontAndColorThemes を復元中..."
    rm -rf "$HOME/Library/Developer/Xcode/UserData/FontAndColorThemes"
    cp -r "$BACKUP_DIR/FontAndColorThemes" "$HOME/Library/Developer/Xcode/UserData/"
    echo "  ✓ FontAndColorThemes"
fi

# Templates の復元
if [ -d "$BACKUP_DIR/Templates" ]; then
    echo "- Templates を復元中..."
    mkdir -p "$HOME/Library/Developer/Xcode/Templates"
    cp -r "$BACKUP_DIR/Templates"/* "$HOME/Library/Developer/Xcode/Templates/"
    echo "  ✓ Templates"
fi

# キャッシュをクリア
echo ""
echo "- 設定キャッシュをクリア中..."
defaults read com.apple.dt.Xcode > /dev/null 2>&1 || true

echo ""
echo "✅ 復元が完了しました！"
echo ""
echo "📝 次の手順:"
echo "  1. Xcodeが起動している場合は、再起動してください"
echo "  2. Xcode > Settings で設定が反映されているか確認してください"
