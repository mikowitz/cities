[
  [11300.0, 0.0, 0.0],
  [29400.0, 0.0, 0.10204081632653061],
  [14600.0, 0.10204081632653061, 0.031746031746031744],
  [41500.0, 0.031746031746031744, 0.07936507936507937],
  [79800.0, 0.07936507936507937, 0.07142857142857142],
  [19900.0, 0.07142857142857142, 0.08571428571428572],
  [17600.0, 0.08571428571428572, 0.07142857142857142],
  [23000.0, 0.07142857142857142, 0.08571428571428572],
] @=> float fades[][];

Gain g => dac;
0.0 => g.gain;

SinOsc s => Pan2 p => g;
0.56 => p.pan;
2100.0 => s.freq;

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
