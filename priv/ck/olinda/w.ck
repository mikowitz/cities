[
  [8100.0, 0.0, 0.0],
  [20700.0, 0.0, 0.010869565217391304],
  [15200.0, 0.010869565217391304, 0.024154589371980676],
  [15600.0, 0.024154589371980676, 0.008695652173913044],
  [68300.0, 0.008695652173913044, 0.007246376811594202],
  [35900.0, 0.007246376811594202, 0.010869565217391304],
  [11000.0, 0.010869565217391304, 0.007246376811594202],
  [7000.0, 0.007246376811594202, 0.043478260869565216],
  [13900.0, 0.043478260869565216, 0.014492753623188404],
  [21400.0, 0.014492753623188404, 0.021739130434782608],
  [16300.0, 0.021739130434782608, 0.034782608695652174],
  [34400.0, 0.034782608695652174, 0.008695652173913044],
  [4600.0, 0.008695652173913044, 0.043478260869565216],
  [2900.0, 0.043478260869565216, 0.008695652173913044],
  [3300.0, 0.008695652173913044, 0.008695652173913044],
  [10400.0, 0.008695652173913044, 0.005434782608695652],
  [8400.0, 0.005434782608695652, 0.021739130434782608],
  [3700.0, 0.021739130434782608, 0.008695652173913044],
  [6300.0, 0.008695652173913044, 0.043478260869565216],
  [14300.0, 0.043478260869565216, 0.036231884057971016],
  [12400.0, 0.036231884057971016, 0.008695652173913044],
  [47900.0, 0.008695652173913044, 0.010869565217391304],
  [5600.0, 0.010869565217391304, 0.02608695652173913],
  [4900.0, 0.02608695652173913, 0.008695652173913044],
  [49000.0, 0.008695652173913044, 0.043478260869565216],
  [2500.0, 0.043478260869565216, 0.043478260869565216],
  [23300.0, 0.043478260869565216, 0.008695652173913044],
  [25600.0, 0.008695652173913044, 0.043478260869565216],
  [45900.0, 0.043478260869565216, 0.007246376811594202],
  [3300.0, 0.007246376811594202, 0.010869565217391304],
  [3500.0, 0.010869565217391304, 0.043478260869565216],
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
