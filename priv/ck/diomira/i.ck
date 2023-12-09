[
  [600.0, 0.0, 0.0],
  [7600.0, 0.0, 0.2380952380952381],
  [14300.0, 0.2380952380952381, 0.26666666666666666],
  [1400.0, 0.26666666666666666, 0.09523809523809523],
  [2600.0, 0.09523809523809523, 0.2380952380952381],
  [1700.0, 0.2380952380952381, 0.16666666666666666],
  [2100.0, 0.16666666666666666, 0.16666666666666666],
  [2000.0, 0.16666666666666666, 0.13333333333333333],
  [15400.0, 0.13333333333333333, 0.1111111111111111],
  [17600.0, 0.1111111111111111, 0.16666666666666666],
  [8900.0, 0.16666666666666666, 0.2380952380952381],
  [1500.0, 0.2380952380952381, 0.25],
  [4700.0, 0.25, 0.16666666666666666],
  [1100.0, 0.16666666666666666, 0.16666666666666666],
  [3800.0, 0.16666666666666666, 0.25],
  [1200.0, 0.25, 0.09523809523809523],
  [7700.0, 0.09523809523809523, 0.19047619047619047],
  [4000.0, 0.19047619047619047, 0.16666666666666666],
  [1300.0, 0.16666666666666666, 0.1111111111111111],
  [4700.0, 0.1111111111111111, 0.2222222222222222],
  [2700.0, 0.2222222222222222, 0.2380952380952381],
  [2700.0, 0.2380952380952381, 0.2380952380952381],
  [1400.0, 0.2380952380952381, 0.25],
  [8400.0, 0.25, 0.16666666666666666],
  [8700.0, 0.16666666666666666, 0.19047619047619047],
  [9000.0, 0.19047619047619047, 0.2380952380952381],
  [9700.0, 0.2380952380952381, 0.2380952380952381],
  [5900.0, 0.2380952380952381, 0.1388888888888889],
  [20500.0, 0.1388888888888889, 0.09523809523809523],
  [2500.0, 0.09523809523809523, 0.19999999999999998],
  [2000.0, 0.19999999999999998, 0.19999999999999998],
  [11300.0, 0.19999999999999998, 0.16666666666666666],
  [6500.0, 0.16666666666666666, 0.19047619047619047],
  [3200.0, 0.19047619047619047, 0.13333333333333333],
  [2200.0, 0.13333333333333333, 0.2380952380952381],
  [2300.0, 0.2380952380952381, 0.037037037037037035],
  [2900.0, 0.037037037037037035, 0.2222222222222222],
  [4000.0, 0.2222222222222222, 0.25],
  [7900.0, 0.25, 0.19999999999999998],
  [1400.0, 0.19999999999999998, 0.16666666666666666],
] @=> float fades[][];

Gain g => dac;
0.0 => g.gain;

SinOsc s => Pan2 p => g;
-0.33 => p.pan;
900.0 => s.freq;

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