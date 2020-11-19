#/bin/bash
#
# echo 0000:b6:00.0 > /sys/bus/pci/drivers/hisi_sec2/unbind
#
# numactl --cpubind 1 --membind 1  test_hisi_sec --perf --sync --pktlen 1024 --block 1024 --blknum 100000 --times 100000 --multi 1 --ctxnum 1

for i in `seq $1`
do
	numactl --cpubind 1 --membind 1  test_hisi_sec --perf --sync --pktlen 1024 --block 1024 --blknum 100000 --times 100000 --multi 1 --ctxnum 1 &
done
