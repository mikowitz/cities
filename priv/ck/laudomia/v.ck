[
  [4500.0, 0.0, 0.0],
  [107700.0, 0.0, 0.03636363636363637],
  [45800.0, 0.03636363636363637, 0.045454545454545456],
  [50400.0, 0.045454545454545456, 0.0303030303030303],
  [34100.0, 0.0303030303030303, 0.045454545454545456],
  [12100.0, 0.045454545454545456, 0.07272727272727274],
  [7500.0, 0.07272727272727274, 0.045454545454545456],
  [29400.0, 0.045454545454545456, 0.018181818181818184],
  [38800.0, 0.018181818181818184, 0.045454545454545456],
  [23600.0, 0.045454545454545456, 0.03409090909090909],
  [22600.0, 0.03409090909090909, 0.045454545454545456],
  [40400.0, 0.045454545454545456, 0.045454545454545456],
  [40800.0, 0.045454545454545456, 0.06818181818181818],
  [79100.0, 0.06818181818181818, 0.022727272727272728],
  [59900.0, 0.022727272727272728, 0.06493506493506494],
  [14900.0, 0.06493506493506494, 0.03636363636363637],
  [43400.0, 0.03636363636363637, 0.03636363636363637],
  [32200.0, 0.03636363636363637, 0.022727272727272728],
  [86400.0, 0.022727272727272728, 0.05454545454545454],
  [8800.0, 0.05454545454545454, 0.03409090909090909],
  [6400.0, 0.03409090909090909, 0.06818181818181818],
  [53400.0, 0.06818181818181818, 0.045454545454545456],
  [4100.0, 0.045454545454545456, 0.07272727272727274],
  [20200.0, 0.07272727272727274, 0.045454545454545456],
  [148100.0, 0.045454545454545456, 0.051948051948051945],
  [13200.0, 0.051948051948051945, 0.045454545454545456],
  [69700.0, 0.045454545454545456, 0.011363636363636364],
  [10200.0, 0.011363636363636364, 0.045454545454545456],
  [11200.0, 0.045454545454545456, 0.03636363636363637],
  [45800.0, 0.03636363636363637, 0.0303030303030303],
  [168000.0, 0.0303030303030303, 0.045454545454545456],
  [60800.0, 0.045454545454545456, 0.045454545454545456],
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