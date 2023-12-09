[
  [21700.0, 0.0, 0.0],
  [200.0, 0.0, 0.1111111111111111],
  [5000.0, 0.1111111111111111, 0.16666666666666666],
  [37100.0, 0.16666666666666666, 0.2777777777777778],
  [2800.0, 0.2777777777777778, 0.2916666666666667],
  [10600.0, 0.2916666666666667, 0.08333333333333333],
  [7800.0, 0.08333333333333333, 0.08333333333333333],
  [11300.0, 0.08333333333333333, 0.3333333333333333],
  [10300.0, 0.3333333333333333, 0.13333333333333333],
  [1500.0, 0.13333333333333333, 0.25],
  [10900.0, 0.25, 0.06666666666666667],
  [200.0, 0.06666666666666667, 0.12121212121212122],
  [2400.0, 0.12121212121212122, 0.15151515151515152],
  [700.0, 0.15151515151515152, 0.30303030303030304],
  [14800.0, 0.30303030303030304, 0.14285714285714285],
  [200.0, 0.14285714285714285, 0.125],
  [7900.0, 0.125, 0.16666666666666666],
  [13900.0, 0.16666666666666666, 0.26666666666666666],
  [200.0, 0.26666666666666666, 0.25925925925925924],
  [8700.0, 0.25925925925925924, 0.2962962962962963],
  [11100.0, 0.2962962962962963, 0.13333333333333333],
  [6300.0, 0.13333333333333333, 0.13333333333333333],
  [200.0, 0.13333333333333333, 0.2222222222222222],
  [15600.0, 0.2222222222222222, 0.3333333333333333],
  [22400.0, 0.3333333333333333, 0.16666666666666666],
  [18200.0, 0.16666666666666666, 0.08333333333333333],
  [9400.0, 0.08333333333333333, 0.2777777777777778],
  [200.0, 0.2777777777777778, 0.2222222222222222],
  [9500.0, 0.2222222222222222, 0.3333333333333333],
  [5600.0, 0.3333333333333333, 0.19999999999999998],
  [1400.0, 0.19999999999999998, 0.037037037037037035],
  [7300.0, 0.037037037037037035, 0.2222222222222222],
  [200.0, 0.2222222222222222, 0.26666666666666666],
  [11600.0, 0.26666666666666666, 0.3333333333333333],
  [45300.0, 0.3333333333333333, 0.2333333333333333],
  [3400.0, 0.2333333333333333, 0.3333333333333333],
  [12900.0, 0.3333333333333333, 0.16666666666666666],
  [5100.0, 0.16666666666666666, 0.3333333333333333],
  [56400.0, 0.3333333333333333, 0.08333333333333333],
  [9700.0, 0.08333333333333333, 0.08333333333333333],
  [1300.0, 0.08333333333333333, 0.2777777777777778],
  [8900.0, 0.2777777777777778, 0.14814814814814814],
  [24000.0, 0.14814814814814814, 0.3333333333333333],
  [27400.0, 0.3333333333333333, 0.2916666666666667],
  [15700.0, 0.2916666666666667, 0.25925925925925924],
  [8600.0, 0.25925925925925924, 0.08333333333333333],
  [22200.0, 0.08333333333333333, 0.2777777777777778],
  [17200.0, 0.2777777777777778, 0.26666666666666666],
  [1800.0, 0.26666666666666666, 0.2777777777777778],
  [25700.0, 0.2777777777777778, 0.19047619047619047],
  [2100.0, 0.19047619047619047, 0.2222222222222222],
  [11300.0, 0.2222222222222222, 0.2380952380952381],
  [2600.0, 0.2380952380952381, 0.13333333333333333],
  [46800.0, 0.13333333333333333, 0.08333333333333333],
  [25100.0, 0.08333333333333333, 0.2777777777777778],
  [2900.0, 0.2777777777777778, 0.26666666666666666],
  [1500.0, 0.26666666666666666, 0.1851851851851852],
  [6400.0, 0.1851851851851852, 0.2962962962962963],
  [35200.0, 0.2962962962962963, 0.16666666666666666],
  [900.0, 0.16666666666666666, 0.1818181818181818],
  [13500.0, 0.1818181818181818, 0.30303030303030304],
  [8200.0, 0.30303030303030304, 0.2857142857142857],
  [14500.0, 0.2857142857142857, 0.1111111111111111],
] @=> float fades[][];

Gain g => dac;
0.0 => g.gain;

SinOsc s => Pan2 p => g;
-0.11 => p.pan;
1200.0 => s.freq;

for (0 => int i; i < fades.size(); i++) {
fades[i][0] => float totalMs;
fades[i][1] => float startGain;
fades[i][2] => float stopGain;

totalMs::ms + now => time stopTime;

0 => float progress;

(stopGain - startGain) * (1 / totalMs) => float stepChange;

while ( now < stopTime ) {
  1 +=> progress;
  stepChange + g.gain() => g.gain;
  1::ms => now;
}
}

s =< g;
