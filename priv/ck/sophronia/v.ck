[
  [171300.0, 0.0, 0.0],
  [24600.0, 0.0, 0.045454545454545456],
  [10600.0, 0.045454545454545456, 0.01515151515151515],
  [12800.0, 0.01515151515151515, 0.03636363636363637],
  [139200.0, 0.03636363636363637, 0.07575757575757576],
  [16300.0, 0.07575757575757576, 0.06493506493506494],
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
