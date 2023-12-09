[
  [53300.0, 0.0, 0.0],
  [5600.0, 0.0, 0.09090909090909091],
  [13900.0, 0.09090909090909091, 0.03496503496503497],
  [101400.0, 0.03496503496503497, 0.09090909090909091],
  [73800.0, 0.09090909090909091, 0.09090909090909091],
  [29000.0, 0.09090909090909091, 0.06818181818181818],
  [92200.0, 0.06818181818181818, 0.06818181818181818],
  [4400.0, 0.06818181818181818, 0.051948051948051945],
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
