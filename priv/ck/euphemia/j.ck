[
  [99300.0, 0.0, 0.0],
  [42200.0, 0.0, 0.05],
  [228700.0, 0.05, 0.02857142857142857],
  [20600.0, 0.02857142857142857, 0.02857142857142857],
  [88000.0, 0.02857142857142857, 0.04],
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