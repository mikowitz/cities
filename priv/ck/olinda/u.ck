[
  [5300.0, 0.0, 0.0],
  [1600.0, 0.0, 0.14285714285714285],
  [12000.0, 0.14285714285714285, 0.09523809523809523],
  [3700.0, 0.09523809523809523, 0.07142857142857142],
  [1700.0, 0.07142857142857142, 0.09523809523809523],
  [23400.0, 0.09523809523809523, 0.14285714285714285],
  [52500.0, 0.14285714285714285, 0.14285714285714285],
  [26900.0, 0.14285714285714285, 0.061224489795918366],
  [16700.0, 0.061224489795918366, 0.14285714285714285],
  [5600.0, 0.14285714285714285, 0.03571428571428571],
  [8100.0, 0.03571428571428571, 0.10714285714285714],
  [41000.0, 0.10714285714285714, 0.03571428571428571],
  [32900.0, 0.03571428571428571, 0.04081632653061224],
  [13700.0, 0.04081632653061224, 0.07142857142857142],
  [56400.0, 0.07142857142857142, 0.09523809523809523],
  [7700.0, 0.09523809523809523, 0.03571428571428571],
  [20900.0, 0.03571428571428571, 0.09523809523809523],
  [10900.0, 0.09523809523809523, 0.03571428571428571],
  [31100.0, 0.03571428571428571, 0.09523809523809523],
  [3100.0, 0.09523809523809523, 0.03571428571428571],
  [8400.0, 0.03571428571428571, 0.10714285714285714],
  [9100.0, 0.10714285714285714, 0.03571428571428571],
  [58200.0, 0.03571428571428571, 0.07142857142857142],
  [11500.0, 0.07142857142857142, 0.08163265306122448],
  [55100.0, 0.08163265306122448, 0.08928571428571429],
  [28100.0, 0.08928571428571429, 0.09523809523809523],
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