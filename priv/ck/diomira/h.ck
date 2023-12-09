[
  [3200.0, 0.0, 0.0],
  [9000.0, 0.0, 0.2],
  [5300.0, 0.2, 0.2],
  [4300.0, 0.2, 0.3333333333333333],
  [7700.0, 0.3333333333333333, 0.5],
  [12600.0, 0.5, 0.5],
  [6900.0, 0.5, 0.3333333333333333],
  [4400.0, 0.3333333333333333, 0.5],
  [5600.0, 0.5, 0.14285714285714285],
  [3500.0, 0.14285714285714285, 0.25],
  [8900.0, 0.25, 0.5],
  [13200.0, 0.5, 0.2],
  [4600.0, 0.2, 0.3333333333333333],
  [600.0, 0.3333333333333333, 0.3333333333333333],
  [2600.0, 0.3333333333333333, 0.16666666666666666],
  [3900.0, 0.16666666666666666, 0.25],
  [6400.0, 0.25, 0.3],
  [6400.0, 0.3, 0.3333333333333333],
  [5200.0, 0.3333333333333333, 0.25],
  [2100.0, 0.25, 0.3333333333333333],
  [4800.0, 0.3333333333333333, 0.3333333333333333],
  [9300.0, 0.3333333333333333, 0.2],
  [1700.0, 0.2, 0.25],
  [7400.0, 0.25, 0.3333333333333333],
  [4800.0, 0.3333333333333333, 0.14285714285714285],
  [9800.0, 0.14285714285714285, 0.3333333333333333],
  [4500.0, 0.3333333333333333, 0.2857142857142857],
  [3100.0, 0.2857142857142857, 0.3333333333333333],
  [15400.0, 0.3333333333333333, 0.3333333333333333],
  [2100.0, 0.3333333333333333, 0.5],
  [1100.0, 0.5, 0.25],
  [5200.0, 0.25, 0.25],
  [1200.0, 0.25, 0.2],
  [3800.0, 0.2, 0.3333333333333333],
  [800.0, 0.3333333333333333, 0.25],
  [14200.0, 0.25, 0.125],
  [3000.0, 0.125, 0.25],
  [1000.0, 0.25, 0.3333333333333333],
  [2700.0, 0.3333333333333333, 0.2],
  [2300.0, 0.2, 0.25],
  [1900.0, 0.25, 0.1],
  [2900.0, 0.1, 0.25],
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