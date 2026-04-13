#!/bin/bash

qemu-system-aarch64 \
  -machine virt,gic-version=3 \
  -cpu host \
  -accel hvf \
  -m 16G \
  -smp 10 \
  -drive file=~/ISO/openEuler-24.03-LTS-SP2-aarch64.qcow2,format=qcow2,if=virtio \
  -netdev user,id=net0,hostfwd=tcp::2222-:22,hostfwd=tcp::4000-:4000\
  -device virtio-net-pci,netdev=net0 \
  -nographic \
  -bios /opt/homebrew/share/qemu/edk2-aarch64-code.fd \
  -fsdev local,id=fsdev0,path=/Users/sherlock,security_model=none \
  -device virtio-9p-pci,fsdev=fsdev0,mount_tag=hostshare \
  -rtc clock=host
#  -serial mon:stdio
