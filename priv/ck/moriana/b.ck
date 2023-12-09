[
  [27600.0, 0.0, 0.0],
  [11800.0, 0.0, 0.08333333333333333],
  [74100.0, 0.08333333333333333, 0.2222222222222222],
  [39700.0, 0.2222222222222222, 0.07142857142857142],
  [42900.0, 0.07142857142857142, 0.14285714285714285],
  [11400.0, 0.14285714285714285, 0.05555555555555555],
  [8400.0, 0.05555555555555555, 0.1],
  [38100.0, 0.1, 0.1],
  [37700.0, 0.1, 0.125],
  [20000.0, 0.125, 0.16666666666666666],
  [25800.0, 0.16666666666666666, 0.14285714285714285],
  [9600.0, 0.14285714285714285, 0.25],
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
