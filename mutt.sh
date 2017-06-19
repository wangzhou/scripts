#!/bin/bash
#
# open $1-mbox using this script
# e.g. ./mutt pci

if [ -z "$1" ]; then
	mutt -f ~/Mail/mbox
else
	mutt -f ~/Mail/$1-mbox
fi
