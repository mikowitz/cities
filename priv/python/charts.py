import sys
import glob
import matplotlib.pyplot as plt
import numpy as np

cityname = sys.argv[1]

files = glob.glob(f"../text/final/{cityname}/*.txt")

ys = []

for file in files:
    with open(file) as f:
        data = list(map(float, f.readlines()))
        ys.append(data)


print(len(ys))

x = np.linspace(0, 100, num=len(ys[0]))

plt.figure()
plt.title(cityname)

for y in ys:
    plt.plot(x, y)

plt.savefig(f"../images/finaol/{cityname}.png")
