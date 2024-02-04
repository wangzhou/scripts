#!/usr/bin/python3
#
# y is list of list:
# [
#   [1, 2, 3],
#   [4, 5, 6],
#   [7, 8, 9]
# ]
#
import matplotlib.pyplot as plt
import numpy as np

x = [3, 2, 1]
y = [1, 2, 10]
plt.plot(x, y)
plt.show()

# y = [[], [], []]
# x = np.arange(-10, 10, 1)
# y[0] = x * x + 10
# y[1] = x * x + 30
# y[2] = (x + 4) * (x + 4) + 30
# 
# for i in range(len(y)):
#     plt.plot(x, y[i])
# 
# plt.title("taotao, haha")
# plt.xlabel('x')
# plt.ylabel('y')
# plt.grid(True)
# plt.show()

