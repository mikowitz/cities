[
  [53500.0, 0.0, 0.0],
  [17500.0, 0.0, 0.03636363636363637],
  [300.0, 0.03636363636363637, 0.07954545454545454],
  [37400.0, 0.07954545454545454, 0.045454545454545456],
  [18500.0, 0.045454545454545456, 0.06818181818181818],
  [20300.0, 0.06818181818181818, 0.045454545454545456],
  [6200.0, 0.045454545454545456, 0.06818181818181818],
  [49700.0, 0.06818181818181818, 0.022727272727272728],
  [33600.0, 0.022727272727272728, 0.07792207792207792],
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
