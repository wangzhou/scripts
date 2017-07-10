#!/bin/bash
#
#
#echo "$1_$2_$3_test" > $filename
echo "
[global]
rw=$2
direct=0
ramp_time=1
ioengine=libaio
iodepth=$3
numjobs=$4
bs=$1
;size=102400m
;zero_buffers=1
group_reporting=1
;ioscheduler=noop
;gtod_reduce=1
;iodepth_batch=2
;iodepth_batch_complete=2
runtime=1800000
;thread
loops=10
" > $1_$2_depth$3_fiotest

declare -i new_count=1
fdisk -l | grep "Disk /dev/sd" > fdiskinfo
cat fdiskinfo | awk '{print $2}' |awk -F ":" '{print $1}' > devinfo
new_num=`sed -n '$=' devinfo`

while [ $new_count -le $new_num ]
do
	new_disk=`sed -n "$new_count"p devinfo`
	((new_count++))
	if [ "$new_disk" = "/dev/sd" ]; then
	continue
	fi
	echo "[job1]" >> $1_$2_depth$3_fiotest
	echo "filename=$new_disk" >> $1_$2_depth$3_fiotest

done

echo "Creat $1_$2_depth$3_fiotest file successfully"

chmod +x fio
fio $1_$2_depth$3_fiotest
