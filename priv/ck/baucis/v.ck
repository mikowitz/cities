[
  [2600.0, 0.0, 0.0],
  [12800.0, 0.0, 0.05454545454545454],
  [21900.0, 0.05454545454545454, 0.045454545454545456],
  [33500.0, 0.045454545454545456, 0.06493506493506494],
  [35600.0, 0.06493506493506494, 0.07272727272727274],
  [1200.0, 0.07272727272727274, 0.07272727272727274],
  [4600.0, 0.07272727272727274, 0.045454545454545456],
  [107000.0, 0.045454545454545456, 0.018181818181818184],
  [7100.0, 0.018181818181818184, 0.03636363636363637],
  [25100.0, 0.03636363636363637, 0.06818181818181818],
  [36700.0, 0.06818181818181818, 0.05454545454545454],
] @=> float fades[][];

Gain g => dac;
0.0 => g.gain;

SinOsc s => Pan2 p => g;
0.63 => p.pan;
2200.0 => s.freq;

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