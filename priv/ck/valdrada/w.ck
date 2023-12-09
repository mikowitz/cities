[
  [14900.0, 0.0, 0.0],
  [18800.0, 0.0, 0.010869565217391304],
  [11100.0, 0.010869565217391304, 0.008695652173913044],
  [15100.0, 0.008695652173913044, 0.008695652173913044],
  [18200.0, 0.008695652173913044, 0.02898550724637681],
  [32400.0, 0.02898550724637681, 0.03260869565217391],
  [12700.0, 0.03260869565217391, 0.014492753623188404],
  [17200.0, 0.014492753623188404, 0.008695652173913044],
  [3500.0, 0.008695652173913044, 0.03260869565217391],
  [39200.0, 0.03260869565217391, 0.008695652173913044],
  [23900.0, 0.008695652173913044, 0.010869565217391304],
  [12800.0, 0.010869565217391304, 0.004830917874396135],
  [25300.0, 0.004830917874396135, 0.043478260869565216],
  [17700.0, 0.043478260869565216, 0.008695652173913044],
  [30600.0, 0.008695652173913044, 0.00966183574879227],
  [3800.0, 0.00966183574879227, 0.010869565217391304],
  [24700.0, 0.010869565217391304, 0.017391304347826087],
  [15200.0, 0.017391304347826087, 0.010869565217391304],
  [43100.0, 0.010869565217391304, 0.010869565217391304],
  [107000.0, 0.010869565217391304, 0.024844720496894408],
  [7900.0, 0.024844720496894408, 0.010869565217391304],
  [41100.0, 0.010869565217391304, 0.021739130434782608],
  [25400.0, 0.021739130434782608, 0.021739130434782608],
  [23800.0, 0.021739130434782608, 0.02898550724637681],
  [2500.0, 0.02898550724637681, 0.024844720496894408],
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
