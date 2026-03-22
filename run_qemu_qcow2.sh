#!/bin/bash

qemu-system-aarch64 \
  -machine virt,gic-version=3 \
  -cpu cortex-a72 \
  -accel tcg,thread=multi \
  -m 4G \
  -smp 4 \
  -drive file=openEuler-24.03-LTS-SP3-aarch64.qcow2,format=qcow2,if=virtio \
  -netdev user,id=net0,hostfwd=tcp::2222-:22 \
  -device virtio-net-pci,netdev=net0 \
  -nographic \
  -bios ~/repos/qemu/pc-bios/edk2-aarch64-code.fd
#  -serial mon:stdio
