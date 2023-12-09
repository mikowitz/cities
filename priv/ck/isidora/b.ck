[
  [40400.0, 0.0, 0.0],
  [49900.0, 0.0, 0.05555555555555555],
  [24500.0, 0.05555555555555555, 0.07142857142857142],
  [1100.0, 0.07142857142857142, 0.08333333333333333],
  [5300.0, 0.08333333333333333, 0.08333333333333333],
  [95700.0, 0.08333333333333333, 0.07142857142857142],
  [20200.0, 0.07142857142857142, 0.25],
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
