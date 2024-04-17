# def calculate_spline(city_name, total_length, points):
def calculate_spline(*args):
    import numpy as np
    import matplotlib.pyplot as plt
    from scipy import interpolate
    from itertools import batched
    import os

    args = args[0]
    city_name = args[0]
    total_length = int(args[1])
    points = list(map(int, args[2:]))
    points = list(batched(points, 2))
    data = np.array(points)

    tck,u = interpolate.splprep(data.transpose(), s=0)
    unew = np.arange(0, (total_length+1)/total_length, 1/total_length)
    out = interpolate.splev(unew, tck)

    xs, ys = out

    x, y = list(zip(*points))
    xl = np.linspace(0, points[-1][0], num=total_length+1)
    yl = np.interp(xl, x, y)

    f3 = interpolate.interp1d(x, y, kind='cubic')

    avg = (yl + f3(xl)) / 2


    with open(f"priv/text/city-dynamic-envelope/linear/{city_name}.txt", 'w') as f:
        for y in yl[:total_length+1]:
            f.write(str(round(y, 3)))
            f.write("\n")

    with open(f"priv/text/city-dynamic-envelope/cubic/{city_name}.txt", 'w') as f:
        for y in f3(xl)[:total_length+1]:
            f.write(str(round(y, 3)))
            f.write("\n")

    with open(f"priv/text/city-dynamic-envelope/average/{city_name}.txt", 'w') as f:
        for y in avg[:total_length+1]:
            f.write(str(round(y, 3)))
            f.write("\n")
#
#
    plt.figure()
    plt.plot(data[:,0], data[:,1], 'ob')
    plt.plot(xl, yl, color='blue')
    plt.plot(xl, f3(xl), color='red')
    plt.plot(xl, avg, color='purple')
    plt.savefig(f"priv/images/city-dynamic-envelope/{city_name}.png")

# def calculate_letter_spline(city_name, letter, points):
def calculate_letter_spline(*args):
    import numpy as np
    import matplotlib.pyplot as plt
    from scipy import interpolate
    from itertools import batched

    args = args[0]
    city_name = args[0]
    letter = args[1]
    points = args[2:]
    length = int(points[-2])
    points = list(batched(points, 2))
    points = list(map(lambda t: (int(t[0]), float(t[1])), points))
    data = np.array(points)

    tck,u = interpolate.splprep(data.transpose(), s=0)
    unew = np.arange(0, (length+1)/length, 1/length)
    out = interpolate.splev(unew, tck)

    xs, ys = out

    x, y = list(zip(*points))
    xl = np.linspace(0, points[-1][0], num=length+1)
    yl = np.interp(xl, x, y)

    f3 = interpolate.interp1d(x, y, kind='cubic')

    avg = (yl + f3(xl)) / 2

    # to_range = interpolate.interp1d([min(ys[:length+1]), max(ys[:length+1])], [0, 1])
    # to_range = interpolate.interp1d([min(ys[:length+1]), max(ys[:length+1])], [0, 1])
    # with open(f"priv/text/cities/{city_name}/{letter}-dynamic-envelope.txt", 'w') as f:
    #     for y in ys[:length+1]:
    #         f.write(str(round(float(to_range(y)), 3)))
    #         f.write("\n")

    with open(f"priv/text/letter-dynamic-envelope/{city_name}/linear/{letter}.txt", 'w') as f:
        for y in yl[:length+1]:
            f.write(str(round(y, 3)))
            f.write("\n")

    with open(f"priv/text/letter-dynamic-envelope/{city_name}/cubic/{letter}.txt", 'w') as f:
        for y in f3(xl)[:length+1]:
            f.write(str(round(y, 3)))
            f.write("\n")

    with open(f"priv/text/letter-dynamic-envelope/{city_name}/average/{letter}.txt", 'w') as f:
        for y in avg[:length+1]:
            f.write(str(round(y, 3)))
            f.write("\n")

    plt.figure()
    plt.plot(data[:,0], data[:,1], 'ob')
    plt.plot(xl, yl, color='blue')
    plt.plot(xl, f3(xl), color='red')
    plt.plot(xl, avg, color='purple')
    plt.savefig(f"priv/images/letter-dynamic-envelope/{city_name}/{letter}.png")

if __name__ == "__main__":
    import sys
    print(sys.argv)
    eval(sys.argv[1])(sys.argv[2:])

