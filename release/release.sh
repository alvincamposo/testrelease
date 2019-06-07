#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

ASSIGNEES=''
DEFAULT_REVIEWERS='alvincamposo'
PR_LABELS='Wave 3.0'

OLD_VERSION="$(jq -r '.version' package.json)"
DATE=`date +%Y%m%d`
SCRIPT_DIR=$(cd $(dirname $0);pwd)

default_next_version="$(awk '{split($0,v,".");printf("%d.%d.%d",v[1],v[2],v[3]+1)}' <<<"$OLD_VERSION")"

read -rp "Next Version (${default_next_version}): " VERSION
: ${VERSION:=${default_next_version}}

read -rp "Reviewers (${DEFAULT_REVIEWERS}): " REVIEWERS
: ${REVIEWERS:=${DEFAULT_REVIEWERS}}

DEV_BRANCH="UpdateTo${VERSION}"
MASTER_BRANCH="Build${DATE}v${VERSION}"

echo
echo "Release workflow"
echo "Update version, from dev branch"

echo $OLD_VERSION
echo $VERSION
echo $DATE
echo $DEV_BRANCH
echo $MASTER_BRANCH

read -rp "Create PR for dev/master release？ (y/n)" push_pr

echo '1) Fetching origin ...'
git checkout origin

echo "2) Creating ${DEV_BRANCH} branch from origin/dev ..."
git checkout -B "$DEV_BRANCH" origin/dev

echo '3) Updating the version in package.json ...'
jq ".version=\"${VERSION}\"" package.json >package.json.tmp
mv -f package.json.tmp package.json

echo '4) Committing changes ...'
git add package.json
git commit -m 'Update the version in package.json'

echo '5) Pushing to origin ...'
git push -f origin "$DEV_BRANCH";

if [[ "$push_pr" == [yY] ]]; then
  # TODO Generate the PR description here

  echo "6) Creating a PR: ${DEV_BRANCH} -> dev ..."
  hub pull-request \
      -b 'dev' \
      -r "$REVIEWERS" \
      -a "$ASSIGNEES" \
      -l "$PR_LABELS" \
      -F "${SCRIPT_DIR}/release_note_dev.txt" \
      --edit
fi

echo "Merge to master branch & create new build"

echo "1) Creating ${MASTER_BRANCH} from ${DEV_BRANCH} ..."
git checkout -B "$MASTER_BRANCH" "$DEV_BRANCH"

echo '2) Setting up build environment ...'
nvm use

echo '3) Cleaning up the outdated dependencies and artifacts ...'
rm -rf .dist dist node_modules

echo '4) Installing build dependencies ...'
npm install

echo '5) Building ...'
npm run build:prod

echo '6) Committing the build artifacts ...'
git add -f dist package-lock.json
git commit -m 'Production build update'

echo '7) Rebasing the commits on origin/master using ours strategy ...'
git rebase -s ours origin master

echo '8) Pushing to origin ...'
git push -f origin "$MASTER_BRANCH";

if [[ "$push_pr" == [yY] ]]; then
  echo "9) Creating a PR: ${MASTER_BRANCH} -> master ..."
  hub pull-request \
      -b "master" \
      -r "$REVIEWERS" \
      -a "$ASSIGNEES" \
      -l "$PR_LABELS" \
      -F $SCRIPT_DIR/release_note_master.txt \
      --edit
fi

##When release PRs need to be merged.
#1. Merge first the -> dev PR
#2. Merge second the -> master PR
#3. Create release from tag on github```

echo
echo "done!"
echo
