[
  [113300.0, 0.0, 0.0],
  [2100.0, 0.0, 0.006211180124223602],
  [34800.0, 0.006211180124223602, 0.037267080745341616],
  [12500.0, 0.037267080745341616, 0.014492753623188404],
  [13500.0, 0.014492753623188404, 0.02898550724637681],
  [14600.0, 0.02898550724637681, 0.008695652173913044],
  [1800.0, 0.008695652173913044, 0.014492753623188404],
  [3900.0, 0.014492753623188404, 0.034782608695652174],
  [21000.0, 0.034782608695652174, 0.043478260869565216],
  [18200.0, 0.043478260869565216, 0.006211180124223602],
  [7100.0, 0.006211180124223602, 0.008695652173913044],
  [8400.0, 0.008695652173913044, 0.037267080745341616],
  [9800.0, 0.037267080745341616, 0.014492753623188404],
  [14500.0, 0.014492753623188404, 0.010869565217391304],
  [46300.0, 0.010869565217391304, 0.02608695652173913],
  [25200.0, 0.02608695652173913, 0.008695652173913044],
  [11700.0, 0.008695652173913044, 0.008695652173913044],
  [44400.0, 0.008695652173913044, 0.008695652173913044],
  [43600.0, 0.008695652173913044, 0.024844720496894408],
  [9900.0, 0.024844720496894408, 0.007246376811594202],
  [31400.0, 0.007246376811594202, 0.014492753623188404],
  [42300.0, 0.014492753623188404, 0.021739130434782608],
] @=> float fades[][];

Gain g => dac;
0.0 => g.gain;

SinOsc s => Pan2 p => g;
0.7 => p.pan;
2300.0 => s.freq;

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