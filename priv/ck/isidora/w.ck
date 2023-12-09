[
  [0.0, 0.0, 0.0],
  [13200.0, 0.0, 0.010869565217391304],
  [24200.0, 0.010869565217391304, 0.010869565217391304],
  [19700.0, 0.010869565217391304, 0.008695652173913044],
  [7200.0, 0.008695652173913044, 0.010869565217391304],
  [13100.0, 0.010869565217391304, 0.008695652173913044],
  [13700.0, 0.008695652173913044, 0.008695652173913044],
  [1500.0, 0.008695652173913044, 0.024844720496894408],
  [300.0, 0.024844720496894408, 0.02898550724637681],
  [1900.0, 0.02898550724637681, 0.008695652173913044],
  [8700.0, 0.008695652173913044, 0.021739130434782608],
  [14000.0, 0.021739130434782608, 0.008695652173913044],
  [7000.0, 0.008695652173913044, 0.02898550724637681],
  [11300.0, 0.02898550724637681, 0.014492753623188404],
  [22500.0, 0.014492753623188404, 0.010869565217391304],
  [44800.0, 0.010869565217391304, 0.010869565217391304],
  [800.0, 0.010869565217391304, 0.010869565217391304],
  [7400.0, 0.010869565217391304, 0.008695652173913044],
  [12200.0, 0.008695652173913044, 0.008695652173913044],
  [200.0, 0.008695652173913044, 0.043478260869565216],
  [13400.0, 0.043478260869565216, 0.010869565217391304],
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