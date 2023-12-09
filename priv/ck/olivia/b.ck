[
  [4200.0, 0.0, 0.0],
  [3100.0, 0.0, 0.25],
  [13500.0, 0.25, 0.08333333333333333],
  [12200.0, 0.08333333333333333, 0.25],
  [3500.0, 0.25, 0.4375],
  [20600.0, 0.4375, 0.07142857142857142],
  [33200.0, 0.07142857142857142, 0.4375],
  [22400.0, 0.4375, 0.25],
  [7700.0, 0.25, 0.25],
  [28700.0, 0.25, 0.08333333333333333],
  [39400.0, 0.08333333333333333, 0.16666666666666666],
  [39800.0, 0.16666666666666666, 0.0625],
  [54100.0, 0.0625, 0.22727272727272727],
  [39700.0, 0.22727272727272727, 0.16666666666666666],
  [15500.0, 0.16666666666666666, 0.25],
  [61300.0, 0.25, 0.22727272727272727],
  [2900.0, 0.22727272727272727, 0.07142857142857142],
  [7900.0, 0.07142857142857142, 0.1],
  [44400.0, 0.1, 0.16666666666666666],
  [89500.0, 0.16666666666666666, 0.08333333333333333],
  [3400.0, 0.08333333333333333, 0.25],
  [10200.0, 0.25, 0.1],
  [6300.0, 0.1, 0.4375],
  [38200.0, 0.4375, 0.125],
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