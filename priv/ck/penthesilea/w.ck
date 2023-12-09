[
  [41000.0, 0.0, 0.0],
  [14800.0, 0.0, 0.008695652173913044],
  [13200.0, 0.008695652173913044, 0.02898550724637681],
  [40700.0, 0.02898550724637681, 0.014492753623188404],
  [7800.0, 0.014492753623188404, 0.031055900621118012],
  [34800.0, 0.031055900621118012, 0.007246376811594202],
  [8600.0, 0.007246376811594202, 0.010869565217391304],
  [11500.0, 0.010869565217391304, 0.043478260869565216],
  [6700.0, 0.043478260869565216, 0.010869565217391304],
  [26800.0, 0.010869565217391304, 0.008695652173913044],
  [24000.0, 0.008695652173913044, 0.006211180124223602],
  [2300.0, 0.006211180124223602, 0.010869565217391304],
  [5500.0, 0.010869565217391304, 0.043478260869565216],
  [57100.0, 0.043478260869565216, 0.014492753623188404],
  [19400.0, 0.014492753623188404, 0.043478260869565216],
  [3500.0, 0.043478260869565216, 0.010869565217391304],
  [7100.0, 0.010869565217391304, 0.043478260869565216],
  [24200.0, 0.043478260869565216, 0.043478260869565216],
  [32000.0, 0.043478260869565216, 0.010869565217391304],
  [4200.0, 0.010869565217391304, 0.004830917874396135],
  [10300.0, 0.004830917874396135, 0.004347826086956522],
  [5700.0, 0.004347826086956522, 0.010869565217391304],
  [7400.0, 0.010869565217391304, 0.008695652173913044],
  [5600.0, 0.008695652173913044, 0.03260869565217391],
  [2600.0, 0.03260869565217391, 0.031055900621118012],
  [22300.0, 0.031055900621118012, 0.008695652173913044],
  [14600.0, 0.008695652173913044, 0.008695652173913044],
  [42400.0, 0.008695652173913044, 0.008695652173913044],
  [9500.0, 0.008695652173913044, 0.021739130434782608],
  [4600.0, 0.021739130434782608, 0.010869565217391304],
  [1700.0, 0.010869565217391304, 0.024844720496894408],
  [5100.0, 0.024844720496894408, 0.008695652173913044],
  [13200.0, 0.008695652173913044, 0.021739130434782608],
  [11300.0, 0.021739130434782608, 0.008695652173913044],
  [15600.0, 0.008695652173913044, 0.014492753623188404],
  [19300.0, 0.014492753623188404, 0.021739130434782608],
  [27600.0, 0.021739130434782608, 0.008695652173913044],
  [93300.0, 0.008695652173913044, 0.006211180124223602],
  [2100.0, 0.006211180124223602, 0.006211180124223602],
  [32200.0, 0.006211180124223602, 0.037267080745341616],
  [9900.0, 0.037267080745341616, 0.006211180124223602],
  [40700.0, 0.006211180124223602, 0.006211180124223602],
  [23800.0, 0.006211180124223602, 0.006211180124223602],
  [5100.0, 0.006211180124223602, 0.043478260869565216],
  [30500.0, 0.043478260869565216, 0.043478260869565216],
  [8000.0, 0.043478260869565216, 0.043478260869565216],
  [22000.0, 0.043478260869565216, 0.010869565217391304],
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
