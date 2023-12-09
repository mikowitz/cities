[
  [74900.0, 0.0, 0.0],
  [300.0, 0.0, 0.21428571428571427],
  [44700.0, 0.21428571428571427, 0.2857142857142857],
  [3700.0, 0.2857142857142857, 0.5],
  [19800.0, 0.5, 0.08333333333333333],
  [23600.0, 0.08333333333333333, 0.4166666666666667],
  [21400.0, 0.4166666666666667, 0.07142857142857142],
  [24800.0, 0.07142857142857142, 0.15],
  [25800.0, 0.15, 0.2857142857142857],
  [5000.0, 0.2857142857142857, 0.1],
  [28100.0, 0.1, 0.4],
  [16000.0, 0.4, 0.2692307692307692],
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
