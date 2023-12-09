[
  [3500.0, 0.0, 0.0],
  [4700.0, 0.0, 0.1111111111111111],
  [19800.0, 0.1111111111111111, 0.19999999999999998],
  [3500.0, 0.19999999999999998, 0.1818181818181818],
  [26600.0, 0.1818181818181818, 0.13333333333333333],
  [29500.0, 0.13333333333333333, 0.06666666666666667],
  [25200.0, 0.06666666666666667, 0.08333333333333333],
  [9700.0, 0.08333333333333333, 0.2222222222222222],
  [8700.0, 0.2222222222222222, 0.2777777777777778],
  [8800.0, 0.2777777777777778, 0.26666666666666666],
  [9100.0, 0.26666666666666666, 0.14814814814814814],
  [200.0, 0.14814814814814814, 0.16666666666666666],
  [12000.0, 0.16666666666666666, 0.19047619047619047],
  [200.0, 0.19047619047619047, 0.19999999999999998],
  [5800.0, 0.19999999999999998, 0.26666666666666666],
  [9300.0, 0.26666666666666666, 0.2777777777777778],
  [3600.0, 0.2777777777777778, 0.26666666666666666],
  [26900.0, 0.26666666666666666, 0.14285714285714285],
  [1800.0, 0.14285714285714285, 0.26666666666666666],
  [21600.0, 0.26666666666666666, 0.19047619047619047],
  [2400.0, 0.19047619047619047, 0.21212121212121213],
  [12500.0, 0.21212121212121213, 0.26666666666666666],
  [200.0, 0.26666666666666666, 0.1111111111111111],
  [8900.0, 0.1111111111111111, 0.14814814814814814],
  [1200.0, 0.14814814814814814, 0.08333333333333333],
  [5800.0, 0.08333333333333333, 0.16666666666666666],
  [15000.0, 0.16666666666666666, 0.2962962962962963],
  [3500.0, 0.2962962962962963, 0.2380952380952381],
  [29900.0, 0.2380952380952381, 0.20833333333333334],
  [200.0, 0.20833333333333334, 0.19999999999999998],
  [18100.0, 0.19999999999999998, 0.26666666666666666],
  [25000.0, 0.26666666666666666, 0.16666666666666666],
  [25000.0, 0.16666666666666666, 0.25],
  [1000.0, 0.25, 0.3333333333333333],
  [6100.0, 0.3333333333333333, 0.26666666666666666],
  [200.0, 0.26666666666666666, 0.14285714285714285],
  [2900.0, 0.14285714285714285, 0.19047619047619047],
  [4900.0, 0.19047619047619047, 0.06666666666666667],
  [4800.0, 0.06666666666666667, 0.20833333333333334],
  [12400.0, 0.20833333333333334, 0.16666666666666666],
  [19300.0, 0.16666666666666666, 0.08333333333333333],
  [12600.0, 0.08333333333333333, 0.2962962962962963],
  [200.0, 0.2962962962962963, 0.2222222222222222],
  [3600.0, 0.2222222222222222, 0.3333333333333333],
  [1200.0, 0.3333333333333333, 0.08333333333333333],
  [18500.0, 0.08333333333333333, 0.16666666666666666],
  [8300.0, 0.16666666666666666, 0.2777777777777778],
  [5300.0, 0.2777777777777778, 0.16666666666666666],
  [10400.0, 0.16666666666666666, 0.3333333333333333],
  [2300.0, 0.3333333333333333, 0.14814814814814814],
  [8400.0, 0.14814814814814814, 0.2857142857142857],
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