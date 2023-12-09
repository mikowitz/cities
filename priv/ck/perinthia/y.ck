[
  [3900.0, 0.0, 0.0],
  [30800.0, 0.0, 0.2],
  [14200.0, 0.2, 0.2],
  [52800.0, 0.2, 0.2],
  [51400.0, 0.2, 0.2],
  [38700.0, 0.2, 0.2],
  [8800.0, 0.2, 0.04],
  [13200.0, 0.04, 0.2],
  [47900.0, 0.2, 0.2],
  [62700.0, 0.2, 0.2],
  [20500.0, 0.2, 0.2],
  [200.0, 0.2, 0.2],
  [91400.0, 0.2, 0.06666666666666667],
  [39300.0, 0.06666666666666667, 0.2],
  [16600.0, 0.2, 0.2],
  [4300.0, 0.2, 0.2],
  [3900.0, 0.2, 0.2],
] @=> float fades[][];

Gain g => dac;
0.0 => g.gain;

SinOsc s => Pan2 p => g;
0.85 => p.pan;
2500.0 => s.freq;

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
