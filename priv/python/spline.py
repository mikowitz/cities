from scipy import interpolate

def cubic_interpolation(x, y):
    return interpolate.interp1d(x, y, kind='cubic')

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

    f3 = cubic_interpolation(x, y)

    avg = (yl + f3(xl)) / 2


    for name, values in {"linear": yl, "cubic": f3(xl), "average": avg}.items():
        with open(f"priv/text/city-dynamic-envelope/{name}/{city_name}.txt", 'w') as f:
            for y in values[:total_length+1]:
                f.write(str(round(y, 3)))
                f.write("\n")

#     with open(f"priv/text/city-dynamic-envelope/cubic/{city_name}.txt", 'w') as f:
#         for y in f3(xl)[:total_length+1]:
#             f.write(str(round(y, 3)))
#             f.write("\n")
#
#     with open(f"priv/text/city-dynamic-envelope/average/{city_name}.txt", 'w') as f:
#         for y in avg[:total_length+1]:
#             f.write(str(round(y, 3)))
#             f.write("\n")
# #
# #
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

    f3 = cubic_interpolation(x, y)

    avg = (yl + f3(xl)) / 2

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

def city_set_envelope(*args):
    import numpy as np
    import matplotlib.pyplot as plt
    from scipy import interpolate
    from itertools import batched
    import os

    args = args[0]
    city_name = args[0]
    indices_length = int(args[1])
    indices = args[2:2+indices_length]
    city_env = list(map(int, args[2+indices_length:]))

    city_env[-1] = 0
    city_env = list(batched(city_env, 2))
    # city_env[-1][1] = 0

    points = list(map(int, indices))

    pairs = [points[i:i+2] for i in range(len(points) - 1)]

    env = []
    cubic_env = []

    def norm(min, max, tmin=0, tmax=1):
        return interpolate.interp1d([min, max], [tmin, tmax])

    for i, a in enumerate(pairs):
        if i % 2 == 0:
            x, y = list(zip(*city_env))
            l = a[1] - a[0]
            if l == 0:
                continue
            xl = np.linspace(0, city_env[-1][0], num=l)
            yl = np.interp(xl, x, y)
            env += list(norm(min(yl), max(yl), tmin=0.1)(yl))

            cubic = cubic_interpolation(x, y)(xl)

            cubic_env += list(norm(min(cubic), max(cubic), tmin=0.1)(cubic))
        else:
            num = 0.1
            env += ([num] * (a[1] - a[0]))
            cubic_env += ([num] * (a[1] - a[0]))

    x = np.linspace(0, len(env), len(env))
    y = np.array(env)

    avg = (y + np.array(cubic_env)) / 2

    plt.figure()
    plt.plot(x, y, color='blue')
    plt.plot(x, avg, color='purple')
    plt.plot(x, np.array(cubic_env), color='red')
    # plt.title(city_env)
    # plt.show()
    # plt.plot(data[:,0], data[:,1], 'ob')
    # plt.plot(xl, yl, color='blue')
    # plt.plot(xl, f3(xl), color='red')
    # plt.plot(xl, avg, color='purple')
    plt.savefig(f"priv/images/city-set-envelope/{city_name}.png")
    with open(f"priv/text/city-set-envelope/average/{city_name}.txt", 'w') as f:
        for i in avg:
            f.write(str(round(i, 3)))
            f.write("\n")

    with open(f"priv/text/city-set-envelope/linear/{city_name}.txt", 'w') as f:
        for i in y:
            f.write(str(round(i, 3)))
            f.write("\n")


def final_city_dynamic_envelope(*args):
    import numpy as np
    import matplotlib.pyplot as plt

    args = args[0]
    city_name = args[0]
    points = list(map(float, args[1:]))

    x = np.linspace(0, len(points)-1, num=len(points))
    y = np.array(points)

    with open(f"priv/text/final-city-dynamic-envelope/{city_name}.txt", 'w') as f:
        for i in points:
            f.write(str(round(i, 3)))
            f.write("\n")

    plt.figure()
    plt.plot(x, y, color='blue')
    plt.savefig(f"priv/images/final-city-dynamic-envelope/{city_name}.png")

if __name__ == "__main__":
    import sys

    eval(sys.argv[1])(sys.argv[2:])


