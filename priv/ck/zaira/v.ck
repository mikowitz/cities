[
  [1600.0, 0.0, 0.0],
  [61500.0, 0.0, 0.022727272727272728],
  [8800.0, 0.022727272727272728, 0.0606060606060606],
  [55200.0, 0.0606060606060606, 0.05454545454545454],
  [99600.0, 0.05454545454545454, 0.0303030303030303],
  [154300.0, 0.0303030303030303, 0.045454545454545456],
  [47000.0, 0.045454545454545456, 0.06818181818181818],
  [69100.0, 0.06818181818181818, 0.06493506493506494],
  [24200.0, 0.06493506493506494, 0.03636363636363637],
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
