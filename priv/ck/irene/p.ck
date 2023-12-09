[
  [19800.0, 0.0, 0.0],
  [18500.0, 0.0, 0.07142857142857142],
  [4600.0, 0.07142857142857142, 0.3333333333333333],
  [12100.0, 0.3333333333333333, 0.125],
  [82300.0, 0.125, 0.16666666666666666],
  [13300.0, 0.16666666666666666, 0.16666666666666666],
  [3100.0, 0.16666666666666666, 0.07142857142857142],
  [39600.0, 0.07142857142857142, 0.2222222222222222],
  [24400.0, 0.2222222222222222, 0.2],
  [16500.0, 0.2, 0.3125],
  [14700.0, 0.3125, 0.375],
  [3100.0, 0.375, 0.16666666666666666],
  [38500.0, 0.16666666666666666, 0.08333333333333333],
  [300.0, 0.08333333333333333, 0.16666666666666666],
  [15500.0, 0.16666666666666666, 0.2222222222222222],
  [5100.0, 0.2222222222222222, 0.0625],
  [65500.0, 0.0625, 0.15],
  [3800.0, 0.15, 0.5],
  [6900.0, 0.5, 0.1],
  [4100.0, 0.1, 0.21428571428571427],
  [41800.0, 0.21428571428571427, 0.2],
  [18400.0, 0.2, 0.07142857142857142],
  [43800.0, 0.07142857142857142, 0.15],
  [300.0, 0.15, 0.125],
  [9900.0, 0.125, 0.1875],
  [30900.0, 0.1875, 0.125],
  [300.0, 0.125, 0.2857142857142857],
  [55100.0, 0.2857142857142857, 0.35714285714285715],
  [2200.0, 0.35714285714285715, 0.07142857142857142],
  [4900.0, 0.07142857142857142, 0.42857142857142855],
  [11400.0, 0.42857142857142855, 0.16666666666666666],
  [2200.0, 0.16666666666666666, 0.07142857142857142],
  [2700.0, 0.07142857142857142, 0.42857142857142855],
  [5800.0, 0.42857142857142855, 0.16666666666666666],
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