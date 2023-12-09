[
  [27000.0, 0.0, 0.0],
  [90900.0, 0.0, 0.21428571428571427],
  [85400.0, 0.21428571428571427, 0.0625],
  [6500.0, 0.0625, 0.07142857142857142],
  [19700.0, 0.07142857142857142, 0.25],
  [19200.0, 0.25, 0.16666666666666666],
  [25900.0, 0.16666666666666666, 0.4166666666666667],
  [9500.0, 0.4166666666666667, 0.1875],
  [110300.0, 0.1875, 0.5],
  [18600.0, 0.5, 0.05555555555555555],
  [2700.0, 0.05555555555555555, 0.125],
  [8600.0, 0.125, 0.07142857142857142],
  [18600.0, 0.07142857142857142, 0.25],
  [20000.0, 0.25, 0.4166666666666667],
  [500.0, 0.4166666666666667, 0.08333333333333333],
  [12400.0, 0.08333333333333333, 0.3333333333333333],
  [300.0, 0.3333333333333333, 0.5],
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
