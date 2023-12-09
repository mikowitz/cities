[
  [700.0, 0.0, 0.0],
  [1000.0, 0.0, 0.375],
  [800.0, 0.375, 0.2],
  [2800.0, 0.2, 0.1],
  [13000.0, 0.1, 0.5],
  [2400.0, 0.5, 0.375],
  [600.0, 0.375, 0.3333333333333333],
  [4600.0, 0.3333333333333333, 0.2],
  [700.0, 0.2, 0.42857142857142855],
  [5900.0, 0.42857142857142855, 0.16666666666666666],
  [10400.0, 0.16666666666666666, 0.16666666666666666],
  [700.0, 0.16666666666666666, 0.375],
  [12100.0, 0.375, 0.2],
  [2200.0, 0.2, 0.3],
  [3800.0, 0.3, 0.07142857142857142],
  [2400.0, 0.07142857142857142, 0.1875],
  [5400.0, 0.1875, 0.4375],
  [9800.0, 0.4375, 0.25],
  [1700.0, 0.25, 0.25],
  [6700.0, 0.25, 0.16666666666666666],
  [16000.0, 0.16666666666666666, 0.35714285714285715],
  [1800.0, 0.35714285714285715, 0.18181818181818182],
  [1800.0, 0.18181818181818182, 0.36363636363636365],
  [1600.0, 0.36363636363636365, 0.3333333333333333],
  [14800.0, 0.3333333333333333, 0.1],
  [12500.0, 0.1, 0.16666666666666666],
  [8300.0, 0.16666666666666666, 0.125],
  [2800.0, 0.125, 0.16666666666666666],
  [900.0, 0.16666666666666666, 0.25],
  [13600.0, 0.25, 0.3],
  [8300.0, 0.3, 0.2222222222222222],
  [1300.0, 0.2222222222222222, 0.08333333333333333],
  [3100.0, 0.08333333333333333, 0.4166666666666667],
  [10400.0, 0.4166666666666667, 0.25],
  [2800.0, 0.25, 0.1],
  [400.0, 0.1, 0.5],
  [3700.0, 0.5, 0.3333333333333333],
  [6300.0, 0.3333333333333333, 0.3333333333333333],
  [1600.0, 0.3333333333333333, 0.16666666666666666],
  [6800.0, 0.16666666666666666, 0.3333333333333333],
  [4200.0, 0.3333333333333333, 0.3],
  [10100.0, 0.3, 0.25],
  [7600.0, 0.25, 0.3333333333333333],
  [4500.0, 0.3333333333333333, 0.3333333333333333],
  [1300.0, 0.3333333333333333, 0.375],
  [2200.0, 0.375, 0.5],
  [600.0, 0.5, 0.375],
] @=> float fades[][];

Gain g => dac;
0.0 => g.gain;

SinOsc s => Pan2 p => g;
-0.93 => p.pan;
100.0 => s.freq;

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
