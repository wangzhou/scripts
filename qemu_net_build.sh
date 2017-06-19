#!/bin/bash
#
# can only support eth0, if this case qemu and host and outside world can communicate
# with each other.
#
# can NOT work with wlan0
#
# Note: we should run "sudo modprobe bridge" to add br0 before run this script.
# details please refer to http://blog.csdn.net/scarecrow_byr/article/details/17741133

ifconfig eth0 down                   # 关闭网口
brctl addbr br0                       # 添加虚拟的网桥
brctl addif br0 eth0                 # 在网桥上添加网口
brctl stp br0 off                 
brctl setfd br0 1                 
brctl sethello br0 1              
ifconfig br0 0.0.0.0 promisc up       # 释放br0的ip地址
ifconfig eth0 0.0.0.0 promisc up     # 释放eth0的ip地址
dhclient br0                          # 自动获得br0的ip地址
brctl show br0
brctl showstp br0


tunctl -t tap0 -u root                # 设定虚拟网卡上的端口tap0
brctl addif br0 tap0                  # 在网桥上添加虚拟网卡的端口tap0
ifconfig tap0 0.0.0.0 promisc up      # 释放tap0的ip地址
brctl showstp br0

