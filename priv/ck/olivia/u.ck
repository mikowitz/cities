[
  [3400.0, 0.0, 0.0],
  [8400.0, 0.0, 0.047619047619047616],
  [5400.0, 0.047619047619047616, 0.14285714285714285],
  [5200.0, 0.14285714285714285, 0.07142857142857142],
  [35900.0, 0.07142857142857142, 0.08928571428571429],
  [11100.0, 0.08928571428571429, 0.14285714285714285],
  [36600.0, 0.14285714285714285, 0.08928571428571429],
  [8600.0, 0.08928571428571429, 0.03571428571428571],
  [34800.0, 0.03571428571428571, 0.031746031746031744],
  [6600.0, 0.031746031746031744, 0.09523809523809523],
  [11700.0, 0.09523809523809523, 0.14285714285714285],
  [3600.0, 0.14285714285714285, 0.08928571428571429],
  [11600.0, 0.08928571428571429, 0.1142857142857143],
  [23600.0, 0.1142857142857143, 0.07142857142857142],
  [14000.0, 0.07142857142857142, 0.08571428571428572],
  [3400.0, 0.08571428571428572, 0.07142857142857142],
  [9400.0, 0.07142857142857142, 0.14285714285714285],
  [30700.0, 0.14285714285714285, 0.07142857142857142],
  [18700.0, 0.07142857142857142, 0.07142857142857142],
  [10200.0, 0.07142857142857142, 0.09523809523809523],
  [30700.0, 0.09523809523809523, 0.10714285714285714],
  [5700.0, 0.10714285714285714, 0.06349206349206349],
  [17900.0, 0.06349206349206349, 0.06349206349206349],
  [4900.0, 0.06349206349206349, 0.07142857142857142],
  [29100.0, 0.07142857142857142, 0.14285714285714285],
  [12400.0, 0.14285714285714285, 0.14285714285714285],
  [13800.0, 0.14285714285714285, 0.05194805194805195],
  [2600.0, 0.05194805194805195, 0.08163265306122448],
  [9100.0, 0.08163265306122448, 0.09523809523809523],
  [4200.0, 0.09523809523809523, 0.14285714285714285],
  [31100.0, 0.14285714285714285, 0.031746031746031744],
  [3000.0, 0.031746031746031744, 0.047619047619047616],
  [1600.0, 0.047619047619047616, 0.09523809523809523],
  [26100.0, 0.09523809523809523, 0.05357142857142857],
  [10400.0, 0.05357142857142857, 0.14285714285714285],
  [2400.0, 0.14285714285714285, 0.08571428571428572],
  [17800.0, 0.08571428571428572, 0.047619047619047616],
  [13600.0, 0.047619047619047616, 0.031746031746031744],
  [8100.0, 0.031746031746031744, 0.028571428571428574],
  [5000.0, 0.028571428571428574, 0.06349206349206349],
  [17700.0, 0.06349206349206349, 0.08571428571428572],
  [41600.0, 0.08571428571428572, 0.08571428571428572],
] @=> float fades[][];

Gain g => dac;
0.0 => g.gain;

SinOsc s => Pan2 p => g;
0.56 => p.pan;
2100.0 => s.freq;

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
