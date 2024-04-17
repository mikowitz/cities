import matplotlib.pyplot as plt
import numpy as np
from scipy import interpolate


# x = [0,1,2,3,4,5,6,7,8,9,10]
# y = [9,4,7,5,9,8,3,6,5,2,7]
x = [0, 9, 12, 21, 23, 24, 35, 37]
y = [9, 19, 9, 4, 15, 18, 1, 9]

# x = [0, 2, 11, 12, 16, 25, 36, 38]
# y = [4, 9, 15, 13, 9, 18, 1, 4]
data = np.array(list(zip(x, y)))

tck,u = interpolate.splprep(data.transpose(), s=0)
# unew = np.arange(0, 1.01, 0.01)
unew = np.arange(0, 51/50, 1/50)
out = interpolate.splev(unew, tck)

tck,u = interpolate.splprep(data.transpose(), s=0)
unew = np.arange(0, 1.001, 0.001)
out2 = interpolate.splev(unew, tck)

xnew = np.linspace(0, max(x), num=1001)
ynew = np.interp(xnew, x, y)

# linear, nearest, nearest-up, zero, slinear, quadratic, cubic, previous, next
f2 = interpolate.interp1d(x, y, kind='quadratic')
f3 = interpolate.interp1d(x, y, kind='cubic')
# print(len(out[0]))

plt.figure()

# plt.plot(x, y, color='green')
# plt.plot(data[:,0], data[:,1], 'ob')

# plt.plot(xnew, ynew, '-', color='black')

# print(xnew)
# print(ynew)

# avg = (np.array(xnew) + np.array(f2(xnew))) / 2
# avg = (out2[1] + f2(xnew) + ynew) / 3
avg = (f3(xnew) + ynew*2) / 3
avg2 = (f3(xnew) + ynew) / 2


# plt.plot(out[0], out[1], color='blue')
plt.plot(out2[0], out2[1], color='red')
# plt.plot(xnew, f2(xnew), color='green')
plt.plot(xnew, f3(xnew), color='green')
# plt.plot(xnew, avg, color='blue')
# plt.plot(xnew, avg2, color='purple')
plt.show()


