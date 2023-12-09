[
  [18400.0, 0.0, 0.0],
  [43200.0, 0.0, 0.5],
  [23300.0, 0.5, 0.5],
  [19900.0, 0.5, 0.21428571428571427],
  [30000.0, 0.21428571428571427, 0.4444444444444444],
  [300.0, 0.4444444444444444, 0.21428571428571427],
  [42800.0, 0.21428571428571427, 0.2857142857142857],
  [500.0, 0.2857142857142857, 0.08333333333333333],
  [4800.0, 0.08333333333333333, 0.3333333333333333],
  [39400.0, 0.3333333333333333, 0.25],
  [6500.0, 0.25, 0.2222222222222222],
  [300.0, 0.2222222222222222, 0.16666666666666666],
  [14300.0, 0.16666666666666666, 0.25],
  [15300.0, 0.25, 0.07142857142857142],
  [1500.0, 0.07142857142857142, 0.125],
  [18700.0, 0.125, 0.5],
  [16300.0, 0.5, 0.5],
  [300.0, 0.5, 0.21428571428571427],
  [7300.0, 0.21428571428571427, 0.2857142857142857],
  [10000.0, 0.2857142857142857, 0.08333333333333333],
  [34600.0, 0.08333333333333333, 0.07142857142857142],
  [1200.0, 0.07142857142857142, 0.1],
  [1700.0, 0.1, 0.3],
  [11500.0, 0.3, 0.0625],
  [31700.0, 0.0625, 0.5],
  [2000.0, 0.5, 0.16666666666666666],
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
