[
  [8800.0, 0.0, 0.0],
  [14200.0, 0.0, 0.125],
  [1000.0, 0.125, 0.10714285714285714],
  [1500.0, 0.10714285714285714, 0.14285714285714285],
  [8300.0, 0.14285714285714285, 0.14285714285714285],
  [3200.0, 0.14285714285714285, 0.025974025974025976],
  [3400.0, 0.025974025974025976, 0.1168831168831169],
  [6600.0, 0.1168831168831169, 0.10714285714285714],
  [4300.0, 0.10714285714285714, 0.14285714285714285],
  [4900.0, 0.14285714285714285, 0.11904761904761905],
  [3300.0, 0.11904761904761905, 0.14285714285714285],
  [10400.0, 0.14285714285714285, 0.12244897959183673],
  [1400.0, 0.12244897959183673, 0.10204081632653061],
  [900.0, 0.10204081632653061, 0.09523809523809523],
  [7900.0, 0.09523809523809523, 0.07142857142857142],
  [11200.0, 0.07142857142857142, 0.14285714285714285],
  [6400.0, 0.14285714285714285, 0.12244897959183673],
  [1600.0, 0.12244897959183673, 0.14285714285714285],
  [3900.0, 0.14285714285714285, 0.031746031746031744],
  [2300.0, 0.031746031746031744, 0.047619047619047616],
  [3200.0, 0.047619047619047616, 0.04285714285714286],
  [4900.0, 0.04285714285714286, 0.1285714285714286],
  [4200.0, 0.1285714285714286, 0.09523809523809523],
  [4700.0, 0.09523809523809523, 0.1285714285714286],
  [2800.0, 0.1285714285714286, 0.14285714285714285],
  [6900.0, 0.14285714285714285, 0.05357142857142857],
  [4100.0, 0.05357142857142857, 0.14285714285714285],
  [2000.0, 0.14285714285714285, 0.12244897959183673],
  [2200.0, 0.12244897959183673, 0.03571428571428571],
  [9200.0, 0.03571428571428571, 0.061224489795918366],
  [2200.0, 0.061224489795918366, 0.03571428571428571],
  [8500.0, 0.03571428571428571, 0.10714285714285714],
  [3500.0, 0.10714285714285714, 0.14285714285714285],
  [11300.0, 0.14285714285714285, 0.14285714285714285],
  [6000.0, 0.14285714285714285, 0.12698412698412698],
  [4400.0, 0.12698412698412698, 0.14285714285714285],
  [7700.0, 0.14285714285714285, 0.14285714285714285],
  [4700.0, 0.14285714285714285, 0.025974025974025976],
  [6600.0, 0.025974025974025976, 0.12987012987012986],
  [8700.0, 0.12987012987012986, 0.12698412698412698],
  [9700.0, 0.12698412698412698, 0.14285714285714285],
  [15100.0, 0.14285714285714285, 0.09523809523809523],
  [4300.0, 0.09523809523809523, 0.14285714285714285],
  [4300.0, 0.14285714285714285, 0.12698412698412698],
  [2800.0, 0.12698412698412698, 0.14285714285714285],
  [3600.0, 0.14285714285714285, 0.04285714285714286],
  [4200.0, 0.04285714285714286, 0.023809523809523808],
  [4200.0, 0.023809523809523808, 0.14285714285714285],
  [2400.0, 0.14285714285714285, 0.061224489795918366],
  [5400.0, 0.061224489795918366, 0.14285714285714285],
  [16500.0, 0.14285714285714285, 0.047619047619047616],
  [2500.0, 0.047619047619047616, 0.11111111111111112],
  [13500.0, 0.11111111111111112, 0.14285714285714285],
  [4400.0, 0.14285714285714285, 0.125],
  [9500.0, 0.125, 0.14285714285714285],
  [8300.0, 0.14285714285714285, 0.14285714285714285],
  [2300.0, 0.14285714285714285, 0.14285714285714285],
  [9900.0, 0.14285714285714285, 0.08163265306122448],
  [4000.0, 0.08163265306122448, 0.14285714285714285],
  [11700.0, 0.14285714285714285, 0.12244897959183673],
  [6200.0, 0.12244897959183673, 0.07142857142857142],
  [14400.0, 0.07142857142857142, 0.11904761904761905],
  [7000.0, 0.11904761904761905, 0.125],
  [9900.0, 0.125, 0.11904761904761905],
  [6400.0, 0.11904761904761905, 0.03571428571428571],
] @=> float fades[][];

Gain g => dac;
0.0 => g.gain;

SinOsc s => Pan2 p => g;
0.04 => p.pan;
1400.0 => s.freq;

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