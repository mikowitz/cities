[
  [14400.0, 0.0, 0.0],
  [4700.0, 0.0, 0.15],
  [8700.0, 0.15, 0.06666666666666667],
  [4000.0, 0.06666666666666667, 0.2],
  [19900.0, 0.2, 0.2],
  [27300.0, 0.2, 0.08571428571428572],
  [29200.0, 0.08571428571428572, 0.2],
  [4100.0, 0.2, 0.2],
  [20900.0, 0.2, 0.2],
  [49600.0, 0.2, 0.15],
  [8400.0, 0.15, 0.2],
  [21700.0, 0.2, 0.2],
  [3000.0, 0.2, 0.2],
  [3500.0, 0.2, 0.2],
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
