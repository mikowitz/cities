[
  [2300.0, 0.0, 0.0],
  [4200.0, 0.0, 0.028571428571428574],
  [44900.0, 0.028571428571428574, 0.1142857142857143],
  [3600.0, 0.1142857142857143, 0.09523809523809523],
  [37000.0, 0.09523809523809523, 0.10204081632653061],
  [2600.0, 0.10204081632653061, 0.12698412698412698],
  [3800.0, 0.12698412698412698, 0.09523809523809523],
  [3900.0, 0.09523809523809523, 0.10204081632653061],
  [26800.0, 0.10204081632653061, 0.1142857142857143],
  [36800.0, 0.1142857142857143, 0.047619047619047616],
  [13900.0, 0.047619047619047616, 0.07936507936507937],
  [10100.0, 0.07936507936507937, 0.10204081632653061],
  [38100.0, 0.10204081632653061, 0.10204081632653061],
  [1100.0, 0.10204081632653061, 0.14285714285714285],
  [8100.0, 0.14285714285714285, 0.08571428571428572],
  [56400.0, 0.08571428571428572, 0.12244897959183673],
  [41700.0, 0.12244897959183673, 0.05714285714285715],
  [3800.0, 0.05714285714285715, 0.10714285714285714],
  [5400.0, 0.10714285714285714, 0.10204081632653061],
  [14600.0, 0.10204081632653061, 0.047619047619047616],
  [13900.0, 0.047619047619047616, 0.047619047619047616],
  [11300.0, 0.047619047619047616, 0.09523809523809523],
  [4600.0, 0.09523809523809523, 0.1142857142857143],
  [3500.0, 0.1142857142857143, 0.028571428571428574],
  [1100.0, 0.028571428571428574, 0.1285714285714286],
  [3600.0, 0.1285714285714286, 0.015873015873015872],
  [24700.0, 0.015873015873015872, 0.028571428571428574],
  [18300.0, 0.028571428571428574, 0.09523809523809523],
  [20400.0, 0.09523809523809523, 0.09523809523809523],
  [11400.0, 0.09523809523809523, 0.14285714285714285],
  [4900.0, 0.14285714285714285, 0.14285714285714285],
  [76000.0, 0.14285714285714285, 0.14285714285714285],
  [4100.0, 0.14285714285714285, 0.10204081632653061],
  [5300.0, 0.10204081632653061, 0.09523809523809523],
  [15500.0, 0.09523809523809523, 0.09523809523809523],
  [11400.0, 0.09523809523809523, 0.10714285714285714],
  [5800.0, 0.10714285714285714, 0.10714285714285714],
  [28800.0, 0.10714285714285714, 0.10714285714285714],
  [18200.0, 0.10714285714285714, 0.10714285714285714],
  [6300.0, 0.10714285714285714, 0.09523809523809523],
  [9700.0, 0.09523809523809523, 0.07142857142857142],
  [6300.0, 0.07142857142857142, 0.12244897959183673],
  [9800.0, 0.12244897959183673, 0.07142857142857142],
  [8700.0, 0.07142857142857142, 0.12244897959183673],
  [35000.0, 0.12244897959183673, 0.14285714285714285],
  [68100.0, 0.14285714285714285, 0.09523809523809523],
  [20400.0, 0.09523809523809523, 0.09523809523809523],
  [11000.0, 0.09523809523809523, 0.1142857142857143],
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