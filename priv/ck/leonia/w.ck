[
  [22100.0, 0.0, 0.0],
  [1500.0, 0.0, 0.010869565217391304],
  [5000.0, 0.010869565217391304, 0.024844720496894408],
  [1200.0, 0.024844720496894408, 0.010869565217391304],
  [5400.0, 0.010869565217391304, 0.010869565217391304],
  [4600.0, 0.010869565217391304, 0.023411371237458192],
  [4900.0, 0.023411371237458192, 0.010869565217391304],
  [50600.0, 0.010869565217391304, 0.043478260869565216],
  [20900.0, 0.043478260869565216, 0.024154589371980676],
  [18800.0, 0.024154589371980676, 0.017391304347826087],
  [7500.0, 0.017391304347826087, 0.021739130434782608],
  [7500.0, 0.021739130434782608, 0.013043478260869565],
  [79000.0, 0.013043478260869565, 0.004830917874396135],
  [8500.0, 0.004830917874396135, 0.036231884057971016],
  [4800.0, 0.036231884057971016, 0.043478260869565216],
  [22000.0, 0.043478260869565216, 0.007246376811594202],
  [52800.0, 0.007246376811594202, 0.043478260869565216],
  [68600.0, 0.043478260869565216, 0.005434782608695652],
  [15100.0, 0.005434782608695652, 0.010869565217391304],
  [2700.0, 0.010869565217391304, 0.006211180124223602],
  [50900.0, 0.006211180124223602, 0.008695652173913044],
  [23600.0, 0.008695652173913044, 0.043478260869565216],
  [21600.0, 0.043478260869565216, 0.008695652173913044],
  [131200.0, 0.008695652173913044, 0.043478260869565216],
  [24000.0, 0.043478260869565216, 0.031055900621118012],
  [8100.0, 0.031055900621118012, 0.00966183574879227],
  [30700.0, 0.00966183574879227, 0.00966183574879227],
  [4700.0, 0.00966183574879227, 0.008695652173913044],
  [33400.0, 0.008695652173913044, 0.008695652173913044],
  [30000.0, 0.008695652173913044, 0.010869565217391304],
  [1100.0, 0.010869565217391304, 0.008695652173913044],
  [50000.0, 0.008695652173913044, 0.008695652173913044],
  [16800.0, 0.008695652173913044, 0.024844720496894408],
  [31300.0, 0.024844720496894408, 0.008695652173913044],
  [23300.0, 0.008695652173913044, 0.034782608695652174],
  [7800.0, 0.034782608695652174, 0.010869565217391304],
  [12000.0, 0.010869565217391304, 0.021739130434782608],
  [18400.0, 0.021739130434782608, 0.010869565217391304],
  [4000.0, 0.010869565217391304, 0.005434782608695652],
  [13500.0, 0.005434782608695652, 0.024844720496894408],
  [2100.0, 0.024844720496894408, 0.02898550724637681],
  [18500.0, 0.02898550724637681, 0.008695652173913044],
  [21300.0, 0.008695652173913044, 0.010869565217391304],
  [27400.0, 0.010869565217391304, 0.010869565217391304],
  [5600.0, 0.010869565217391304, 0.021739130434782608],
  [15000.0, 0.021739130434782608, 0.043478260869565216],
  [3900.0, 0.043478260869565216, 0.006211180124223602],
  [20000.0, 0.006211180124223602, 0.010869565217391304],
  [12600.0, 0.010869565217391304, 0.043478260869565216],
  [12400.0, 0.043478260869565216, 0.043478260869565216],
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