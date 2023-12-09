[
  [27200.0, 0.0, 0.0],
  [2300.0, 0.0, 0.1],
  [45100.0, 0.1, 0.1],
  [13900.0, 0.1, 0.1],
  [300.0, 0.1, 0.125],
  [3900.0, 0.125, 0.16666666666666666],
  [101000.0, 0.16666666666666666, 0.1],
  [47300.0, 0.1, 0.35],
  [39200.0, 0.35, 0.2],
  [40700.0, 0.2, 0.3888888888888889],
  [40500.0, 0.3888888888888889, 0.1],
  [5000.0, 0.1, 0.1],
] @=> float fades[][];

Gain g => dac;
0.0 => g.gain;

SinOsc s => Pan2 p => g;
-0.85 => p.pan;
200.0 => s.freq;

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
