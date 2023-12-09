[
  [32200.0, 0.0, 0.0],
  [5300.0, 0.0, 0.1875],
  [10300.0, 0.1875, 0.05],
  [14600.0, 0.05, 0.05],
  [29100.0, 0.05, 0.045454545454545456],
  [34500.0, 0.045454545454545456, 0.07142857142857142],
  [18800.0, 0.07142857142857142, 0.2222222222222222],
  [2200.0, 0.2222222222222222, 0.07142857142857142],
  [12600.0, 0.07142857142857142, 0.42857142857142855],
  [113000.0, 0.42857142857142855, 0.1875],
  [9700.0, 0.1875, 0.2857142857142857],
  [2800.0, 0.2857142857142857, 0.16666666666666666],
  [39200.0, 0.16666666666666666, 0.125],
  [46800.0, 0.125, 0.2],
  [5500.0, 0.2, 0.05],
  [25900.0, 0.05, 0.13636363636363635],
  [32000.0, 0.13636363636363635, 0.07142857142857142],
  [8200.0, 0.07142857142857142, 0.08333333333333333],
  [21300.0, 0.08333333333333333, 0.14285714285714285],
  [2200.0, 0.14285714285714285, 0.07142857142857142],
  [21100.0, 0.07142857142857142, 0.42857142857142855],
  [10600.0, 0.42857142857142855, 0.05],
  [14200.0, 0.05, 0.16666666666666666],
  [69900.0, 0.16666666666666666, 0.25],
  [14700.0, 0.25, 0.5],
  [26900.0, 0.5, 0.2],
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
