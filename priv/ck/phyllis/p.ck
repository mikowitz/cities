[
  [7800.0, 0.0, 0.0],
  [37200.0, 0.0, 0.07142857142857142],
  [8000.0, 0.07142857142857142, 0.07142857142857142],
  [34900.0, 0.07142857142857142, 0.2222222222222222],
  [23500.0, 0.2222222222222222, 0.07142857142857142],
  [22200.0, 0.07142857142857142, 0.0625],
  [9300.0, 0.0625, 0.1],
  [7600.0, 0.1, 0.2222222222222222],
  [45000.0, 0.2222222222222222, 0.3],
  [3100.0, 0.3, 0.2],
  [300.0, 0.2, 0.3],
  [4600.0, 0.3, 0.4],
  [59400.0, 0.4, 0.07142857142857142],
  [300.0, 0.07142857142857142, 0.21428571428571427],
  [11400.0, 0.21428571428571427, 0.2857142857142857],
  [4000.0, 0.2857142857142857, 0.07142857142857142],
  [26400.0, 0.07142857142857142, 0.2],
  [14700.0, 0.2, 0.1875],
  [32700.0, 0.1875, 0.0625],
  [9500.0, 0.0625, 0.07142857142857142],
  [19200.0, 0.07142857142857142, 0.07142857142857142],
  [35000.0, 0.07142857142857142, 0.16666666666666666],
  [4300.0, 0.16666666666666666, 0.07142857142857142],
  [13200.0, 0.07142857142857142, 0.2],
  [4100.0, 0.2, 0.08333333333333333],
  [43600.0, 0.08333333333333333, 0.2222222222222222],
  [109000.0, 0.2222222222222222, 0.4444444444444444],
  [7400.0, 0.4444444444444444, 0.5],
  [13400.0, 0.5, 0.25],
  [9300.0, 0.25, 0.125],
  [9900.0, 0.125, 0.07142857142857142],
  [9800.0, 0.07142857142857142, 0.4166666666666667],
  [2700.0, 0.4166666666666667, 0.25],
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