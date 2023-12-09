[
  [4800.0, 0.0, 0.0],
  [12700.0, 0.0, 0.05714285714285715],
  [23700.0, 0.05714285714285715, 0.07142857142857142],
  [6500.0, 0.07142857142857142, 0.09523809523809523],
  [27500.0, 0.09523809523809523, 0.10714285714285714],
  [31400.0, 0.10714285714285714, 0.023809523809523808],
  [7800.0, 0.023809523809523808, 0.10204081632653061],
  [9100.0, 0.10204081632653061, 0.09090909090909091],
  [30300.0, 0.09090909090909091, 0.08571428571428572],
  [5200.0, 0.08571428571428572, 0.05357142857142857],
  [13500.0, 0.05357142857142857, 0.03571428571428571],
  [99900.0, 0.03571428571428571, 0.09523809523809523],
  [1200.0, 0.09523809523809523, 0.028571428571428574],
  [16400.0, 0.028571428571428574, 0.07142857142857142],
  [39300.0, 0.07142857142857142, 0.08791208791208792],
  [9700.0, 0.08791208791208792, 0.10714285714285714],
  [5300.0, 0.10714285714285714, 0.031746031746031744],
  [20100.0, 0.031746031746031744, 0.07142857142857142],
  [2300.0, 0.07142857142857142, 0.08571428571428572],
  [22600.0, 0.08571428571428572, 0.09523809523809523],
  [5100.0, 0.09523809523809523, 0.07142857142857142],
  [5400.0, 0.07142857142857142, 0.05714285714285715],
  [12000.0, 0.05714285714285715, 0.031746031746031744],
  [5400.0, 0.031746031746031744, 0.05714285714285715],
  [37600.0, 0.05714285714285715, 0.031746031746031744],
  [16300.0, 0.031746031746031744, 0.1142857142857143],
  [31500.0, 0.1142857142857143, 0.07142857142857142],
  [2000.0, 0.07142857142857142, 0.08571428571428572],
  [27200.0, 0.08571428571428572, 0.10204081632653061],
  [17500.0, 0.10204081632653061, 0.10204081632653061],
  [29400.0, 0.10204081632653061, 0.10204081632653061],
  [9200.0, 0.10204081632653061, 0.09523809523809523],
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