import numpy as np
import matplotlib.pyplot as plt
from scipy import interpolate
import sys
from itertools import batched

city_name = sys.argv[1]
points = list(batched(list(map(lambda x: int(x), sys.argv[2:])), 2))
print(city_name)
print(points)
#
# # points = [(3.28,0.00),(4.00,0.50),(4.40,1.0),(4.60,1.52),(5.00,2.5),(5.00,3.34),(4.70,3.8)]
# # points = points + [(4.50,3.96),(4.20,4.0),(3.70,3.90),(3.00,3.5),(2.00,2.9)]
# points = [
#         (0,4),
#         (2, 9),
#         (11, 15),
#         (12, 13),
#         (16, 9),
#         (25, 18),
#         (36, 1),
#         (38, 0)
#         ]
data = np.array(points)

tck,u = interpolate.splprep(data.transpose(), s=0)
# unew = np.arange(0, 1.001, 0.001)
unew = np.arange(0, 2195/2194, 1/2194)
out = interpolate.splev(unew, tck)

xs, ys = out

with open(f'{city_name}.txt', 'w') as f:
    for y in ys:
        f.write(str(round(y, 3)))
        f.write("\n")


plt.figure()
plt.plot(out[0], out[1], color='orange')
plt.plot(data[:,0], data[:,1], 'ob')
plt.show()
