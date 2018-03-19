#!/bin/bash
#
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
# $4: target repo (can be same with $3)
# $5: origin branch
# $6: target branch
# $7: bugzilla ID
# $8: brew task ID
#
# .e.g you want to backport commit a/b/c from origin branch to target branch
#
#   origin branch:    target branch:
#
#      a   <- $2          a'   
#      |                  |
#      v                  v
#      b                  b'
#      |    backport      |
#      v    ========>     v
#      c                  c'
#      |                  |
#      v                  v
#      d   <- $1          e

FIRST_COMMIT=$1
LAST_COMMIT=$2
ORIGIN_REPO=$3
TARGET_REPO=$4
ORIGIN_BRANCH=$5
TARGET_BRANCH=$6
BZ_ID=$7
BREW_ID=$8

mkdir -p /tmp/patches

cd $ORIGIN_REPO
URL=`git config -l | grep url | cut -d = -f 2`

git checkout $ORIGIN_BRANCH
git checkout $LAST_COMMIT
mv `git format-patch $FIRST_COMMIT` /tmp/patches

cd /tmp/patches

echo "" > /tmp/commit_msg
echo "Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=${BZ_ID}" >> /tmp/commit_msg
echo "Build-Info: http://brewweb.devel.redhat.com/brew/taskinfo?taskID=${BREW_ID}" >> /tmp/commit_msg
echo "git $URL" >> /tmp/commit_msg

for file in `ls *.patch`
do
	echo "commit `head -1 $file | cut -d ' ' -f 2`" >> /tmp/commit_msg

	SUBJECT_NUM=`grep -n "Subject" $file | cut -d : -f 1`
	let NEXT_LINE=SUBJECT_NUM+1

	if [ -z `sed -n ${NEXT_LINE}p $file` ]; then
		sed -i "${SUBJECT_NUM} r /tmp/commit_msg" $file
	else
		sed -i "${NEXT_LINE} r /tmp/commit_msg" $file
	fi

	sed -i '/commit/d' /tmp/commit_msg
done

cd $TARGET_REPO
git checkout $TARGET_BRANCH
git am -s /tmp/patches/*.patch

rm -r /tmp/patches
rm /tmp/commit_msg
cd $ORIGIN_REPO
git checkout $ORIGIN_BRANCH
cd $TARGET_REPO
git checkout $TARGET_BRANCH
