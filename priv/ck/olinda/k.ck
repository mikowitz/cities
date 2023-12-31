[
  [48900.0, 0.0, 0.0],
  [24800.0, 0.0, 0.09090909090909091],
  [21400.0, 0.09090909090909091, 0.0202020202020202],
  [1500.0, 0.0202020202020202, 0.01515151515151515],
  [14800.0, 0.01515151515151515, 0.07575757575757576],
  [116500.0, 0.07575757575757576, 0.09090909090909091],
  [5000.0, 0.09090909090909091, 0.06818181818181818],
  [80500.0, 0.06818181818181818, 0.07575757575757576],
  [94300.0, 0.07575757575757576, 0.06818181818181818],
  [137900.0, 0.06818181818181818, 0.06818181818181818],
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
