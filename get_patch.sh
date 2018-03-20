#!/bin/bash
#
# $1 is the last commit which we want to pick out
#
# e.g. if we want to pick patches from "hisi_sas: Set dev DMA mask" to the latest
#      patches in this directory
#
# ...
# 9fb10b5 hisi_sas: Add v1 hw module init
# fa42d80 hisi_sas: Add timer and spinlock init
# 976867e hisi_sas: Add phy and port init
# af740db hisi_sas: Add hisi sas device type
# 7e9080e hisi_sas: Add hisi_hba workqueue
# 50cb916 hisi_sas: Set dev DMA mask                   <----
# 5d74242 hisi_sas: Add phy SAS ADDR initialization
#
# run: ./get_patch.sh "hisi_sas: Set dev DMA mask", then related patches will
# be created as 0000.patch, 0001.patch... in the same directory.
#
# note: using git log ./ can only get the part of patch which is in ./, To get
#       the whole patch you need checkout related commit id and create patch.
#       (or use git cherry pick)

BRANCH=`git branch | grep \* | cut -d ' ' -f2`
echo $BRANCH

git log --oneline -- ./ > /tmp/patch

last_commit=`grep "$1" -n /tmp/patch | cut -d : -f 1`
let last_commit_1=last_commit+1
sed -i "$last_commit_1",'$d' /tmp/patch
sed -i '/Merge/d' /tmp/patch
cut -d ' ' -f 1 /tmp/patch > /tmp/commit_id_r
tac /tmp/commit_id_r > /tmp/commit_id

i=0
for line in `cat /tmp/commit_id`
do
	prefix=`printf "%04d" "$i"`
        git checkout $line
        git format-patch -1 --stdout > ./$prefix.patch
	let i=i+1
done

git checkout $BRANCH
rm /tmp/patch /tmp/commit_id /tmp/commit_id_r
