[
  [54400.0, 0.0, 0.0],
  [77900.0, 0.0, 0.05454545454545454],
  [30300.0, 0.05454545454545454, 0.045454545454545456],
  [19000.0, 0.045454545454545456, 0.022727272727272728],
  [28900.0, 0.022727272727272728, 0.0606060606060606],
  [23900.0, 0.0606060606060606, 0.051948051948051945],
  [24200.0, 0.051948051948051945, 0.05454545454545454],
  [59600.0, 0.05454545454545454, 0.06818181818181818],
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
