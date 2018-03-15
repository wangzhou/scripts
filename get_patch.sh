#!/bin/bash
#
# $1 is the last commit which we want to pick out
#
#
#

BRANCH=`git branch | grep \* | cut -d ' ' -f2`
echo $BRANCH

git log --oneline -- ./ > /tmp/patch

last_commit=`grep "$1" -n /tmp/patch | cut -d : -f 1`
let last_commit_1=last_commit+1
sed -i "$last_commit_1",'$d' /tmp/patch
cut -d ' ' -f 1 /tmp/patch > /tmp/commit_id

for line in `cat /tmp/commit_id`
do
        git checkout $line
        git format-patch -1 >> /tmp/patches
done

git checkout $BRANCH
cp /tmp/patches ./
rm /tmp/patch /tmp/commit_id /tmp/patches
