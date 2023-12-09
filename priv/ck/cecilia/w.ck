[
  [25700.0, 0.0, 0.0],
  [16700.0, 0.0, 0.006211180124223602],
  [8000.0, 0.006211180124223602, 0.024844720496894408],
  [18500.0, 0.024844720496894408, 0.006211180124223602],
  [2300.0, 0.006211180124223602, 0.014492753623188404],
  [2700.0, 0.014492753623188404, 0.010869565217391304],
  [2500.0, 0.010869565217391304, 0.02898550724637681],
  [40500.0, 0.02898550724637681, 0.010869565217391304],
  [22400.0, 0.010869565217391304, 0.008695652173913044],
  [2300.0, 0.008695652173913044, 0.008695652173913044],
  [12300.0, 0.008695652173913044, 0.021739130434782608],
  [21800.0, 0.021739130434782608, 0.043478260869565216],
  [6500.0, 0.043478260869565216, 0.010869565217391304],
  [3400.0, 0.010869565217391304, 0.021739130434782608],
  [26200.0, 0.021739130434782608, 0.004830917874396135],
  [25400.0, 0.004830917874396135, 0.021739130434782608],
  [4200.0, 0.021739130434782608, 0.043478260869565216],
  [1000.0, 0.043478260869565216, 0.043478260869565216],
  [11000.0, 0.043478260869565216, 0.024844720496894408],
  [14700.0, 0.024844720496894408, 0.03260869565217391],
  [19200.0, 0.03260869565217391, 0.006211180124223602],
  [61800.0, 0.006211180124223602, 0.008695652173913044],
  [30800.0, 0.008695652173913044, 0.010869565217391304],
  [23400.0, 0.010869565217391304, 0.010869565217391304],
  [19000.0, 0.010869565217391304, 0.034782608695652174],
  [700.0, 0.034782608695652174, 0.014492753623188404],
  [6200.0, 0.014492753623188404, 0.006211180124223602],
  [7600.0, 0.006211180124223602, 0.03260869565217391],
  [19700.0, 0.03260869565217391, 0.014492753623188404],
  [2000.0, 0.014492753623188404, 0.008695652173913044],
  [6000.0, 0.008695652173913044, 0.021739130434782608],
  [5000.0, 0.021739130434782608, 0.008695652173913044],
  [1700.0, 0.008695652173913044, 0.021739130434782608],
  [2400.0, 0.021739130434782608, 0.021739130434782608],
  [21500.0, 0.021739130434782608, 0.004830917874396135],
  [6600.0, 0.004830917874396135, 0.021739130434782608],
  [14400.0, 0.021739130434782608, 0.014492753623188404],
  [5300.0, 0.014492753623188404, 0.008695652173913044],
  [10600.0, 0.008695652173913044, 0.014492753623188404],
  [1500.0, 0.014492753623188404, 0.014492753623188404],
  [1500.0, 0.014492753623188404, 0.03260869565217391],
  [3900.0, 0.03260869565217391, 0.043478260869565216],
  [9500.0, 0.043478260869565216, 0.008695652173913044],
  [13300.0, 0.008695652173913044, 0.010869565217391304],
  [32600.0, 0.010869565217391304, 0.004347826086956522],
  [24000.0, 0.004347826086956522, 0.010869565217391304],
  [8400.0, 0.010869565217391304, 0.043478260869565216],
  [3800.0, 0.043478260869565216, 0.008695652173913044],
  [2400.0, 0.008695652173913044, 0.010869565217391304],
  [10300.0, 0.010869565217391304, 0.014492753623188404],
  [29700.0, 0.014492753623188404, 0.021739130434782608],
  [17000.0, 0.021739130434782608, 0.02608695652173913],
  [1800.0, 0.02608695652173913, 0.043478260869565216],
  [18600.0, 0.043478260869565216, 0.043478260869565216],
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