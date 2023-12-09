[
  [35800.0, 0.0, 0.0],
  [36600.0, 0.0, 0.08333333333333333],
  [6800.0, 0.08333333333333333, 0.0625],
  [21600.0, 0.0625, 0.25],
  [24800.0, 0.25, 0.16666666666666666],
  [62800.0, 0.16666666666666666, 0.3888888888888889],
  [5000.0, 0.3888888888888889, 0.07142857142857142],
  [26000.0, 0.07142857142857142, 0.08333333333333333],
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
