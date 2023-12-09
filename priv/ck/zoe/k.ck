[
  [12300.0, 0.0, 0.0],
  [25000.0, 0.0, 0.022727272727272728],
  [4400.0, 0.022727272727272728, 0.06818181818181818],
  [56900.0, 0.06818181818181818, 0.07954545454545454],
  [171200.0, 0.07954545454545454, 0.03896103896103896],
  [1800.0, 0.03896103896103896, 0.06818181818181818],
  [85900.0, 0.06818181818181818, 0.09090909090909091],
  [83400.0, 0.09090909090909091, 0.018181818181818184],
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
