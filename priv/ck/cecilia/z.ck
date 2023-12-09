[
  [162000.0, 0.0, 0.0],
  [69300.0, 0.0, 0.06837606837606837],
  [103600.0, 0.06837606837606837, 0.04395604395604395],
  [173300.0, 0.04395604395604395, 0.06837606837606837],
  [190800.0, 0.06837606837606837, 0.06153846153846154],
  [11300.0, 0.06153846153846154, 0.06837606837606837],
] @=> float fades[][];

Gain g => dac;
0.0 => g.gain;

SinOsc s => Pan2 p => g;
0.93 => p.pan;
2600.0 => s.freq;

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
