[
  [88600.0, 0.0, 0.0],
  [53700.0, 0.0, 0.06818181818181818],
  [6600.0, 0.06818181818181818, 0.022727272727272728],
  [10600.0, 0.022727272727272728, 0.06818181818181818],
  [33100.0, 0.06818181818181818, 0.09090909090909091],
  [3000.0, 0.09090909090909091, 0.0404040404040404],
  [9400.0, 0.0404040404040404, 0.07575757575757576],
  [3400.0, 0.07575757575757576, 0.0606060606060606],
  [92700.0, 0.0606060606060606, 0.09090909090909091],
  [13700.0, 0.09090909090909091, 0.050505050505050504],
  [28300.0, 0.050505050505050504, 0.06818181818181818],
  [4000.0, 0.06818181818181818, 0.09090909090909091],
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