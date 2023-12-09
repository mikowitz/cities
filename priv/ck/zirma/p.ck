[
  [52100.0, 0.0, 0.0],
  [13300.0, 0.0, 0.36363636363636365],
  [14100.0, 0.36363636363636365, 0.125],
  [20000.0, 0.125, 0.5],
  [15000.0, 0.5, 0.4],
  [12700.0, 0.4, 0.2],
  [24900.0, 0.2, 0.125],
  [59900.0, 0.125, 0.21428571428571427],
  [48900.0, 0.21428571428571427, 0.4],
  [29300.0, 0.4, 0.2],
  [21800.0, 0.2, 0.16666666666666666],
  [2900.0, 0.16666666666666666, 0.07142857142857142],
  [23400.0, 0.07142857142857142, 0.0625],
  [13300.0, 0.0625, 0.0625],
  [14800.0, 0.0625, 0.21428571428571427],
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
