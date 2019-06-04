#!/bin/bash

set -e

VERSION='3.0.4'
ASSIGNEES='spycat9'
REVIEWERS="'alvincamposo'"

OLD_VERSION=`sed -n 's/  "version": "\([0-9]*\.[0-9]*\.[0-9]*\)",/\1/p' package.json`
DATE=`date +%Y%m%d`

DEV_BRANCH="UpdateTo${VERSION}"
MASTER_BRANCH="Build${DATE}v${VERSION}"
SCRIPT_DIR=$(cd $(dirname $0);pwd)


echo
echo "Release workflow"
echo "Update version, from dev branch"

echo $OLD_VERSION
echo $VERSION
echo $DATE
echo $DEV_BRANCH
echo $MASTER_BRANCH

echo "1. checkout dev branch"
git checkout dev

echo "2. create branch from dev"
git checkout -b $DEV_BRANCH

echo "3. change package.json version"
sed -i -e "s/\"version\": \"${OLD_VERSION}\"/\"version\": \"${VERSION}\"/" package.json
git add package.json
git commit -m "Changed package.json version"


echo "4. create PR, then set destination PR -> dev branch"
git push origin  $DEV_BRANCH
hub pull-request -F $SCRIPT_DIR/dev_release_note.txt --edit --push --base "dev" --reviewer $REVIEWERS --assign $ASSIGNEES --labels "Release"


echo "Merge to master branch & create new build"

echo "1. create branch from (the branch created above)"
git checkout -b $MASTER_BRANCH

echo "2. npm install"
npm install

echo "3. npm run build:prod"
npm run build:prod

echo "4. commit push the generated build files on #2"
git add package-lock.json public/assets/*
git commit -m "Production build update"

echo "5. tag the commit"
git tag -a v${VERSION} -m 'prod build'

echo "6. create PR (with release notes), then set destination PR -> master branch"
git push origin  $MASTER_BRANCH
hub pull-request -F $SCRIPT_DIR/master_release_note.txt --edit --push --base "master" --reviewer $REVIEWERS --assign $ASSIGNEES --labels "Release"


##When release PRs need to be merged.
#1. Merge first the -> dev PR
#2. Merge second the -> master PR
#3. Create release from tag on github```

echo
echo "done!"
echo

