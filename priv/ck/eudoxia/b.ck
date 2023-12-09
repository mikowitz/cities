[
  [8900.0, 0.0, 0.0],
  [31800.0, 0.0, 0.125],
  [23000.0, 0.125, 0.14285714285714285],
  [53200.0, 0.14285714285714285, 0.375],
  [19700.0, 0.375, 0.045454545454545456],
  [9700.0, 0.045454545454545456, 0.25],
  [14700.0, 0.25, 0.16666666666666666],
  [77700.0, 0.16666666666666666, 0.08333333333333333],
  [1500.0, 0.08333333333333333, 0.25],
  [21500.0, 0.25, 0.08333333333333333],
  [6100.0, 0.08333333333333333, 0.07142857142857142],
  [27700.0, 0.07142857142857142, 0.2777777777777778],
  [63500.0, 0.2777777777777778, 0.16666666666666666],
  [52000.0, 0.16666666666666666, 0.16666666666666666],
  [28200.0, 0.16666666666666666, 0.08333333333333333],
  [13800.0, 0.08333333333333333, 0.25],
  [33600.0, 0.25, 0.3125],
  [24300.0, 0.3125, 0.2],
  [7200.0, 0.2, 0.2],
  [1300.0, 0.2, 0.125],
  [2700.0, 0.125, 0.07142857142857142],
  [18100.0, 0.07142857142857142, 0.14285714285714285],
  [24400.0, 0.14285714285714285, 0.14285714285714285],
  [43300.0, 0.14285714285714285, 0.25],
  [49100.0, 0.25, 0.125],
  [63800.0, 0.125, 0.16666666666666666],
  [23000.0, 0.16666666666666666, 0.35714285714285715],
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
