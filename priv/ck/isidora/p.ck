[
  [46500.0, 0.0, 0.0],
  [12900.0, 0.0, 0.16666666666666666],
  [6900.0, 0.16666666666666666, 0.16666666666666666],
  [3800.0, 0.16666666666666666, 0.07142857142857142],
  [167000.0, 0.07142857142857142, 0.4],
] @=> float fades[][];

Gain g => dac;
0.0 => g.gain;

SinOsc s => Pan2 p => g;
0.19 => p.pan;
1600.0 => s.freq;

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
