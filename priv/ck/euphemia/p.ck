[
  [0.0, 0.0, 0.0],
  [24900.0, 0.0, 0.05],
  [57800.0, 0.05, 0.1875],
  [7100.0, 0.1875, 0.05555555555555555],
  [400.0, 0.05555555555555555, 0.1],
  [300.0, 0.1, 0.3],
  [63800.0, 0.3, 0.4],
  [52000.0, 0.4, 0.5],
  [23900.0, 0.5, 0.25],
  [25400.0, 0.25, 0.05],
  [7700.0, 0.05, 0.08333333333333333],
  [40900.0, 0.08333333333333333, 0.1875],
  [3600.0, 0.1875, 0.1],
  [70800.0, 0.1, 0.2857142857142857],
  [27600.0, 0.2857142857142857, 0.5],
  [48800.0, 0.5, 0.5],
  [23800.0, 0.5, 0.1875],
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
