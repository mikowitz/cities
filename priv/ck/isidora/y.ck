[
  [26800.0, 0.0, 0.0],
  [2600.0, 0.0, 0.2],
  [7800.0, 0.2, 0.2],
  [58000.0, 0.2, 0.2],
  [20500.0, 0.2, 0.16666666666666669],
  [26800.0, 0.16666666666666669, 0.2],
  [11300.0, 0.2, 0.2],
  [16300.0, 0.2, 0.2],
  [6200.0, 0.2, 0.2],
  [37500.0, 0.2, 0.04],
  [3400.0, 0.04, 0.04],
  [16300.0, 0.04, 0.2],
  [3600.0, 0.2, 0.2],
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
