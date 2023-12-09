[
  [6500.0, 0.0, 0.0],
  [21200.0, 0.0, 0.0625],
  [42400.0, 0.0625, 0.2],
  [46400.0, 0.2, 0.045454545454545456],
  [26700.0, 0.045454545454545456, 0.0625],
  [6300.0, 0.0625, 0.08333333333333333],
  [44600.0, 0.08333333333333333, 0.07142857142857142],
  [17900.0, 0.07142857142857142, 0.3125],
  [37600.0, 0.3125, 0.21428571428571427],
  [10600.0, 0.21428571428571427, 0.35],
  [8400.0, 0.35, 0.1],
  [26400.0, 0.1, 0.0625],
  [17300.0, 0.0625, 0.14285714285714285],
  [49100.0, 0.14285714285714285, 0.07142857142857142],
  [33100.0, 0.07142857142857142, 0.25],
  [33000.0, 0.25, 0.25],
  [1500.0, 0.25, 0.3],
  [23800.0, 0.3, 0.16666666666666666],
  [1800.0, 0.16666666666666666, 0.08333333333333333],
  [17100.0, 0.08333333333333333, 0.1],
  [10500.0, 0.1, 0.375],
  [7300.0, 0.375, 0.0625],
  [25800.0, 0.0625, 0.1],
  [16600.0, 0.1, 0.2],
  [8500.0, 0.2, 0.125],
  [38300.0, 0.125, 0.2],
  [10900.0, 0.2, 0.1],
  [32100.0, 0.1, 0.1],
  [32100.0, 0.1, 0.05],
  [5700.0, 0.05, 0.25],
  [46500.0, 0.25, 0.25],
  [10300.0, 0.25, 0.3333333333333333],
  [82100.0, 0.3333333333333333, 0.05555555555555555],
  [29000.0, 0.05555555555555555, 0.375],
  [5600.0, 0.375, 0.16666666666666666],
  [3400.0, 0.16666666666666666, 0.35714285714285715],
  [14000.0, 0.35714285714285715, 0.3333333333333333],
  [3200.0, 0.3333333333333333, 0.08333333333333333],
  [8300.0, 0.08333333333333333, 0.08333333333333333],
  [98700.0, 0.08333333333333333, 0.16666666666666666],
  [28800.0, 0.16666666666666666, 0.0625],
  [9500.0, 0.0625, 0.16666666666666666],
  [12500.0, 0.16666666666666666, 0.2],
  [38200.0, 0.2, 0.05555555555555555],
  [600.0, 0.05555555555555555, 0.4166666666666667],
] @=> float fades[][];

Gain g => dac;
0.0 => g.gain;

SinOsc s => Pan2 p => g;
-0.85 => p.pan;
200.0 => s.freq;

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