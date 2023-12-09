[
  [50100.0, 0.0, 0.0],
  [35600.0, 0.0, 0.09090909090909091],
  [8000.0, 0.09090909090909091, 0.022727272727272728],
  [104100.0, 0.022727272727272728, 0.012987012987012986],
  [25700.0, 0.012987012987012986, 0.09090909090909091],
  [181500.0, 0.09090909090909091, 0.011363636363636364],
  [43300.0, 0.011363636363636364, 0.06818181818181818],
  [55000.0, 0.06818181818181818, 0.07575757575757576],
  [161400.0, 0.07575757575757576, 0.06818181818181818],
  [155500.0, 0.06818181818181818, 0.09090909090909091],
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
