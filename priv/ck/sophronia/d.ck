[
  [9000.0, 0.0, 0.0],
  [52900.0, 0.0, 0.375],
  [3400.0, 0.375, 0.05555555555555555],
  [31800.0, 0.05555555555555555, 0.4444444444444444],
  [200.0, 0.4444444444444444, 0.25],
  [10500.0, 0.25, 0.3333333333333333],
  [3400.0, 0.3333333333333333, 0.5],
  [23800.0, 0.5, 0.5],
  [24200.0, 0.5, 0.5],
  [5200.0, 0.5, 0.5],
  [13500.0, 0.5, 0.5],
  [5600.0, 0.5, 0.05555555555555555],
  [22300.0, 0.05555555555555555, 0.5],
  [4800.0, 0.5, 0.5],
  [12900.0, 0.5, 0.16666666666666666],
  [14000.0, 0.16666666666666666, 0.16666666666666666],
  [12700.0, 0.16666666666666666, 0.125],
  [14300.0, 0.125, 0.1],
  [11600.0, 0.1, 0.5],
  [2300.0, 0.5, 0.5],
  [32900.0, 0.5, 0.5],
  [10100.0, 0.5, 0.5],
  [300.0, 0.5, 0.3888888888888889],
  [7000.0, 0.3888888888888889, 0.5],
  [7900.0, 0.5, 0.25],
  [11500.0, 0.25, 0.5],
  [16800.0, 0.5, 0.125],
  [9900.0, 0.125, 0.5],
] @=> float fades[][];

Gain g => dac;
0.0 => g.gain;

SinOsc s => Pan2 p => g;
-0.7 => p.pan;
400.0 => s.freq;

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
