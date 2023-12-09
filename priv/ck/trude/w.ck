[
  [19700.0, 0.0, 0.0],
  [10700.0, 0.0, 0.006211180124223602],
  [6600.0, 0.006211180124223602, 0.008695652173913044],
  [12700.0, 0.008695652173913044, 0.014492753623188404],
  [18400.0, 0.014492753623188404, 0.008695652173913044],
  [11500.0, 0.008695652173913044, 0.010869565217391304],
  [12400.0, 0.010869565217391304, 0.010869565217391304],
  [4800.0, 0.010869565217391304, 0.02898550724637681],
  [7200.0, 0.02898550724637681, 0.02898550724637681],
  [600.0, 0.02898550724637681, 0.021739130434782608],
  [7900.0, 0.021739130434782608, 0.017391304347826087],
  [10200.0, 0.017391304347826087, 0.02898550724637681],
  [1400.0, 0.02898550724637681, 0.016304347826086956],
  [21800.0, 0.016304347826086956, 0.03804347826086957],
  [17700.0, 0.03804347826086957, 0.014492753623188404],
  [2500.0, 0.014492753623188404, 0.043478260869565216],
  [20500.0, 0.043478260869565216, 0.008695652173913044],
  [11500.0, 0.008695652173913044, 0.010869565217391304],
  [25700.0, 0.010869565217391304, 0.02717391304347826],
  [4400.0, 0.02717391304347826, 0.012422360248447204],
  [12300.0, 0.012422360248447204, 0.014492753623188404],
  [13000.0, 0.014492753623188404, 0.007246376811594202],
  [11800.0, 0.007246376811594202, 0.005434782608695652],
  [21600.0, 0.005434782608695652, 0.010869565217391304],
  [8900.0, 0.010869565217391304, 0.008695652173913044],
  [22400.0, 0.008695652173913044, 0.008695652173913044],
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