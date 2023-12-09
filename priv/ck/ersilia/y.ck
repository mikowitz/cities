[
  [23600.0, 0.0, 0.0],
  [33000.0, 0.0, 0.16],
  [14300.0, 0.16, 0.2],
  [15900.0, 0.2, 0.2],
  [2000.0, 0.2, 0.2],
  [14400.0, 0.2, 0.2],
  [26600.0, 0.2, 0.06666666666666667],
  [46900.0, 0.06666666666666667, 0.2],
  [26300.0, 0.2, 0.08888888888888888],
  [8300.0, 0.08888888888888888, 0.2],
  [6500.0, 0.2, 0.2],
  [11200.0, 0.2, 0.2],
  [16200.0, 0.2, 0.2],
  [26200.0, 0.2, 0.2],
  [20800.0, 0.2, 0.2],
  [15800.0, 0.2, 0.2],
  [4200.0, 0.2, 0.2],
  [41300.0, 0.2, 0.06666666666666667],
  [20100.0, 0.06666666666666667, 0.2],
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
