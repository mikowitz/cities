[
  [1800.0, 0.0, 0.0],
  [9700.0, 0.0, 0.14285714285714285],
  [5500.0, 0.14285714285714285, 0.14285714285714285],
  [5100.0, 0.14285714285714285, 0.05357142857142857],
  [1100.0, 0.05357142857142857, 0.14285714285714285],
  [6600.0, 0.14285714285714285, 0.03571428571428571],
  [22000.0, 0.03571428571428571, 0.14285714285714285],
  [8000.0, 0.14285714285714285, 0.03571428571428571],
  [2500.0, 0.03571428571428571, 0.08163265306122448],
  [10700.0, 0.08163265306122448, 0.028571428571428574],
  [16300.0, 0.028571428571428574, 0.07936507936507937],
  [3000.0, 0.07936507936507937, 0.047619047619047616],
  [25200.0, 0.047619047619047616, 0.11111111111111112],
  [13300.0, 0.11111111111111112, 0.047619047619047616],
  [5300.0, 0.047619047619047616, 0.10714285714285714],
  [3200.0, 0.10714285714285714, 0.061224489795918366],
  [16200.0, 0.061224489795918366, 0.14285714285714285],
  [11800.0, 0.14285714285714285, 0.14285714285714285],
  [18200.0, 0.14285714285714285, 0.14285714285714285],
  [85300.0, 0.14285714285714285, 0.04081632653061224],
  [6800.0, 0.04081632653061224, 0.125],
  [14400.0, 0.125, 0.025974025974025976],
  [30900.0, 0.025974025974025976, 0.09523809523809523],
  [24200.0, 0.09523809523809523, 0.09523809523809523],
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