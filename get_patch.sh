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
cut -d ' ' -f 1 /tmp/patch > /tmp/commit_id_r
tac /tmp/commit_id_r > /tmp/commit_id

i=0
for line in `cat /tmp/commit_id`
do
        git checkout $line
        git format-patch -1 --stdout > ./$i.patch
	let i=i+1
done

git checkout $BRANCH
rm /tmp/patch /tmp/commit_id /tmp/patch_tmp /tmp/commit_id_r
