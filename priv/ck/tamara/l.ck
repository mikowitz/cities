[
  [1500.0, 0.0, 0.0],
  [14200.0, 0.0, 0.25],
  [2500.0, 0.25, 0.2777777777777778],
  [10300.0, 0.2777777777777778, 0.06666666666666667],
  [57600.0, 0.06666666666666667, 0.25],
  [7600.0, 0.25, 0.1111111111111111],
  [200.0, 0.1111111111111111, 0.2222222222222222],
  [5500.0, 0.2222222222222222, 0.3333333333333333],
  [8500.0, 0.3333333333333333, 0.16666666666666666],
  [7500.0, 0.16666666666666666, 0.3111111111111111],
  [6300.0, 0.3111111111111111, 0.25],
  [200.0, 0.25, 0.2380952380952381],
  [4800.0, 0.2380952380952381, 0.2857142857142857],
  [13000.0, 0.2857142857142857, 0.06666666666666667],
  [20600.0, 0.06666666666666667, 0.13333333333333333],
  [200.0, 0.13333333333333333, 0.19999999999999998],
  [46200.0, 0.19999999999999998, 0.26666666666666666],
  [7500.0, 0.26666666666666666, 0.125],
  [10500.0, 0.125, 0.2222222222222222],
  [2800.0, 0.2222222222222222, 0.2380952380952381],
  [2500.0, 0.2380952380952381, 0.06666666666666667],
  [26600.0, 0.06666666666666667, 0.125],
  [3600.0, 0.125, 0.08333333333333333],
  [13800.0, 0.08333333333333333, 0.14285714285714285],
  [13800.0, 0.14285714285714285, 0.2857142857142857],
  [4800.0, 0.2857142857142857, 0.13333333333333333],
  [200.0, 0.13333333333333333, 0.13333333333333333],
  [21700.0, 0.13333333333333333, 0.19999999999999998],
  [10100.0, 0.19999999999999998, 0.25],
  [200.0, 0.25, 0.09523809523809523],
  [7500.0, 0.09523809523809523, 0.14285714285714285],
  [3100.0, 0.14285714285714285, 0.09523809523809523],
  [6800.0, 0.09523809523809523, 0.25],
  [11700.0, 0.25, 0.1111111111111111],
  [31700.0, 0.1111111111111111, 0.2380952380952381],
  [30500.0, 0.2380952380952381, 0.2222222222222222],
  [3700.0, 0.2222222222222222, 0.2962962962962963],
  [49100.0, 0.2962962962962963, 0.16666666666666666],
  [15100.0, 0.16666666666666666, 0.13333333333333333],
  [3700.0, 0.13333333333333333, 0.3333333333333333],
  [11300.0, 0.3333333333333333, 0.3333333333333333],
  [5300.0, 0.3333333333333333, 0.2380952380952381],
  [200.0, 0.2380952380952381, 0.2222222222222222],
  [2200.0, 0.2222222222222222, 0.2777777777777778],
  [1500.0, 0.2777777777777778, 0.125],
  [4900.0, 0.125, 0.2916666666666667],
  [23000.0, 0.2916666666666667, 0.2333333333333333],
  [4600.0, 0.2333333333333333, 0.08333333333333333],
  [1200.0, 0.08333333333333333, 0.16666666666666666],
  [6700.0, 0.16666666666666666, 0.1111111111111111],
  [5200.0, 0.1111111111111111, 0.14285714285714285],
  [6600.0, 0.14285714285714285, 0.041666666666666664],
  [2200.0, 0.041666666666666664, 0.26666666666666666],
  [900.0, 0.26666666666666666, 0.25],
  [51500.0, 0.25, 0.07142857142857142],
  [1800.0, 0.07142857142857142, 0.26666666666666666],
  [14500.0, 0.26666666666666666, 0.14285714285714285],
  [17900.0, 0.14285714285714285, 0.25],
  [1700.0, 0.25, 0.2857142857142857],
  [200.0, 0.2857142857142857, 0.2222222222222222],
  [11300.0, 0.2222222222222222, 0.3333333333333333],
  [200.0, 0.3333333333333333, 0.2222222222222222],
  [24300.0, 0.2222222222222222, 0.2777777777777778],
  [1300.0, 0.2777777777777778, 0.3333333333333333],
  [15800.0, 0.3333333333333333, 0.06666666666666667],
  [19800.0, 0.06666666666666667, 0.08333333333333333],
  [15000.0, 0.08333333333333333, 0.1111111111111111],
  [4300.0, 0.1111111111111111, 0.1111111111111111],
  [17700.0, 0.1111111111111111, 0.09523809523809523],
  [7200.0, 0.09523809523809523, 0.19047619047619047],
  [2400.0, 0.19047619047619047, 0.08333333333333333],
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
