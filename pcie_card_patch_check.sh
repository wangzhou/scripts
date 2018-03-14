#!/bin/bash

# This script helps to create the PCIe cards kernel patches from BASE to latest
# commit in kernel mainline.
#
# Currently we support I350, 82599, ES3000, Mellanox 10G/25G, PCIe 30008 RAID,
# PCIe 3108 RAID cards, HNS.
#
# In Linux kernel repo, run this script, a report can be got named pci_report.txt

BASE="Linux 4.11"
REPORT="pci_report.txt"
#DIR_I350="./drivers/net/ethernet/intel/igb"
#DIR_82599="./drivers/net/ethernet/intel/ixgbe"
#DIR_ES3000="./drivers/nvme"
#DIR_Mellanox="./drivers/net/ethernet/mellanox/mlx4"
#DIR_3008="./drivers/scsi/mpt3sas"
#DIR_3108="./drivers/scsi/megaraid"
BASE_COMMIT=`git log --oneline | grep "$BASE$" | cut -d " " -f 1`

declare -A card_array
card_array["DIR_I350"]="./drivers/net/ethernet/intel/igb"
card_array["DIR_82599"]="./drivers/net/ethernet/intel/ixgbe"
card_array["DIR_ES3000"]="./drivers/nvme"
card_array["DIR_Mellanox"]="./drivers/net/ethernet/mellanox/mlx4"
card_array["DIR_3008"]="./drivers/scsi/mpt3sas"
card_array["DIR_3108"]="./drivers/scsi/megaraid"
card_array["DIR_HNS"]="./drivers/net/ethernet/hisilicon/hns"

touch ./$REPORT

for DIR in ${!card_array[@]}
do
        echo `echo $DIR | cut -d "_" -f 2`: >> ./$REPORT
        echo "" >> ./$REPORT

        git log --oneline ${BASE_COMMIT}...HEAD ${card_array[$DIR]} >> ./$REPORT
        echo "" >> ./$REPORT
        echo "" >> ./$REPORT
done
