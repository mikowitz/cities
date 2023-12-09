[
  [6200.0, 0.0, 0.0],
  [16100.0, 0.0, 0.2222222222222222],
  [11300.0, 0.2222222222222222, 0.13333333333333333],
  [1800.0, 0.13333333333333333, 0.16666666666666666],
  [200.0, 0.16666666666666666, 0.25],
  [600.0, 0.25, 0.3333333333333333],
  [8300.0, 0.3333333333333333, 0.08333333333333333],
  [200.0, 0.08333333333333333, 0.25],
  [19900.0, 0.25, 0.3333333333333333],
  [59000.0, 0.3333333333333333, 0.16666666666666666],
  [200.0, 0.16666666666666666, 0.1111111111111111],
  [5700.0, 0.1111111111111111, 0.14814814814814814],
  [1800.0, 0.14814814814814814, 0.3333333333333333],
  [13500.0, 0.3333333333333333, 0.2777777777777778],
  [16100.0, 0.2777777777777778, 0.30303030303030304],
  [9100.0, 0.30303030303030304, 0.14285714285714285],
  [9900.0, 0.14285714285714285, 0.2380952380952381],
  [30100.0, 0.2380952380952381, 0.16666666666666666],
  [27200.0, 0.16666666666666666, 0.25],
  [4100.0, 0.25, 0.3333333333333333],
  [200.0, 0.3333333333333333, 0.25],
  [27000.0, 0.25, 0.3333333333333333],
  [2200.0, 0.3333333333333333, 0.13333333333333333],
  [3700.0, 0.13333333333333333, 0.26666666666666666],
  [1600.0, 0.26666666666666666, 0.2333333333333333],
  [7200.0, 0.2333333333333333, 0.25],
  [200.0, 0.25, 0.25],
  [5300.0, 0.25, 0.3333333333333333],
  [10700.0, 0.3333333333333333, 0.2380952380952381],
  [3000.0, 0.2380952380952381, 0.26666666666666666],
  [7800.0, 0.26666666666666666, 0.030303030303030304],
  [7400.0, 0.030303030303030304, 0.13333333333333333],
  [3700.0, 0.13333333333333333, 0.25],
  [200.0, 0.25, 0.2222222222222222],
  [16700.0, 0.2222222222222222, 0.3333333333333333],
  [30000.0, 0.3333333333333333, 0.2777777777777778],
  [3200.0, 0.2777777777777778, 0.16666666666666666],
  [12200.0, 0.16666666666666666, 0.2777777777777778],
  [200.0, 0.2777777777777778, 0.2222222222222222],
  [5600.0, 0.2222222222222222, 0.3333333333333333],
  [200.0, 0.3333333333333333, 0.2222222222222222],
  [2200.0, 0.2222222222222222, 0.3333333333333333],
  [3300.0, 0.3333333333333333, 0.2777777777777778],
  [6200.0, 0.2777777777777778, 0.13333333333333333],
  [14000.0, 0.13333333333333333, 0.30303030303030304],
  [18500.0, 0.30303030303030304, 0.06666666666666667],
  [1500.0, 0.06666666666666667, 0.2777777777777778],
  [4100.0, 0.2777777777777778, 0.2777777777777778],
  [800.0, 0.2777777777777778, 0.3333333333333333],
  [700.0, 0.3333333333333333, 0.16666666666666666],
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
