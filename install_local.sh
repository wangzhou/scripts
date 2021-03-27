#/bin/bash

./cleanup.sh
./autogen.sh
./configure \
  --host aarch64-linux-gnu \
  --target aarch64-linux-gnu \
  --prefix=/home/wangzhou/test_bin/usr/local \
  --includedir=/home/wangzhou/test_bin/usr/local/include/uadk

make
make install
