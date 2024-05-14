画像表示リンク
https://raw.githubusercontent.com/akidon0000/env_setup/main/vscode/icon/vscode-icon.png

CSS表示リンク
https://raw.githubusercontent.com/akidon0000/env_setup/main/vscode/icon/vscode-icon-custom.css


![VSCcode](vscode-icon.png)

# やり方
1、拡張機能「Custom CSS and JS Loader」をインストールする
2、comand + shift + p でコマンドパレットを開き、「基本設定: ユーザー設定(JSON)」を開く
3、以下のコードを追加する
必要であれば、自分でCSSファイルを作成して、URLを指定する
```json
"vscode_custom_css.imports": [
    "https://raw.githubusercontent.com/akidon0000/env_setup/main/vscode/icon/vscode-icon-custom.css"
],
```
4、コマンドパレットを開き、「Enable Custom CSS ans JS」を実行し、vscodeを再起動する


# 謝辞
製作者：

さわらつき さん
X アカウント [@sawaratsuki1004](https://twitter.com/sawaratsuki1004)
GitHub アカウント [SAWARATSUKI](https://github.com/SAWARATSUKI/KawaiiLogos/pulls)

https://twitter.com/sawaratsuki1004/status/1784219617839456403/photo/1
