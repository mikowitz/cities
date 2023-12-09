[
  [0.0, 0.0, 0.0],
  [37900.0, 0.0, 0.010869565217391304],
  [26000.0, 0.010869565217391304, 0.010869565217391304],
  [28800.0, 0.010869565217391304, 0.03260869565217391],
  [3800.0, 0.03260869565217391, 0.010869565217391304],
  [2800.0, 0.010869565217391304, 0.021739130434782608],
  [14100.0, 0.021739130434782608, 0.043478260869565216],
  [5300.0, 0.043478260869565216, 0.005434782608695652],
  [10100.0, 0.005434782608695652, 0.010869565217391304],
  [4400.0, 0.010869565217391304, 0.008695652173913044],
  [38000.0, 0.008695652173913044, 0.017391304347826087],
  [22900.0, 0.017391304347826087, 0.02898550724637681],
  [1600.0, 0.02898550724637681, 0.03260869565217391],
  [3500.0, 0.03260869565217391, 0.043478260869565216],
  [37800.0, 0.043478260869565216, 0.021739130434782608],
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