#!/bin/bash

echo 0000:76:00.0 > /sys/bus/pci/drivers/hisi_sec2/unbind
echo 0000:b6:00.0 > /sys/bus/pci/drivers/hisi_sec2/unbind
echo 0000:b9:00.0 > /sys/bus/pci/drivers/hisi_hpre/unbind
