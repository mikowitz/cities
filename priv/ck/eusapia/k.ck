[
  [22800.0, 0.0, 0.0],
  [52500.0, 0.0, 0.06818181818181818],
  [10700.0, 0.06818181818181818, 0.022727272727272728],
  [45500.0, 0.022727272727272728, 0.045454545454545456],
  [61400.0, 0.045454545454545456, 0.06818181818181818],
  [36600.0, 0.06818181818181818, 0.09090909090909091],
  [800.0, 0.09090909090909091, 0.045454545454545456],
  [7100.0, 0.045454545454545456, 0.07272727272727274],
  [26100.0, 0.07272727272727274, 0.07575757575757576],
  [14700.0, 0.07575757575757576, 0.09090909090909091],
  [24800.0, 0.09090909090909091, 0.045454545454545456],
  [11000.0, 0.045454545454545456, 0.051948051948051945],
  [2900.0, 0.051948051948051945, 0.03636363636363637],
  [57800.0, 0.03636363636363637, 0.07272727272727274],
  [91500.0, 0.07272727272727274, 0.051948051948051945],
  [149300.0, 0.051948051948051945, 0.018181818181818184],
  [64600.0, 0.018181818181818184, 0.06818181818181818],
  [41100.0, 0.06818181818181818, 0.022727272727272728],
  [74700.0, 0.022727272727272728, 0.05454545454545454],
  [10700.0, 0.05454545454545454, 0.012987012987012986],
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