[
  [1100.0, 0.0, 0.0],
  [19400.0, 0.0, 0.06666666666666667],
  [20800.0, 0.06666666666666667, 0.2],
  [22600.0, 0.2, 0.2],
  [14300.0, 0.2, 0.06666666666666667],
  [9400.0, 0.06666666666666667, 0.05],
  [40600.0, 0.05, 0.06666666666666667],
  [19900.0, 0.06666666666666667, 0.06666666666666667],
  [116200.0, 0.06666666666666667, 0.2],
  [28000.0, 0.2, 0.12],
  [6100.0, 0.12, 0.2],
  [3300.0, 0.2, 0.2],
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