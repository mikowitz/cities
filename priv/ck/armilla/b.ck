[
  [10800.0, 0.0, 0.0],
  [11000.0, 0.0, 0.07142857142857142],
  [4300.0, 0.07142857142857142, 0.07142857142857142],
  [77200.0, 0.07142857142857142, 0.125],
  [16900.0, 0.125, 0.25],
  [23400.0, 0.25, 0.25],
  [7600.0, 0.25, 0.35714285714285715],
  [2600.0, 0.35714285714285715, 0.07142857142857142],
  [23100.0, 0.07142857142857142, 0.5],
  [10600.0, 0.5, 0.08333333333333333],
  [10000.0, 0.08333333333333333, 0.3125],
  [3700.0, 0.3125, 0.5],
  [2900.0, 0.5, 0.08333333333333333],
  [25700.0, 0.08333333333333333, 0.045454545454545456],
  [24800.0, 0.045454545454545456, 0.42857142857142855],
  [2500.0, 0.42857142857142855, 0.1111111111111111],
  [9000.0, 0.1111111111111111, 0.08333333333333333],
  [7400.0, 0.08333333333333333, 0.2777777777777778],
  [57000.0, 0.2777777777777778, 0.25],
  [2600.0, 0.25, 0.0625],
  [9000.0, 0.0625, 0.4375],
  [33600.0, 0.4375, 0.1],
  [135300.0, 0.1, 0.2857142857142857],
  [48900.0, 0.2857142857142857, 0.1],
  [9000.0, 0.1, 0.08333333333333333],
  [1200.0, 0.08333333333333333, 0.125],
  [2600.0, 0.125, 0.1],
  [57800.0, 0.1, 0.25],
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