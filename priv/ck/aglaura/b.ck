[
  [9800.0, 0.0, 0.0],
  [4900.0, 0.0, 0.2],
  [10900.0, 0.2, 0.08333333333333333],
  [14700.0, 0.08333333333333333, 0.22727272727272727],
  [10300.0, 0.22727272727272727, 0.35],
  [27900.0, 0.35, 0.35],
  [23500.0, 0.35, 0.1111111111111111],
  [70900.0, 0.1111111111111111, 0.3],
  [10300.0, 0.3, 0.35714285714285715],
  [3500.0, 0.35714285714285715, 0.16666666666666666],
  [4900.0, 0.16666666666666666, 0.07142857142857142],
  [49400.0, 0.07142857142857142, 0.08333333333333333],
  [53100.0, 0.08333333333333333, 0.3181818181818182],
  [15100.0, 0.3181818181818182, 0.25],
  [49700.0, 0.25, 0.16666666666666666],
  [51200.0, 0.16666666666666666, 0.4375],
  [6300.0, 0.4375, 0.16666666666666666],
  [29600.0, 0.16666666666666666, 0.25],
  [14900.0, 0.25, 0.08333333333333333],
  [20200.0, 0.08333333333333333, 0.4166666666666667],
  [25800.0, 0.4166666666666667, 0.16666666666666666],
  [19100.0, 0.16666666666666666, 0.14285714285714285],
  [5200.0, 0.14285714285714285, 0.22727272727272727],
  [69700.0, 0.22727272727272727, 0.07142857142857142],
  [20500.0, 0.07142857142857142, 0.07142857142857142],
  [2200.0, 0.07142857142857142, 0.125],
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
