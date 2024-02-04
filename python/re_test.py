#!/usr/bin/python3
#
# readlines返回一个list, list中的每个元素是文件中的一行

import re
retest = re.compile(r"test=(\d+)")

with open("test") as f:
    line = f.readline()
    print(type(line))
    ret_s = retest.search(line)
    if ret_s:
        print(ret_s.group(1))
    
