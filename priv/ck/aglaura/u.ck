[
  [8800.0, 0.0, 0.0],
  [1400.0, 0.0, 0.14285714285714285],
  [2400.0, 0.14285714285714285, 0.1142857142857143],
  [31800.0, 0.1142857142857143, 0.10204081632653061],
  [1800.0, 0.10204081632653061, 0.10204081632653061],
  [6400.0, 0.10204081632653061, 0.061224489795918366],
  [10100.0, 0.061224489795918366, 0.07142857142857142],
  [4200.0, 0.07142857142857142, 0.025974025974025976],
  [6900.0, 0.025974025974025976, 0.12987012987012986],
  [19500.0, 0.12987012987012986, 0.05714285714285715],
  [2800.0, 0.05714285714285715, 0.10204081632653061],
  [1900.0, 0.10204081632653061, 0.05357142857142857],
  [4300.0, 0.05357142857142857, 0.125],
  [3200.0, 0.125, 0.09999999999999999],
  [4700.0, 0.09999999999999999, 0.10204081632653061],
  [8600.0, 0.10204081632653061, 0.07142857142857142],
  [4100.0, 0.07142857142857142, 0.031746031746031744],
  [30700.0, 0.031746031746031744, 0.047619047619047616],
  [12300.0, 0.047619047619047616, 0.10204081632653061],
  [17600.0, 0.10204081632653061, 0.10204081632653061],
  [9300.0, 0.10204081632653061, 0.09523809523809523],
  [1100.0, 0.09523809523809523, 0.028571428571428574],
  [15100.0, 0.028571428571428574, 0.08571428571428572],
  [2700.0, 0.08571428571428572, 0.10204081632653061],
  [16800.0, 0.10204081632653061, 0.07142857142857142],
  [2700.0, 0.07142857142857142, 0.10204081632653061],
  [10100.0, 0.10204081632653061, 0.07142857142857142],
  [13700.0, 0.07142857142857142, 0.1038961038961039],
  [4800.0, 0.1038961038961039, 0.10204081632653061],
  [4800.0, 0.10204081632653061, 0.10714285714285714],
  [43800.0, 0.10714285714285714, 0.08928571428571429],
  [8800.0, 0.08928571428571429, 0.031746031746031744],
  [9600.0, 0.031746031746031744, 0.09523809523809523],
  [33700.0, 0.09523809523809523, 0.07142857142857142],
  [2900.0, 0.07142857142857142, 0.10204081632653061],
  [18700.0, 0.10204081632653061, 0.14285714285714285],
  [3800.0, 0.14285714285714285, 0.09523809523809523],
  [11400.0, 0.09523809523809523, 0.14285714285714285],
  [13100.0, 0.14285714285714285, 0.12244897959183673],
  [3600.0, 0.12244897959183673, 0.09523809523809523],
  [4300.0, 0.09523809523809523, 0.08571428571428572],
  [8800.0, 0.08571428571428572, 0.10714285714285714],
  [14200.0, 0.10714285714285714, 0.08571428571428572],
  [6900.0, 0.08571428571428572, 0.14285714285714285],
  [8600.0, 0.14285714285714285, 0.14285714285714285],
  [15600.0, 0.14285714285714285, 0.011904761904761904],
  [1100.0, 0.011904761904761904, 0.14285714285714285],
  [7900.0, 0.14285714285714285, 0.08571428571428572],
  [8500.0, 0.08571428571428572, 0.09523809523809523],
  [4600.0, 0.09523809523809523, 0.09999999999999999],
  [7400.0, 0.09999999999999999, 0.10204081632653061],
  [7700.0, 0.10204081632653061, 0.10714285714285714],
  [29600.0, 0.10714285714285714, 0.14285714285714285],
  [13500.0, 0.14285714285714285, 0.10204081632653061],
  [10500.0, 0.10204081632653061, 0.10204081632653061],
  [9500.0, 0.10204081632653061, 0.10204081632653061],
  [5800.0, 0.10204081632653061, 0.09523809523809523],
  [23200.0, 0.09523809523809523, 0.08571428571428572],
  [21900.0, 0.08571428571428572, 0.10204081632653061],
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
