[
  [46000.0, 0.0, 0.0],
  [83100.0, 0.0, 0.2857142857142857],
  [2500.0, 0.2857142857142857, 0.2222222222222222],
  [38100.0, 0.2222222222222222, 0.0625],
  [300.0, 0.0625, 0.1875],
  [11200.0, 0.1875, 0.25],
  [132500.0, 0.25, 0.16666666666666666],
  [4500.0, 0.16666666666666666, 0.2857142857142857],
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
