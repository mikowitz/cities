[
  [7300.0, 0.0, 0.0],
  [17000.0, 0.0, 0.008695652173913044],
  [13900.0, 0.008695652173913044, 0.004830917874396135],
  [3700.0, 0.004830917874396135, 0.006211180124223602],
  [2500.0, 0.006211180124223602, 0.010869565217391304],
  [4000.0, 0.010869565217391304, 0.043478260869565216],
  [200.0, 0.043478260869565216, 0.043478260869565216],
  [2100.0, 0.043478260869565216, 0.007246376811594202],
  [16600.0, 0.007246376811594202, 0.043478260869565216],
  [28300.0, 0.043478260869565216, 0.010869565217391304],
  [23800.0, 0.010869565217391304, 0.010869565217391304],
  [40700.0, 0.010869565217391304, 0.004347826086956522],
  [12900.0, 0.004347826086956522, 0.014492753623188404],
  [5100.0, 0.014492753623188404, 0.02608695652173913],
  [42700.0, 0.02608695652173913, 0.02898550724637681],
  [13300.0, 0.02898550724637681, 0.008695652173913044],
  [1500.0, 0.008695652173913044, 0.010869565217391304],
  [7300.0, 0.010869565217391304, 0.021739130434782608],
  [9800.0, 0.021739130434782608, 0.03260869565217391],
  [33600.0, 0.03260869565217391, 0.021739130434782608],
  [4200.0, 0.021739130434782608, 0.021739130434782608],
  [12900.0, 0.021739130434782608, 0.006211180124223602],
  [3500.0, 0.006211180124223602, 0.010869565217391304],
  [16700.0, 0.010869565217391304, 0.043478260869565216],
  [1000.0, 0.043478260869565216, 0.008695652173913044],
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