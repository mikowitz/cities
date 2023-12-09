[
  [5500.0, 0.0, 0.0],
  [58700.0, 0.0, 0.07142857142857142],
  [42200.0, 0.07142857142857142, 0.04081632653061224],
  [6600.0, 0.04081632653061224, 0.07142857142857142],
  [5000.0, 0.07142857142857142, 0.1142857142857143],
  [14900.0, 0.1142857142857143, 0.10714285714285714],
  [27500.0, 0.10714285714285714, 0.07142857142857142],
  [6100.0, 0.07142857142857142, 0.08571428571428572],
  [30700.0, 0.08571428571428572, 0.08571428571428572],
  [46400.0, 0.08571428571428572, 0.09523809523809523],
  [5500.0, 0.09523809523809523, 0.04081632653061224],
  [9600.0, 0.04081632653061224, 0.061224489795918366],
  [40400.0, 0.061224489795918366, 0.07936507936507937],
  [46400.0, 0.07936507936507937, 0.08571428571428572],
  [7400.0, 0.08571428571428572, 0.04285714285714286],
  [2500.0, 0.04285714285714286, 0.04081632653061224],
  [61200.0, 0.04081632653061224, 0.10204081632653061],
  [10400.0, 0.10204081632653061, 0.08571428571428572],
  [36000.0, 0.08571428571428572, 0.14285714285714285],
  [13700.0, 0.14285714285714285, 0.04081632653061224],
  [14100.0, 0.04081632653061224, 0.07142857142857142],
  [19900.0, 0.07142857142857142, 0.07142857142857142],
  [28600.0, 0.07142857142857142, 0.09523809523809523],
  [25700.0, 0.09523809523809523, 0.06349206349206349],
  [34500.0, 0.06349206349206349, 0.04081632653061224],
  [38500.0, 0.04081632653061224, 0.08571428571428572],
  [41400.0, 0.08571428571428572, 0.06349206349206349],
  [14700.0, 0.06349206349206349, 0.07142857142857142],
  [5000.0, 0.07142857142857142, 0.10204081632653061],
  [35700.0, 0.10204081632653061, 0.06349206349206349],
  [14100.0, 0.06349206349206349, 0.05714285714285715],
  [2500.0, 0.05714285714285715, 0.04081632653061224],
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
