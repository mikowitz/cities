[
  [31800.0, 0.0, 0.0],
  [48000.0, 0.0, 0.015384615384615385],
  [181100.0, 0.015384615384615385, 0.02857142857142857],
  [18100.0, 0.02857142857142857, 0.06666666666666667],
  [675400.0, 0.06666666666666667, 0.06666666666666667],
  [124300.0, 0.06666666666666667, 0.1],
] @=> float fades[][];

Gain g => dac;
0.0 => g.gain;

SinOsc s => Pan2 p => g;
-0.26 => p.pan;
1000.0 => s.freq;

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
