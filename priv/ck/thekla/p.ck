[
  [17300.0, 0.0, 0.0],
  [32800.0, 0.0, 0.1],
  [3000.0, 0.1, 0.3],
  [300.0, 0.3, 0.16666666666666666],
  [68000.0, 0.16666666666666666, 0.2222222222222222],
  [52700.0, 0.2222222222222222, 0.5],
  [10100.0, 0.5, 0.08333333333333333],
  [20300.0, 0.08333333333333333, 0.35714285714285715],
  [14400.0, 0.35714285714285715, 0.125],
  [4500.0, 0.125, 0.07142857142857142],
  [22200.0, 0.07142857142857142, 0.5],
  [1500.0, 0.5, 0.125],
  [1100.0, 0.125, 0.5],
  [47000.0, 0.5, 0.5],
  [9500.0, 0.5, 0.125],
  [27100.0, 0.125, 0.2777777777777778],
  [11500.0, 0.2777777777777778, 0.4444444444444444],
  [31500.0, 0.4444444444444444, 0.4],
  [5300.0, 0.4, 0.2777777777777778],
] @=> float fades[][];

Gain g => dac;
0.0 => g.gain;

SinOsc s => Pan2 p => g;
0.19 => p.pan;
1600.0 => s.freq;

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