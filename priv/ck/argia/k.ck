[
  [1900.0, 0.0, 0.0],
  [42100.0, 0.0, 0.05454545454545454],
  [40600.0, 0.05454545454545454, 0.07272727272727274],
  [6000.0, 0.07272727272727274, 0.07272727272727274],
  [600.0, 0.07272727272727274, 0.06818181818181818],
  [7100.0, 0.06818181818181818, 0.03636363636363637],
  [77500.0, 0.03636363636363637, 0.022727272727272728],
  [61200.0, 0.022727272727272728, 0.09090909090909091],
] @=> float fades[][];

Gain g => dac;
0.0 => g.gain;

SinOsc s => Pan2 p => g;
-0.19 => p.pan;
1100.0 => s.freq;

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
