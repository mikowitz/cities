[
  [700.0, 0.0, 0.0],
  [10500.0, 0.0, 0.375],
  [10000.0, 0.375, 0.35714285714285715],
  [8300.0, 0.35714285714285715, 0.5],
  [4900.0, 0.5, 0.5],
  [2100.0, 0.5, 0.4166666666666667],
  [8000.0, 0.4166666666666667, 0.1],
  [6700.0, 0.1, 0.4166666666666667],
  [6100.0, 0.4166666666666667, 0.5],
  [10100.0, 0.5, 0.5],
  [30700.0, 0.5, 0.5],
  [8400.0, 0.5, 0.25],
  [22100.0, 0.25, 0.3],
  [8600.0, 0.3, 0.5],
  [23000.0, 0.5, 0.5],
  [9300.0, 0.5, 0.42857142857142855],
  [3600.0, 0.42857142857142855, 0.5],
  [6100.0, 0.5, 0.4],
  [13300.0, 0.4, 0.5],
  [2100.0, 0.5, 0.125],
  [21700.0, 0.125, 0.5],
  [4400.0, 0.5, 0.5],
  [14000.0, 0.5, 0.5],
  [20800.0, 0.5, 0.045454545454545456],
  [15200.0, 0.045454545454545456, 0.5],
  [11700.0, 0.5, 0.25],
  [31500.0, 0.25, 0.5],
  [68400.0, 0.5, 0.1875],
  [5700.0, 0.1875, 0.5],
  [40000.0, 0.5, 0.5],
  [25600.0, 0.5, 0.0625],
  [200.0, 0.0625, 0.5],
  [12300.0, 0.5, 0.045454545454545456],
  [7300.0, 0.045454545454545456, 0.35714285714285715],
  [1100.0, 0.35714285714285715, 0.21428571428571427],
  [20000.0, 0.21428571428571427, 0.08333333333333333],
  [3800.0, 0.08333333333333333, 0.5],
  [6500.0, 0.5, 0.5],
  [16500.0, 0.5, 0.35714285714285715],
  [25400.0, 0.35714285714285715, 0.375],
  [20200.0, 0.375, 0.35714285714285715],
  [17100.0, 0.35714285714285715, 0.35714285714285715],
  [1100.0, 0.35714285714285715, 0.5],
  [32700.0, 0.5, 0.5],
  [21200.0, 0.5, 0.5],
  [7300.0, 0.5, 0.5],
  [34200.0, 0.5, 0.29411764705882354],
  [3800.0, 0.29411764705882354, 0.5],
  [12400.0, 0.5, 0.125],
  [600.0, 0.125, 0.0625],
  [9200.0, 0.0625, 0.25],
  [28600.0, 0.25, 0.3125],
  [13400.0, 0.3125, 0.5],
  [1600.0, 0.5, 0.5],
  [26600.0, 0.5, 0.4],
  [9300.0, 0.4, 0.35714285714285715],
  [23900.0, 0.35714285714285715, 0.3125],
  [6200.0, 0.3125, 0.5],
  [4100.0, 0.5, 0.5],
] @=> float fades[][];

Gain g => dac;
0.0 => g.gain;

SinOsc s => Pan2 p => g;
-0.7 => p.pan;
400.0 => s.freq;

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