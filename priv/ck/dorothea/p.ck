[
  [45500.0, 0.0, 0.0],
  [3700.0, 0.0, 0.07142857142857142],
  [9400.0, 0.07142857142857142, 0.2857142857142857],
  [94400.0, 0.2857142857142857, 0.25],
  [16500.0, 0.25, 0.07142857142857142],
  [48200.0, 0.07142857142857142, 0.3125],
  [1200.0, 0.3125, 0.125],
  [43300.0, 0.125, 0.08333333333333333],
  [500.0, 0.08333333333333333, 0.08333333333333333],
  [42800.0, 0.08333333333333333, 0.3333333333333333],
  [2900.0, 0.3333333333333333, 0.0625],
  [4900.0, 0.0625, 0.08333333333333333],
  [59700.0, 0.08333333333333333, 0.35714285714285715],
  [4700.0, 0.35714285714285715, 0.3181818181818182],
  [15900.0, 0.3181818181818182, 0.21428571428571427],
  [9100.0, 0.21428571428571427, 0.125],
  [14900.0, 0.125, 0.16666666666666666],
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