[
  [22400.0, 0.0, 0.0],
  [7700.0, 0.0, 0.02898550724637681],
  [24700.0, 0.02898550724637681, 0.021739130434782608],
  [27100.0, 0.021739130434782608, 0.043478260869565216],
  [102800.0, 0.043478260869565216, 0.010869565217391304],
  [1300.0, 0.010869565217391304, 0.010869565217391304],
  [9100.0, 0.010869565217391304, 0.014492753623188404],
  [7200.0, 0.014492753623188404, 0.010869565217391304],
  [75800.0, 0.010869565217391304, 0.043478260869565216],
  [10900.0, 0.043478260869565216, 0.006211180124223602],
  [39600.0, 0.006211180124223602, 0.008695652173913044],
  [6300.0, 0.008695652173913044, 0.010869565217391304],
  [18500.0, 0.010869565217391304, 0.006211180124223602],
  [15500.0, 0.006211180124223602, 0.007246376811594202],
  [6100.0, 0.007246376811594202, 0.010869565217391304],
  [20200.0, 0.010869565217391304, 0.043478260869565216],
  [18500.0, 0.043478260869565216, 0.006211180124223602],
  [59500.0, 0.006211180124223602, 0.008695652173913044],
  [4100.0, 0.008695652173913044, 0.008695652173913044],
  [26500.0, 0.008695652173913044, 0.010869565217391304],
  [37500.0, 0.010869565217391304, 0.008695652173913044],
  [4100.0, 0.008695652173913044, 0.008695652173913044],
  [1700.0, 0.008695652173913044, 0.034782608695652174],
  [21500.0, 0.034782608695652174, 0.010869565217391304],
  [8800.0, 0.010869565217391304, 0.034782608695652174],
  [800.0, 0.034782608695652174, 0.014492753623188404],
  [5500.0, 0.014492753623188404, 0.008695652173913044],
  [31700.0, 0.008695652173913044, 0.02898550724637681],
  [8200.0, 0.02898550724637681, 0.008695652173913044],
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
