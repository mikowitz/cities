[
  [8300.0, 0.0, 0.0],
  [45000.0, 0.0, 0.35],
  [62100.0, 0.35, 0.22727272727272727],
  [11700.0, 0.22727272727272727, 0.07142857142857142],
  [44000.0, 0.07142857142857142, 0.25],
  [11100.0, 0.25, 0.0625],
  [28600.0, 0.0625, 0.4],
  [115900.0, 0.4, 0.2],
  [11500.0, 0.2, 0.07142857142857142],
  [48700.0, 0.07142857142857142, 0.08333333333333333],
  [17200.0, 0.08333333333333333, 0.16666666666666666],
  [13500.0, 0.16666666666666666, 0.08333333333333333],
] @=> float fades[][];

Gain g => dac;
0.0 => g.gain;

SinOsc s => Pan2 p => g;
-0.85 => p.pan;
200.0 => s.freq;

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
