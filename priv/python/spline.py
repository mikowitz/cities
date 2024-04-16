def calculate_spline(city_name, total_length, points):
    import numpy as np
    import matplotlib.pyplot as plt
    from scipy import interpolate
    import sys
    from itertools import batched

    city_name = city_name.decode("utf-8")
    points = list(batched(points, 2))
    print(city_name, total_length)
    print(points)
    data = np.array(points)

    tck,u = interpolate.splprep(data.transpose(), s=0)
    # unew = np.arange(0, 1.001, 0.001)
    unew = np.arange(0, (total_length+1)/total_length, 1/total_length)
    out = interpolate.splev(unew, tck)

    xs, ys = out

    with open(f"priv/text/city-dynamic-envelope/{city_name}-dynamic-envelope.txt", 'w') as f:
        for y in ys[:total_length+1]:
            f.write(str(round(y, 3)))
            f.write("\n")
#
#
# plt.figure()
# plt.plot(out[0], out[1], color='orange')
# plt.plot(data[:,0], data[:,1], 'ob')
# plt.show()

def calculate_letter_spline(city_name, letter, points):
    import numpy as np
    import matplotlib.pyplot as plt
    from scipy import interpolate
    import sys
    from itertools import batched

    city_name = city_name.decode("utf-8")
    letter = letter.decode("utf-8")
    length = points[-2]
    print(city_name, letter, length)
    points = list(batched(points, 2))
    data = np.array(points)

    tck,u = interpolate.splprep(data.transpose(), s=0)
    # unew = np.arange(0, 1.001, 0.001)
    # unew = np.arange(0, (total_length+1)/total_length, 1/total_length)
    unew = np.arange(0, (length+1)/length, 1/length)
    out = interpolate.splev(unew, tck)

    xs, ys = out

    to_range = interpolate.interp1d([min(ys[:length+1]), max(ys[:length+1])], [0, 1])
    with open(f"priv/text/cities/{city_name}/{letter}-dynamic-envelope.txt", 'w') as f:
        for y in ys[:length+1]:
            f.write(str(round(float(to_range(y)), 3)))
            f.write("\n")
    # plt.figure()
    # plt.plot(out[0], to_range(out[1]), color='orange')
    # plt.plot(data[:,0], data[:,1], 'ob')
    # plt.show()
