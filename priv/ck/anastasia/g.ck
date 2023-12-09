[
  [8200.0, 0.0, 0.0],
  [25500.0, 0.0, 0.14285714285714285],
  [7100.0, 0.14285714285714285, 0.14285714285714285],
  [20100.0, 0.14285714285714285, 0.14285714285714285],
  [3500.0, 0.14285714285714285, 0.09523809523809523],
  [26700.0, 0.09523809523809523, 0.05714285714285715],
  [42200.0, 0.05714285714285715, 0.023809523809523808],
  [4400.0, 0.023809523809523808, 0.14285714285714285],
  [20300.0, 0.14285714285714285, 0.023809523809523808],
  [29800.0, 0.023809523809523808, 0.10714285714285714],
  [56400.0, 0.10714285714285714, 0.14285714285714285],
  [52000.0, 0.14285714285714285, 0.14285714285714285],
  [10500.0, 0.14285714285714285, 0.14285714285714285],
  [26800.0, 0.14285714285714285, 0.14285714285714285],
  [7600.0, 0.14285714285714285, 0.07936507936507937],
  [19400.0, 0.07936507936507937, 0.11904761904761905],
  [12000.0, 0.11904761904761905, 0.08571428571428572],
  [13300.0, 0.08571428571428572, 0.05714285714285715],
  [25700.0, 0.05714285714285715, 0.028571428571428574],
  [13100.0, 0.028571428571428574, 0.14285714285714285],
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