[
  [5900.0, 0.0, 0.0],
  [33200.0, 0.0, 0.2],
  [2800.0, 0.2, 0.06666666666666667],
  [61400.0, 0.06666666666666667, 0.16666666666666669],
  [7300.0, 0.16666666666666669, 0.15],
  [7200.0, 0.15, 0.2],
  [2300.0, 0.2, 0.2],
  [18500.0, 0.2, 0.2],
  [6200.0, 0.2, 0.2],
  [28100.0, 0.2, 0.2],
  [600.0, 0.2, 0.2],
  [84400.0, 0.2, 0.2],
  [1600.0, 0.2, 0.2],
  [600.0, 0.2, 0.2],
  [11200.0, 0.2, 0.2],
  [25400.0, 0.2, 0.2],
  [60600.0, 0.2, 0.2],
  [11400.0, 0.2, 0.15],
  [55900.0, 0.15, 0.2],
  [12200.0, 0.2, 0.2],
  [25400.0, 0.2, 0.2],
  [24700.0, 0.2, 0.2],
  [6900.0, 0.2, 0.16],
  [135600.0, 0.16, 0.2],
  [8100.0, 0.2, 0.2],
  [9000.0, 0.2, 0.2],
  [200.0, 0.2, 0.2],
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
