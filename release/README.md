## 使い方
* fr-css-framework/ でscriptを実行
  `bash script-path/release.sh`

* 実行する内容は、下記リリース手順のmerge､リリースタグ作成以外
  https://github.com/fastretailing/fr-css-framework/wiki/Release-Workflow
  
* リリースノートの内容は下記コマンドで取得可能
  `bash script-path/generate_release_notes.sh`

## 前提条件

* gitコマンドでgithubのfastretailing/fr-css-framework にアクセス可能

* hub/jpコマンドをインストール済み
  `brew install hub jq` 

* 最新のdevブランチを取得済み



## 設定内容

### release.sh

1. VERSION  e.x. 2.0.9
2. ASSIGNER e.x. mem-MImada

### dev_release_note.txt(PRの内容)
3. dev_release_note.txt(一行目:タイトル)

### master_release_note.txt(PRの内容)
4. master_release_note.txt(一行目:タイトル)