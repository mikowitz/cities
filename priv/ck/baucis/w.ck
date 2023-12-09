[
  [10800.0, 0.0, 0.0],
  [9900.0, 0.0, 0.005434782608695652],
  [63600.0, 0.005434782608695652, 0.021739130434782608],
  [19900.0, 0.021739130434782608, 0.010869565217391304],
  [25100.0, 0.010869565217391304, 0.043478260869565216],
  [23100.0, 0.043478260869565216, 0.03260869565217391],
  [6900.0, 0.03260869565217391, 0.008695652173913044],
  [15700.0, 0.008695652173913044, 0.010869565217391304],
  [54600.0, 0.010869565217391304, 0.043478260869565216],
  [7100.0, 0.043478260869565216, 0.014492753623188404],
  [10100.0, 0.014492753623188404, 0.010869565217391304],
  [900.0, 0.010869565217391304, 0.016304347826086956],
  [27700.0, 0.016304347826086956, 0.02717391304347826],
  [9900.0, 0.02717391304347826, 0.010869565217391304],
  [2800.0, 0.010869565217391304, 0.02898550724637681],
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
