#!/bin/bash

# Mac用アプリ自動インストールスクリプト
# Homebrewを使用してアプリ.txtに記載されているアプリをインストールします

set -e

echo "======================================"
echo "アプリケーションのインストールを開始します"
echo "======================================"

# Homebrewがインストールされているか確認
if ! command -v brew &> /dev/null; then
    echo "Homebrewをインストール中"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

echo "Homebrewを更新中..."
brew update

# Homebrew Caskでインストールするアプリのリスト
declare -A cask_apps=(
    ["Clipy"]="clipy"
    ["CotEditor"]="coteditor"
    ["Discord"]="discord"
    ["Fork"]="fork"
    ["HiddenBar"]="hiddenbar"
    ["iTerm"]="iterm2"
    ["Karabiner"]="karabiner-elements"
    ["LogiOptions"]="logi-options-plus"
    ["MeetingBar"]="meetingbar"
    ["Mist"]="mist"
    ["Notion"]="notion"
    ["Proxyman"]="proxyman"
    ["RunCat"]="runcat"
    ["Slack"]="slack"
    ["Xcodes"]="xcodes"
    ["chrome"]="google-chrome"
    ["VScode"]="visual-studio-code"
)

# Homebrew Formulaでインストールするツール
declare -a formula_apps=(
    "mint"
)

echo ""
echo "======================================"
echo "アプリケーションのインストール"
echo "======================================"

# Caskアプリのインストール
for app_name in "${!cask_apps[@]}"; do
    cask_name="${cask_apps[$app_name]}"
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
echo "開発ツールのインストール"
echo "======================================"

# Formulaツールのインストール
for formula in "${formula_apps[@]}"; do
    echo ""
    echo "[$formula] をインストール中..."

    if brew list "$formula" &> /dev/null; then
        echo "  ✓ $formula は既にインストールされています"
    else
        if brew install "$formula"; then
            echo "  ✓ $formula のインストールに成功しました"
        else
            echo "  ✗ $formula のインストールに失敗しました"
        fi
    fi
done

echo ""
echo "======================================"
echo "インストール完了"
echo "======================================"
echo ""
echo "インストールされたアプリを確認:"
echo "  brew list --cask"
echo ""
