#!/bin/bash

# 0xProto フォントインストールスクリプト
# 最新版の0xProtoフォントをダウンロードしてインストールします

set -e

FONT_VERSION="2.100"
FONT_NAME="0xProto"
DOWNLOAD_URL="https://github.com/0xType/0xProto/releases/download/${FONT_VERSION}/0xProto_${FONT_VERSION}.zip"
TEMP_DIR=$(mktemp -d)
FONT_DIR="$HOME/Library/Fonts"

echo "🔤 0xProto フォント (v${FONT_VERSION}) のインストールを開始します..."

# フォントディレクトリの確認
if [ ! -d "$FONT_DIR" ]; then
    echo "📁 フォントディレクトリを作成します..."
    mkdir -p "$FONT_DIR"
fi

# 一時ディレクトリに移動
cd "$TEMP_DIR"

# フォントファイルのダウンロード
echo "⬇️  フォントをダウンロードしています..."
if ! curl -L -o "${FONT_NAME}.zip" "$DOWNLOAD_URL"; then
    echo "❌ ダウンロードに失敗しました"
    rm -rf "$TEMP_DIR"
    exit 1
fi

# ZIPファイルの解凍
echo "📦 解凍しています..."
unzip -q "${FONT_NAME}.zip"

# フォントファイルのインストール
echo "📝 フォントをインストールしています..."
INSTALLED_COUNT=0

# .ttf ファイルをインストール
if ls *.ttf 1> /dev/null 2>&1; then
    for font in *.ttf; do
        cp "$font" "$FONT_DIR/"
        echo "  ✓ $font をインストールしました"
        ((INSTALLED_COUNT++))
    done
fi

# .otf ファイルをインストール
if ls *.otf 1> /dev/null 2>&1; then
    for font in *.otf; do
        cp "$font" "$FONT_DIR/"
        echo "  ✓ $font をインストールしました"
        ((INSTALLED_COUNT++))
    done
fi

# 解凍されたディレクトリ内のフォントファイルもチェック
for dir in */; do
    if [ -d "$dir" ]; then
        if ls "$dir"*.ttf 1> /dev/null 2>&1; then
            for font in "$dir"*.ttf; do
                cp "$font" "$FONT_DIR/"
                echo "  ✓ $(basename "$font") をインストールしました"
                ((INSTALLED_COUNT++))
            done
        fi
        if ls "$dir"*.otf 1> /dev/null 2>&1; then
            for font in "$dir"*.otf; do
                cp "$font" "$FONT_DIR/"
                echo "  ✓ $(basename "$font") をインストールしました"
                ((INSTALLED_COUNT++))
            done
        fi
    fi
done

# 一時ディレクトリの削除
cd -
rm -rf "$TEMP_DIR"

if [ $INSTALLED_COUNT -eq 0 ]; then
    echo "❌ フォントファイルが見つかりませんでした"
    exit 1
fi

echo ""
echo "✅ 0xProto フォントのインストールが完了しました！"
echo "📊 ${INSTALLED_COUNT} 個のフォントファイルをインストールしました"
echo ""
echo "📝 次のステップ:"
echo "  - ターミナルやエディタの設定で '0xProto' フォントを選択してください"
echo "  - 一部のアプリケーションでは再起動が必要な場合があります"
echo ""
