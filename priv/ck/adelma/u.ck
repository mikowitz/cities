[
  [10400.0, 0.0, 0.0],
  [8200.0, 0.0, 0.08928571428571429],
  [15000.0, 0.08928571428571429, 0.07142857142857142],
  [30500.0, 0.07142857142857142, 0.07142857142857142],
  [18300.0, 0.07142857142857142, 0.10714285714285714],
  [9300.0, 0.10714285714285714, 0.02040816326530612],
  [12000.0, 0.02040816326530612, 0.08163265306122448],
  [11600.0, 0.08163265306122448, 0.047619047619047616],
  [23200.0, 0.047619047619047616, 0.09523809523809523],
  [13200.0, 0.09523809523809523, 0.08571428571428572],
  [11600.0, 0.08571428571428572, 0.028571428571428574],
  [5300.0, 0.028571428571428574, 0.04081632653061224],
  [32900.0, 0.04081632653061224, 0.09523809523809523],
  [20800.0, 0.09523809523809523, 0.047619047619047616],
  [18100.0, 0.047619047619047616, 0.08163265306122448],
  [1900.0, 0.08163265306122448, 0.14285714285714285],
  [36800.0, 0.14285714285714285, 0.07936507936507937],
  [27700.0, 0.07936507936507937, 0.125],
  [41300.0, 0.125, 0.08163265306122448],
  [69400.0, 0.08163265306122448, 0.09523809523809523],
  [2600.0, 0.09523809523809523, 0.08163265306122448],
  [14100.0, 0.08163265306122448, 0.14285714285714285],
  [5400.0, 0.14285714285714285, 0.14285714285714285],
  [1900.0, 0.14285714285714285, 0.031746031746031744],
  [12800.0, 0.031746031746031744, 0.07936507936507937],
  [16600.0, 0.07936507936507937, 0.08163265306122448],
  [1900.0, 0.08163265306122448, 0.14285714285714285],
  [21100.0, 0.14285714285714285, 0.07936507936507937],
  [49000.0, 0.07936507936507937, 0.03571428571428571],
  [11900.0, 0.03571428571428571, 0.07142857142857142],
  [11500.0, 0.07142857142857142, 0.08163265306122448],
  [2400.0, 0.08163265306122448, 0.09523809523809523],
  [8900.0, 0.09523809523809523, 0.08571428571428572],
  [5000.0, 0.08571428571428572, 0.047619047619047616],
  [25000.0, 0.047619047619047616, 0.07142857142857142],
  [108800.0, 0.07142857142857142, 0.014285714285714287],
  [42400.0, 0.014285714285714287, 0.08163265306122448],
  [12600.0, 0.08163265306122448, 0.08163265306122448],
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
