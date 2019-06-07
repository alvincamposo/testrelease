#!/bin/bash

set -e

VERSION='3.0.32'
ASSIGNEES=''
REVIEWERS="'alvincamposo','spycat9'"

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

# echo "Merge to master branch & create new build"

# echo "1. create branch from (the branch created above)"
# git checkout -b $MASTER_BRANCH

# echo "2. npm install"
# npm install

# echo "3. npm run build:prod"
# frp build -p

# echo "4. commit push the generated build files on #2"
# git add package-lock.json public/*
# git commit -m "Production build update"

# echo "5. create PR (with release notes), then set destination PR -> master branch"
# git push origin  $MASTER_BRANCH
# hub pull-request -F $SCRIPT_DIR/master_release_note.txt --edit --push --base "master" --labels "Wave 3.0", "Release"


###########

# current Git branch
branch=$(git symbolic-ref HEAD | sed -e 's,.*/\(.*\),\1,')

# v1.0.0, v1.5.2, etc.
versionLabel=v$1

# establish branch and tag name variables
devBranch=dev
masterBranch=master
releaseBranch=$VERSION
 
# create the release branch from the -develop branch
echo "Create Branch $releaseBranch"
git checkout -b $releaseBranch $devBranch
 
# file in which to update version number
versionFile="$(cd $(dirname $0);pwd)/master_release_note.txt"

echo "test $versionFile"
# find version number assignment ("= v1.5.5" for example)
# and replace it with newly specified version number
sed -i.backup -E "s/\= v[0-9.]+/\= $VERSION/" $versionFile $versionFile
 
# remove backup file created by sed command
rm $versionFile.backup
 
# commit version number increment
git commit -am "Incrementing version number to $OLD_VERSION"
 
# merge release branch with the new version number into master
git checkout $masterBranch
git merge --no-ff $releaseBranch
 
# create tag for new version from -master
git tag -a $VERSION -m "prod build"
 
# merge release branch with the new version number back into develop
git checkout $devBranch
git merge --no-ff $releaseBranch
 
# remove release branch
git branch -d $releaseBranch

# push the tag
git push origin --tags

echo
echo "done!"
echo

