[
  [23500.0, 0.0, 0.0],
  [11500.0, 0.0, 0.2857142857142857],
  [28000.0, 0.2857142857142857, 0.3],
  [17000.0, 0.3, 0.07142857142857142],
  [13000.0, 0.07142857142857142, 0.1875],
  [21900.0, 0.1875, 0.5],
  [10300.0, 0.5, 0.16666666666666666],
  [19800.0, 0.16666666666666666, 0.3333333333333333],
  [5100.0, 0.3333333333333333, 0.041666666666666664],
  [17000.0, 0.041666666666666664, 0.3],
  [4300.0, 0.3, 0.5],
  [47500.0, 0.5, 0.25],
  [500.0, 0.25, 0.375],
] @=> float fades[][];

Gain g => dac;
0.0 => g.gain;

SinOsc s => Pan2 p => g;
-0.04 => p.pan;
1300.0 => s.freq;

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
