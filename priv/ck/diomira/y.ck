[
  [14400.0, 0.0, 0.0],
  [4700.0, 0.0, 0.075],
  [8700.0, 0.075, 0.03333333333333333],
  [4000.0, 0.03333333333333333, 0.1],
  [19900.0, 0.1, 0.1],
  [27300.0, 0.1, 0.04285714285714286],
  [29200.0, 0.04285714285714286, 0.1],
  [4100.0, 0.1, 0.1],
  [20900.0, 0.1, 0.1],
  [49600.0, 0.1, 0.075],
  [8400.0, 0.075, 0.1],
  [21700.0, 0.1, 0.1],
  [3000.0, 0.1, 0.1],
  [3500.0, 0.1, 0.1],
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
