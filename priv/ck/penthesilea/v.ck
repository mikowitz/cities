[
  [91800.0, 0.0, 0.0],
  [47000.0, 0.0, 0.06818181818181818],
  [16600.0, 0.06818181818181818, 0.0606060606060606],
  [21000.0, 0.0606060606060606, 0.03409090909090909],
  [15800.0, 0.03409090909090909, 0.07792207792207792],
  [100300.0, 0.07792207792207792, 0.03896103896103896],
  [26800.0, 0.03896103896103896, 0.03636363636363637],
  [3700.0, 0.03636363636363637, 0.022727272727272728],
  [46200.0, 0.022727272727272728, 0.022727272727272728],
  [25800.0, 0.022727272727272728, 0.018181818181818184],
  [78600.0, 0.018181818181818184, 0.06818181818181818],
  [25500.0, 0.06818181818181818, 0.045454545454545456],
  [35300.0, 0.045454545454545456, 0.03636363636363637],
  [65400.0, 0.03636363636363637, 0.06818181818181818],
  [52600.0, 0.06818181818181818, 0.0606060606060606],
  [66400.0, 0.0606060606060606, 0.07272727272727274],
  [1700.0, 0.07272727272727274, 0.06818181818181818],
  [46900.0, 0.06818181818181818, 0.05454545454545454],
  [96100.0, 0.05454545454545454, 0.012987012987012986],
  [6600.0, 0.012987012987012986, 0.05454545454545454],
  [1500.0, 0.05454545454545454, 0.07272727272727274],
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