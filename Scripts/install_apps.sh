#!/bin/bash

# Mac用アプリ自動インストールスクリプト（Bash 3.2対応版）
# Homebrewを使用してアプリを自動インストールします

set -e

echo "======================================"
echo "アプリケーションのインストールを開始します"
echo "======================================"

# =======================
# スクリプト開始時に sudo 認証（1回だけ）
# =======================
sudo -v

# sudo キャッシュを有効に保つ（オプション）
# バックグラウンドで sudo キャッシュを更新し続ける
# (Ctrl+Cでスクリプト終了時に自動停止)
( while true; do sudo -v; sleep 60; done ) &

# =======================
# Homebrewがインストールされているか確認
# =======================
if ! command -v brew &> /dev/null; then
    echo "Homebrewをインストール中"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

echo "Homebrewを更新中..."
brew update

# =======================
# Homebrew Caskでインストールするアプリ
# =======================
cask_apps=(
  "Clipy:clipy"
  "Figma:figma"
  "CotEditor:coteditor"
  "Discord:discord"
  "Fork:fork"
  "iTerm:iTerm2"
  "MeetingBar:meetingbar"
  "Notion:notion"
  "Proxyman:proxyman"
  "Slack:slack"
  "Xcodes:xcodes"
  "Google Chrome:google-chrome"
  "Visual Studio Code:visual-studio-code"
  "Mist:mist"
  "logioptionsplus:logi-options-plus"
  "Hidden Bar:hiddenbar"
)

# =======================
# Homebrew Formulaでインストールするツール
# =======================
formula_apps=(
  "mint"
)

echo ""
echo "======================================"
echo "アプリケーションのインストール"
echo "======================================"

# Caskアプリのインストール
for pair in "${cask_apps[@]}"; do
  app_name="${pair%%:*}"
  cask_name="${pair##*:}"

  echo ""
  echo "[$app_name] をインストール中..."

  if brew list --cask "$cask_name" &> /dev/null; then
      echo "  ✓ $app_name は既にインストールされています"
  else
      if brew install --cask "$cask_name"; then
          echo "  ✓ $app_name のインストールに成功しました"
      else
          echo "  ✗ $app_name のインストールに失敗しました"
      fi
  fi
done

echo ""
echo "======================================"
echo "インストールした全てのアプリを起動"
echo "======================================"

# 失敗したアプリ名を記録する配列
failed_apps=()

for pair in "${cask_apps[@]}"; do
  app_name="${pair%%:*}"
  cask_name="${pair##*:}"

  echo "[$app_name] を起動中..."

  # アプリを起動してみる（出力非表示）
  if open -a "$app_name" &>/dev/null; then
      echo "  ✓ $app_name を起動しました"
  else
      echo "  ⚠️ $app_name の起動に失敗しました。再インストールを試みます..."

      # 再インストール（出力を抑制）
      if brew reinstall --quiet --cask "$cask_name" &>/dev/null; then
          echo "  ↪ $app_name の再インストールに成功。再度起動を試みます..."

          if open -a "$app_name" &>/dev/null; then
              echo "  ✓ $app_name を再インストール後に起動しました"
          else
              echo "  ✗ $app_name の再起動にも失敗しました。"
              failed_apps+=("$app_name")
          fi
      else
          echo "  ✗ $app_name の再インストールに失敗しました。"
          failed_apps+=("$app_name")
      fi
  fi
done

echo ""
echo "======================================"
echo "インストール・起動結果のまとめ"
echo "======================================"

if [ ${#failed_apps[@]} -eq 0 ]; then
  echo "🎉 すべてのアプリが正常に起動しました！"
else
  echo "⚠️ 以下のアプリは起動または再インストールに失敗しました："
  for app in "${failed_apps[@]}"; do
    echo "  - $app"
  done
  echo ""
  echo "手動で確認または再インストールを行ってください。"
fi


echo ""
echo "======================================"
echo "RunCat（App Store）を開く"
echo "======================================"

RUNCAT_URL="macappstore://apps.apple.com/jp/app/runcat/id1429033973?mt=12"

echo "RunCat のApp Storeページを開きます..."
if open "$RUNCAT_URL"; then
  echo "  ✓ App StoreでRunCatが開きました。インストールを行ってください。"
else
  echo "  ✗ RunCatのページを開けませんでした。以下のURLを手動で開いてください："
  echo "    https://apps.apple.com/jp/app/runcat/id1429033973?mt=12"
fi


echo ""
echo "======================================"
echo "eikana を GitHub からダウンロード"
echo "======================================"

# ダウンロードURL
EIKANA_URL="https://github.com/iMasanari/cmd-eikana/releases/download/v2.2.3/eikana-2.2.3.app.zip"
# 一時ダウンロード先
TMP_ZIP="/tmp/eikana-2.2.3.app.zip"
# 展開先アプリ
EIKANA_APP="/Applications/⌘英かな.app"

if [ -d "$EIKANA_APP" ]; then
    echo "  ✓ eikana は既にインストールされています。ダウンロードと展開をスキップします。"
else
    echo "eikana をダウンロード中..."
    if curl -L -o "$TMP_ZIP" "$EIKANA_URL"; then
        echo "  ✓ ダウンロード完了: $TMP_ZIP"

        echo "eikana を /Applications に展開..."
        if sudo ditto "$TMP_ZIP" "$EIKANA_APP"; then
            echo "  ✓ 展開完了: $EIKANA_APP"
        else
            echo "  ✗ 展開に失敗しました"
        fi
    else
        echo "  ✗ ダウンロードに失敗しました"
    fi

    # 一時ファイルを削除
    rm -f "$TMP_ZIP"
fi

echo "eikana を起動中..."
if open "$EIKANA_APP"; then
    echo "  ✓ eikana を起動しました"
else
    echo "  ✗ eikana の起動に失敗しました"
fi
