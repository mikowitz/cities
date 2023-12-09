[
  [6900.0, 0.0, 0.0],
  [19400.0, 0.0, 0.14285714285714285],
  [8300.0, 0.14285714285714285, 0.14285714285714285],
  [6000.0, 0.14285714285714285, 0.10204081632653061],
  [26400.0, 0.10204081632653061, 0.14285714285714285],
  [18800.0, 0.14285714285714285, 0.12244897959183673],
  [12800.0, 0.12244897959183673, 0.017857142857142856],
  [3800.0, 0.017857142857142856, 0.14285714285714285],
  [3900.0, 0.14285714285714285, 0.08571428571428572],
  [24000.0, 0.08571428571428572, 0.14285714285714285],
  [2400.0, 0.14285714285714285, 0.028571428571428574],
  [2200.0, 0.028571428571428574, 0.10714285714285714],
  [6800.0, 0.10714285714285714, 0.08571428571428572],
  [31100.0, 0.08571428571428572, 0.10204081632653061],
  [12000.0, 0.10204081632653061, 0.09523809523809523],
  [27500.0, 0.09523809523809523, 0.09523809523809523],
  [3500.0, 0.09523809523809523, 0.14285714285714285],
  [3100.0, 0.14285714285714285, 0.12244897959183673],
  [7100.0, 0.12244897959183673, 0.02040816326530612],
  [26000.0, 0.02040816326530612, 0.14285714285714285],
  [48400.0, 0.14285714285714285, 0.09523809523809523],
  [16800.0, 0.09523809523809523, 0.08571428571428572],
  [1000.0, 0.08571428571428572, 0.10204081632653061],
] @=> float fades[][];

Gain g => dac;
0.0 => g.gain;

SinOsc s => Pan2 p => g;
-0.48 => p.pan;
700.0 => s.freq;

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