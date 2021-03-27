#!/bin/bash

if [ $1 == 1 ]; then
	cat /proc/vmstat | grep thp > /tmp/vmstat_thp1
fi

if [ $1 == 2 ]; then
	cat /proc/vmstat | grep thp > /tmp/vmstat_thp2
	diff /tmp/vmstat_thp1 /tmp/vmstat_thp2
	rm /tmp/vmstat_thp*
fi
