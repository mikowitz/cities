[
  [90200.0, 0.0, 0.0],
  [64200.0, 0.0, 0.16666666666666666],
  [33600.0, 0.16666666666666666, 0.19999999999999998],
  [222300.0, 0.19999999999999998, 0.25],
  [80900.0, 0.25, 0.3333333333333333],
  [9400.0, 0.3333333333333333, 0.09523809523809523],
] @=> float fades[][];

Gain g => dac;
0.0 => g.gain;

SinOsc s => Pan2 p => g;
0.78 => p.pan;
2400.0 => s.freq;

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
