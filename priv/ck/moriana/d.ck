[
  [4900.0, 0.0, 0.0],
  [300.0, 0.0, 0.3333333333333333],
  [10100.0, 0.3333333333333333, 0.5],
  [8700.0, 0.5, 0.5],
  [200.0, 0.5, 0.1875],
  [3200.0, 0.1875, 0.25],
  [40500.0, 0.25, 0.5],
  [6700.0, 0.5, 0.16666666666666666],
  [23200.0, 0.16666666666666666, 0.5],
  [1100.0, 0.5, 0.2857142857142857],
  [18400.0, 0.2857142857142857, 0.07142857142857142],
  [2900.0, 0.07142857142857142, 0.125],
  [1800.0, 0.125, 0.5],
  [19900.0, 0.5, 0.22727272727272727],
  [24900.0, 0.22727272727272727, 0.42857142857142855],
  [12600.0, 0.42857142857142855, 0.5],
  [200.0, 0.5, 0.25],
  [38400.0, 0.25, 0.3333333333333333],
  [3700.0, 0.3333333333333333, 0.5],
  [8900.0, 0.5, 0.25],
  [9900.0, 0.25, 0.375],
  [55300.0, 0.375, 0.5],
  [14700.0, 0.5, 0.5],
  [19500.0, 0.5, 0.5],
  [10600.0, 0.5, 0.375],
  [6500.0, 0.375, 0.5],
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
