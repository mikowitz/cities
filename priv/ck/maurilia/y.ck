[
  [20700.0, 0.0, 0.0],
  [54100.0, 0.0, 0.2],
  [23400.0, 0.2, 0.04],
  [31400.0, 0.04, 0.2],
  [60800.0, 0.2, 0.2],
  [50100.0, 0.2, 0.2],
  [28100.0, 0.2, 0.2],
  [4700.0, 0.2, 0.1],
  [14700.0, 0.1, 0.2],
  [18200.0, 0.2, 0.2],
  [39500.0, 0.2, 0.2],
  [35900.0, 0.2, 0.1],
  [159900.0, 0.1, 0.08],
  [2800.0, 0.08, 0.2],
  [13000.0, 0.2, 0.2],
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
