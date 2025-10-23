#!/bin/bash

# SSH鍵セットアップスクリプト
# GitHub用のSSH鍵を生成し、公開鍵をクリップボードにコピーします

set -e

echo "🔑 SSH鍵のセットアップを開始します..."

# .sshディレクトリの作成（既に存在する場合はスキップ）
if [ ! -d ~/.ssh ]; then
    echo "📁 ~/.ssh ディレクトリを作成します..."
    mkdir -p ~/.ssh
    chmod 700 ~/.ssh
else
    echo "✅ ~/.ssh ディレクトリは既に存在します"
fi

# SSH鍵が既に存在するかチェック
if [ -f ~/.ssh/id_rsa ] || [ -f ~/.ssh/id_rsa.pub ]; then
    echo "⚠️  SSH鍵が既に存在します"
    read -p "上書きしますか？ (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "❌ SSH鍵の生成をキャンセルしました"
        exit 0
    fi
fi

# メールアドレスの入力
read -p "GitHubのメールアドレスを入力してください: " email

if [ -z "$email" ]; then
    echo "❌ メールアドレスが入力されていません"
    exit 1
fi

# SSH鍵の生成
echo "🔐 SSH鍵を生成しています..."
ssh-keygen -t rsa -b 4096 -C "$email" -f ~/.ssh/id_rsa -N ""

# パーミッションの設定
chmod 600 ~/.ssh/id_rsa
chmod 644 ~/.ssh/id_rsa.pub

# 公開鍵をクリップボードにコピー
echo "📋 公開鍵をクリップボードにコピーしています..."
cat ~/.ssh/id_rsa.pub | pbcopy

echo ""
echo "✅ SSH鍵の生成が完了しました！"
echo "📋 公開鍵がクリップボードにコピーされました"
echo ""
echo "次のステップ:"
echo "1. ブラウザで以下のURLを開いてください:"
echo "   https://github.com/settings/ssh"
echo "2. 'New SSH key' をクリック"
echo "3. Title に適当な名前を入力（例: Mac）"
echo "4. Key にクリップボードの内容を貼り付け（Cmd+V）"
echo "5. 'Add SSH key' をクリック"
echo ""
echo "🔍 公開鍵の内容:"
cat ~/.ssh/id_rsa.pub
echo ""
