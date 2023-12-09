[
  [16500.0, 0.0, 0.0],
  [14100.0, 0.0, 0.045454545454545456],
  [11100.0, 0.045454545454545456, 0.06818181818181818],
  [58300.0, 0.06818181818181818, 0.011363636363636364],
  [10700.0, 0.011363636363636364, 0.0303030303030303],
  [3800.0, 0.0303030303030303, 0.012987012987012986],
  [6600.0, 0.012987012987012986, 0.018181818181818184],
  [10900.0, 0.018181818181818184, 0.05454545454545454],
  [6000.0, 0.05454545454545454, 0.0606060606060606],
  [42100.0, 0.0606060606060606, 0.06818181818181818],
  [32100.0, 0.06818181818181818, 0.06818181818181818],
  [19000.0, 0.06818181818181818, 0.06818181818181818],
  [9800.0, 0.06818181818181818, 0.045454545454545456],
  [400.0, 0.045454545454545456, 0.0303030303030303],
  [69200.0, 0.0303030303030303, 0.0606060606060606],
  [8400.0, 0.0606060606060606, 0.05454545454545454],
  [25500.0, 0.05454545454545454, 0.045454545454545456],
  [44300.0, 0.045454545454545456, 0.011363636363636364],
  [7000.0, 0.011363636363636364, 0.05454545454545454],
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
