[
  [19400.0, 0.0, 0.0],
  [20200.0, 0.0, 0.14285714285714285],
  [33400.0, 0.14285714285714285, 0.10204081632653061],
  [28100.0, 0.10204081632653061, 0.07142857142857142],
  [4600.0, 0.07142857142857142, 0.09523809523809523],
  [39700.0, 0.09523809523809523, 0.04081632653061224],
  [74000.0, 0.04081632653061224, 0.023809523809523808],
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
