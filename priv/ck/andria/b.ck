[
  [4000.0, 0.0, 0.0],
  [18300.0, 0.0, 0.1],
  [3700.0, 0.1, 0.3],
  [68600.0, 0.3, 0.05555555555555555],
  [86500.0, 0.05555555555555555, 0.375],
  [12400.0, 0.375, 0.08333333333333333],
  [8600.0, 0.08333333333333333, 0.3076923076923077],
  [105300.0, 0.3076923076923077, 0.21428571428571427],
  [16900.0, 0.21428571428571427, 0.25],
  [20000.0, 0.25, 0.125],
  [2600.0, 0.125, 0.18181818181818182],
  [29400.0, 0.18181818181818182, 0.16666666666666666],
  [900.0, 0.16666666666666666, 0.08333333333333333],
  [42100.0, 0.08333333333333333, 0.3333333333333333],
  [36600.0, 0.3333333333333333, 0.1111111111111111],
  [17000.0, 0.1111111111111111, 0.1875],
  [115400.0, 0.1875, 0.5],
  [2500.0, 0.5, 0.25],
  [61800.0, 0.25, 0.07142857142857142],
  [50400.0, 0.07142857142857142, 0.22727272727272727],
  [36300.0, 0.22727272727272727, 0.08333333333333333],
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
