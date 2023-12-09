[
  [6100.0, 0.0, 0.0],
  [40500.0, 0.0, 0.05],
  [57000.0, 0.05, 0.1],
  [20800.0, 0.1, 0.14285714285714285],
  [26100.0, 0.14285714285714285, 0.16666666666666666],
  [64800.0, 0.16666666666666666, 0.4],
  [300.0, 0.4, 0.3],
  [3800.0, 0.3, 0.4],
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
