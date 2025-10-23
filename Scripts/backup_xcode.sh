#!/bin/bash

# Xcode設定をDownloadsフォルダにバックアップするスクリプト

set -e

# バックアップ先ディレクトリ
BACKUP_DIR="$HOME/Downloads/xcode_backup_$(date +%Y%m%d_%H%M%S)"

echo "📦 Xcodeの設定をバックアップしています..."
echo "バックアップ先: $BACKUP_DIR"

# バックアップディレクトリを作成
mkdir -p "$BACKUP_DIR"

# Xcode環境設定ファイル
echo "- Preferences をバックアップ中..."
if [ -f "$HOME/Library/Preferences/com.apple.dt.Xcode.plist" ]; then
    cp "$HOME/Library/Preferences/com.apple.dt.Xcode.plist" "$BACKUP_DIR/"
fi

if [ -f "$HOME/Library/Preferences/com.apple.dt.xcodebuild.plist" ]; then
    cp "$HOME/Library/Preferences/com.apple.dt.xcodebuild.plist" "$BACKUP_DIR/"
fi

# UserDataディレクトリ内の各種設定
USERDATA_DIR="$HOME/Library/Developer/Xcode/UserData"

# キーバインディング
if [ -d "$USERDATA_DIR/KeyBindings" ]; then
    echo "- KeyBindings をバックアップ中..."
    cp -r "$USERDATA_DIR/KeyBindings" "$BACKUP_DIR/"
fi

# コードスニペット
if [ -d "$USERDATA_DIR/CodeSnippets" ]; then
    echo "- CodeSnippets をバックアップ中..."
    cp -r "$USERDATA_DIR/CodeSnippets" "$BACKUP_DIR/"
fi

# フォントとカラーテーマ
if [ -d "$USERDATA_DIR/FontAndColorThemes" ]; then
    echo "- FontAndColorThemes をバックアップ中..."
    cp -r "$USERDATA_DIR/FontAndColorThemes" "$BACKUP_DIR/"
fi

# IDEテンプレート（もしあれば）
if [ -d "$HOME/Library/Developer/Xcode/Templates" ]; then
    echo "- Templates をバックアップ中..."
    cp -r "$HOME/Library/Developer/Xcode/Templates" "$BACKUP_DIR/"
fi

# バックアップ完了
echo ""
echo "✅ バックアップが完了しました！"
echo "📁 保存先: $BACKUP_DIR"
echo ""
echo "バックアップ内容:"
ls -la "$BACKUP_DIR"
