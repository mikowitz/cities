[
  [0.0, 0.0, 0.0],
  [4300.0, 0.0, 0.16666666666666666],
  [1000.0, 0.16666666666666666, 0.16666666666666666],
  [5400.0, 0.16666666666666666, 0.25],
  [5800.0, 0.25, 0.3333333333333333],
  [4500.0, 0.3333333333333333, 0.13333333333333333],
  [2500.0, 0.13333333333333333, 0.14285714285714285],
  [1900.0, 0.14285714285714285, 0.16666666666666666],
  [4100.0, 0.16666666666666666, 0.2222222222222222],
  [6600.0, 0.2222222222222222, 0.3333333333333333],
  [2900.0, 0.3333333333333333, 0.3333333333333333],
  [5000.0, 0.3333333333333333, 0.2380952380952381],
  [6400.0, 0.2380952380952381, 0.09523809523809523],
  [1600.0, 0.09523809523809523, 0.19999999999999998],
  [18600.0, 0.19999999999999998, 0.3333333333333333],
  [9200.0, 0.3333333333333333, 0.07407407407407407],
  [4000.0, 0.07407407407407407, 0.16666666666666666],
  [4600.0, 0.16666666666666666, 0.1111111111111111],
  [3800.0, 0.1111111111111111, 0.25],
  [4800.0, 0.25, 0.25925925925925924],
  [4500.0, 0.25925925925925924, 0.25925925925925924],
  [13300.0, 0.25925925925925924, 0.13333333333333333],
  [13100.0, 0.13333333333333333, 0.16666666666666666],
  [6100.0, 0.16666666666666666, 0.07407407407407407],
  [10700.0, 0.07407407407407407, 0.13333333333333333],
  [3100.0, 0.13333333333333333, 0.25],
  [3100.0, 0.25, 0.13333333333333333],
  [1400.0, 0.13333333333333333, 0.16666666666666666],
  [7200.0, 0.16666666666666666, 0.3333333333333333],
  [8600.0, 0.3333333333333333, 0.3333333333333333],
  [5600.0, 0.3333333333333333, 0.3333333333333333],
  [9700.0, 0.3333333333333333, 0.3333333333333333],
  [3400.0, 0.3333333333333333, 0.07407407407407407],
  [12900.0, 0.07407407407407407, 0.16666666666666666],
  [6200.0, 0.16666666666666666, 0.3333333333333333],
  [2300.0, 0.3333333333333333, 0.030303030303030304],
  [2500.0, 0.030303030303030304, 0.1818181818181818],
  [13700.0, 0.1818181818181818, 0.2380952380952381],
  [8600.0, 0.2380952380952381, 0.2380952380952381],
  [4400.0, 0.2380952380952381, 0.3333333333333333],
  [13700.0, 0.3333333333333333, 0.3333333333333333],
  [6600.0, 0.3333333333333333, 0.16666666666666666],
  [2900.0, 0.16666666666666666, 0.16666666666666666],
  [4900.0, 0.16666666666666666, 0.25],
  [3700.0, 0.25, 0.16666666666666666],
  [13100.0, 0.16666666666666666, 0.2222222222222222],
  [2500.0, 0.2222222222222222, 0.2777777777777778],
  [3900.0, 0.2777777777777778, 0.2777777777777778],
  [7800.0, 0.2777777777777778, 0.16666666666666666],
  [4500.0, 0.16666666666666666, 0.19999999999999998],
  [10700.0, 0.19999999999999998, 0.26666666666666666],
  [6500.0, 0.26666666666666666, 0.09523809523809523],
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