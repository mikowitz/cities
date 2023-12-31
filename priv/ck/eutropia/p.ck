[
  [16300.0, 0.0, 0.0],
  [4000.0, 0.0, 0.375],
  [35800.0, 0.375, 0.21428571428571427],
  [4700.0, 0.21428571428571427, 0.07142857142857142],
  [29800.0, 0.07142857142857142, 0.375],
  [4100.0, 0.375, 0.3],
  [26700.0, 0.3, 0.07142857142857142],
  [11400.0, 0.07142857142857142, 0.3333333333333333],
  [31600.0, 0.3333333333333333, 0.5],
  [500.0, 0.5, 0.08333333333333333],
  [40700.0, 0.08333333333333333, 0.3333333333333333],
  [10900.0, 0.3333333333333333, 0.3],
  [14900.0, 0.3, 0.5],
  [1300.0, 0.5, 0.4444444444444444],
  [10200.0, 0.4444444444444444, 0.14285714285714285],
  [10700.0, 0.14285714285714285, 0.2],
  [8600.0, 0.2, 0.0625],
  [18800.0, 0.0625, 0.5],
  [61000.0, 0.5, 0.1875],
  [13500.0, 0.1875, 0.07142857142857142],
  [20100.0, 0.07142857142857142, 0.1],
  [10300.0, 0.1, 0.375],
  [28900.0, 0.375, 0.25],
  [13400.0, 0.25, 0.21428571428571427],
  [5500.0, 0.21428571428571427, 0.5],
  [11900.0, 0.5, 0.3],
  [14900.0, 0.3, 0.25],
  [3300.0, 0.25, 0.25],
  [14800.0, 0.25, 0.125],
  [23500.0, 0.125, 0.25],
  [4900.0, 0.25, 0.25],
  [35500.0, 0.25, 0.375],
] @=> float fades[][];

Gain g => dac;
0.0 => g.gain;

SinOsc s => Pan2 p => g;
0.19 => p.pan;
1600.0 => s.freq;

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
