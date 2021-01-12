#!/bin/bash
#
#
# $1 is the number of PR

# This will add all patches in one patch set to one file.
#curl -L http://github.com/Linaro/uadk/pull/$1.patch > $1.patch

git pull origin pull/24/head
