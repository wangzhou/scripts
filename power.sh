#!/bin/bash

ipmitool -H 192.168.1.130 -I lanplus -U root -PHuawei12#$ chassis power $1
