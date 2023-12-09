[
  [44400.0, 0.0, 0.0],
  [48400.0, 0.0, 0.03636363636363637],
  [20800.0, 0.03636363636363637, 0.03896103896103896],
  [65600.0, 0.03896103896103896, 0.05454545454545454],
  [107000.0, 0.05454545454545454, 0.06818181818181818],
  [24000.0, 0.06818181818181818, 0.07272727272727274],
  [7000.0, 0.07272727272727274, 0.09090909090909091],
  [42000.0, 0.09090909090909091, 0.09090909090909091],
  [116900.0, 0.09090909090909091, 0.06818181818181818],
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
