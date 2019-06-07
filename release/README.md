## 前提条件/Prerequisite

* gitコマンドでgithubのfastretailing/fr-css-framework にアクセス可能
  Be able to access github fastretailing/fr-css-framework repo with git command
* hubコマンドをインストール済み
  hub command installed
  `brew install hub`
* hubコマンドでgithubにアクセス可能
  Be able to access github with hub command
  https://hub.github.com/hub.1.html#github-oauth-authentication

* 最新のdevブランチを取得済み
  Pulled the latest dev branch

## 設定内容/Settings

### release.sh
1. VERSION  e.x. 2.0.9
2. ASSIGNER e.x. mem-XXXXX

### release_note_dev.txt (PRの内容/PR description)
3. release_note_dev.txt (一行目:タイトル/First Line: dev update PR Title)

### release_note_master.txt(PRの内容/PR description)
4. release_note_master.txt (一行目:タイトル/First Line: master build PR Title)

## 使い方/How to
* fr-css-framework/ でscriptを実行
  To release, use following script in fr-css-framework/
  `bash scripts/release.sh`

* 実行する内容は、下記リリース手順のmerge､リリースタグ作成以外
  This script includes all release tasks except merges and release tag creation
  https://github.com/fastretailing/fr-css-framework/wiki/Release-Workflow

* リリースノートの内容は下記コマンドで取得可能
  To get release note, use below command
  `bash scripts/generate_release_notes.sh`

## Reference
* [hub](https://github.com/github/hub)
* [jq](https://github.com/stedolan/jq)
