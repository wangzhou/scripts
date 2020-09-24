#!/bin/bash
#
#
# $1 is the number of PR

curl -L http://github.com/Linaro/uadk/pull/$1.patch > $1.patch
