#!/bin/bash -e

#
# $./run.sh [thread num] [sync mode]
#   param thread num: [1:16]
#   param mode: non-zero -- async mode, zero -- sync mode
#   no param means 1 thread in sync mode
#

WORKSPACE=/home/hzhuang1
LIB_ROOT=${WORKSPACE}/uadk-dynamic-v2
LIB_DIR=usr/local/lib
BIN_DIR=usr/local/bin
INC_DIR=usr/local/include

if [ $1 ]; then
	THREAD_NUM=$1
else
	THREAD_NUM=1
fi

if [ $2 ]; then
	MODE="--async"
	echo "in async mode"
else
	MODE="--sync"
	echo "in sync mode"
fi

sudo \
  LD_LIBRARY_PATH=${LIB_ROOT}/${LIB_DIR} \
  PATH=${LIB_ROOT}/${BIN_DIR}/:${PATH} \
  C_INCLUDE_PATH=${LIB_ROOT}/${INC_DIR} \
  numactl --cpubind 1 --membind 1  test_hisi_sec --perf ${MODE} --pktlen 1024 \
            --block 1024 --blknum 100000 --times 100000 --multi ${THREAD_NUM} \
	    --ctxnum ${THREAD_NUM}


