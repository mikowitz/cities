import matplotlib.pyplot as plt
import numpy as np
from scipy import interpolate

types = ["average"] #$, "cubic", "linear"]

for city_type in types:
    for letter_type in types:

        with open(f"../text/city-dynamic-envelope/{city_type}/diomira.txt", "r") as f:
            lines = f.readlines()
            city = list(map(float, lines))

        with open(f"../text/letter-dynamic-envelope/diomira/{letter_type}/d.txt", "r") as f:
            lines = f.readlines()
            letter = list(map(float, lines))


        def norm(min, max):
            return interpolate.interp1d([min, max], [0,1])

        norm_city = norm(min(city), max(city))(city)
        norm_char = norm(min(letter), max(letter))(letter)

        x = np.linspace(0, 1000, len(city))
        y = (np.array(norm_city) + np.array(norm_char)) / 2


        plt.figure()
        plt.plot(x, y, color='purple')
        plt.show()
        # plt.savefig(f"diomira-city-{city_type}-char-{letter_type}.png")
