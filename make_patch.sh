#!/bin/bash

# This script helps to pick patches from the git repo, and
# then add some info to each patch, then apply the patches
# to target git repo
#
# $1: before the first commit in orgin repo
# $2: the last commit in orgin repo
#
# last commit ($2) -> commit id xxx
#                     ...
#     first commit -> commit id yyy
#               $1 -> commit id zzz
#
# $3: origin repo
# $4: target repo
# $5: origin branch
# $6: target branch

FIRST_COMMIT=$1
LAST_COMMIT=$2
ORIGIN_REPO=$3
TARGET_REPO=$4
ORIGIN_BRANCH=$5
TARGET_BRANCH=$6
COMMIT_ID

mkdir -p /tmp/patches


cd $ORIGIN_REPO
URL=`git config -l | grep url | cut -d = -f 2`

git checkout $ORIGIN_BRANCH
git checkout $LAST_COMMIT
mv `git format-patch $FIRST_COMMIT` /tmp/patches

cd /tmp/patches

for file in `ls *.patch`
do
	sed -i '1i \\n' file
	sed -i '1i commit: `head -1 file | cut -d ' ' -f 2`' file
	sed -i '1i \\n' file
	sed -i '1i git: URL' file
done

cd $TARGET_REPO
git checkout $TARGET_BRANCH
git am /tmp/patches/*.patch

rm -r /tmp/patches
