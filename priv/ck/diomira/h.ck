[
  [3200.0, 0.0, 0.0],
  [9000.0, 0.0, 0.1],
  [5300.0, 0.1, 0.1],
  [4300.0, 0.1, 0.16666666666666666],
  [7700.0, 0.16666666666666666, 0.25],
  [12600.0, 0.25, 0.25],
  [6900.0, 0.25, 0.16666666666666666],
  [4400.0, 0.16666666666666666, 0.25],
  [5600.0, 0.25, 0.07142857142857142],
  [3500.0, 0.07142857142857142, 0.125],
  [8900.0, 0.125, 0.25],
  [13200.0, 0.25, 0.1],
  [4600.0, 0.1, 0.16666666666666666],
  [600.0, 0.16666666666666666, 0.16666666666666666],
  [2600.0, 0.16666666666666666, 0.08333333333333333],
  [3900.0, 0.08333333333333333, 0.125],
  [6400.0, 0.125, 0.15],
  [6400.0, 0.15, 0.16666666666666666],
  [5200.0, 0.16666666666666666, 0.125],
  [2100.0, 0.125, 0.16666666666666666],
  [4800.0, 0.16666666666666666, 0.16666666666666666],
  [9300.0, 0.16666666666666666, 0.1],
  [1700.0, 0.1, 0.125],
  [7400.0, 0.125, 0.16666666666666666],
  [4800.0, 0.16666666666666666, 0.07142857142857142],
  [9800.0, 0.07142857142857142, 0.16666666666666666],
  [4500.0, 0.16666666666666666, 0.14285714285714285],
  [3100.0, 0.14285714285714285, 0.16666666666666666],
  [15400.0, 0.16666666666666666, 0.16666666666666666],
  [2100.0, 0.16666666666666666, 0.25],
  [1100.0, 0.25, 0.125],
  [5200.0, 0.125, 0.125],
  [1200.0, 0.125, 0.1],
  [3800.0, 0.1, 0.16666666666666666],
  [800.0, 0.16666666666666666, 0.125],
  [14200.0, 0.125, 0.0625],
  [3000.0, 0.0625, 0.125],
  [1000.0, 0.125, 0.16666666666666666],
  [2700.0, 0.16666666666666666, 0.1],
  [2300.0, 0.1, 0.125],
  [1900.0, 0.125, 0.05],
  [2900.0, 0.05, 0.125],
] @=> float fades[][];

Gain g => dac;
0.0 => g.gain;

SinOsc s => Pan2 p => g;
-0.41 => p.pan;
800.0 => s.freq;

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
