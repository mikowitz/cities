[
  [34400.0, 0.0, 0.0],
  [44800.0, 0.0, 0.09523809523809523],
  [13300.0, 0.09523809523809523, 0.14285714285714285],
  [3900.0, 0.14285714285714285, 0.10204081632653061],
  [45100.0, 0.10204081632653061, 0.07142857142857142],
  [3600.0, 0.07142857142857142, 0.09523809523809523],
  [4400.0, 0.09523809523809523, 0.14285714285714285],
  [6800.0, 0.14285714285714285, 0.14285714285714285],
  [10500.0, 0.14285714285714285, 0.08571428571428572],
  [23500.0, 0.08571428571428572, 0.023809523809523808],
  [14600.0, 0.023809523809523808, 0.023809523809523808],
  [5500.0, 0.023809523809523808, 0.03571428571428571],
  [12700.0, 0.03571428571428571, 0.09523809523809523],
  [10600.0, 0.09523809523809523, 0.10204081632653061],
  [19800.0, 0.10204081632653061, 0.14285714285714285],
  [17700.0, 0.14285714285714285, 0.06349206349206349],
  [11000.0, 0.06349206349206349, 0.14285714285714285],
  [22500.0, 0.14285714285714285, 0.14285714285714285],
  [1500.0, 0.14285714285714285, 0.14285714285714285],
  [23700.0, 0.14285714285714285, 0.061224489795918366],
  [3000.0, 0.061224489795918366, 0.14285714285714285],
  [6100.0, 0.14285714285714285, 0.047619047619047616],
  [2700.0, 0.047619047619047616, 0.07142857142857142],
  [2000.0, 0.07142857142857142, 0.14285714285714285],
  [11300.0, 0.14285714285714285, 0.12244897959183673],
  [2400.0, 0.12244897959183673, 0.07142857142857142],
  [5000.0, 0.07142857142857142, 0.14285714285714285],
  [800.0, 0.14285714285714285, 0.14285714285714285],
  [9700.0, 0.14285714285714285, 0.03571428571428571],
  [12500.0, 0.03571428571428571, 0.03571428571428571],
  [2400.0, 0.03571428571428571, 0.12244897959183673],
  [10800.0, 0.12244897959183673, 0.03571428571428571],
  [11600.0, 0.03571428571428571, 0.047619047619047616],
  [8100.0, 0.047619047619047616, 0.012987012987012988],
  [12900.0, 0.012987012987012988, 0.10204081632653061],
  [16800.0, 0.10204081632653061, 0.14285714285714285],
  [92600.0, 0.14285714285714285, 0.14285714285714285],
  [8400.0, 0.14285714285714285, 0.08571428571428572],
  [6600.0, 0.08571428571428572, 0.07936507936507937],
  [25500.0, 0.07936507936507937, 0.10204081632653061],
  [35600.0, 0.10204081632653061, 0.03571428571428571],
  [8300.0, 0.03571428571428571, 0.14285714285714285],
  [6700.0, 0.14285714285714285, 0.14285714285714285],
  [2100.0, 0.14285714285714285, 0.14285714285714285],
  [7900.0, 0.14285714285714285, 0.06493506493506493],
  [10400.0, 0.06493506493506493, 0.07936507936507937],
  [37400.0, 0.07936507936507937, 0.07142857142857142],
  [21200.0, 0.07142857142857142, 0.03571428571428571],
  [6500.0, 0.03571428571428571, 0.017857142857142856],
  [17000.0, 0.017857142857142856, 0.10204081632653061],
  [7200.0, 0.10204081632653061, 0.14285714285714285],
  [18200.0, 0.14285714285714285, 0.05714285714285715],
  [11800.0, 0.05714285714285715, 0.10204081632653061],
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
