[
  [1800.0, 0.0, 0.0],
  [8900.0, 0.0, 0.14285714285714285],
  [41200.0, 0.14285714285714285, 0.14285714285714285],
  [8700.0, 0.14285714285714285, 0.031746031746031744],
  [18900.0, 0.031746031746031744, 0.05194805194805195],
  [11400.0, 0.05194805194805195, 0.031746031746031744],
  [2400.0, 0.031746031746031744, 0.028571428571428574],
  [2900.0, 0.028571428571428574, 0.08571428571428572],
  [21900.0, 0.08571428571428572, 0.03571428571428571],
  [7300.0, 0.03571428571428571, 0.09523809523809523],
  [15600.0, 0.09523809523809523, 0.10714285714285714],
  [5700.0, 0.10714285714285714, 0.031746031746031744],
  [5600.0, 0.031746031746031744, 0.10714285714285714],
  [2000.0, 0.10714285714285714, 0.07142857142857142],
  [13600.0, 0.07142857142857142, 0.04081632653061224],
  [3900.0, 0.04081632653061224, 0.10204081632653061],
  [57600.0, 0.10204081632653061, 0.047619047619047616],
  [17000.0, 0.047619047619047616, 0.14285714285714285],
  [8700.0, 0.14285714285714285, 0.14285714285714285],
  [4200.0, 0.14285714285714285, 0.10714285714285714],
  [9900.0, 0.10714285714285714, 0.09523809523809523],
  [1200.0, 0.09523809523809523, 0.14285714285714285],
  [13000.0, 0.14285714285714285, 0.07142857142857142],
  [12100.0, 0.07142857142857142, 0.10714285714285714],
  [9800.0, 0.10714285714285714, 0.10714285714285714],
  [4700.0, 0.10714285714285714, 0.07142857142857142],
  [18400.0, 0.07142857142857142, 0.10204081632653061],
  [15700.0, 0.10204081632653061, 0.14285714285714285],
  [4800.0, 0.14285714285714285, 0.14285714285714285],
  [6100.0, 0.14285714285714285, 0.1038961038961039],
  [24200.0, 0.1038961038961039, 0.03571428571428571],
  [2200.0, 0.03571428571428571, 0.14285714285714285],
  [2700.0, 0.14285714285714285, 0.09523809523809523],
  [6800.0, 0.09523809523809523, 0.10714285714285714],
  [3400.0, 0.10714285714285714, 0.10714285714285714],
  [3500.0, 0.10714285714285714, 0.05357142857142857],
  [5200.0, 0.05357142857142857, 0.14285714285714285],
  [23300.0, 0.14285714285714285, 0.12244897959183673],
  [10300.0, 0.12244897959183673, 0.07142857142857142],
  [41200.0, 0.07142857142857142, 0.031746031746031744],
  [8900.0, 0.031746031746031744, 0.10714285714285714],
  [4700.0, 0.10714285714285714, 0.04081632653061224],
  [7600.0, 0.04081632653061224, 0.09523809523809523],
  [13400.0, 0.09523809523809523, 0.047619047619047616],
  [5100.0, 0.047619047619047616, 0.11111111111111112],
  [4400.0, 0.11111111111111112, 0.11904761904761905],
  [30700.0, 0.11904761904761905, 0.10204081632653061],
  [15200.0, 0.10204081632653061, 0.10204081632653061],
  [9300.0, 0.10204081632653061, 0.10714285714285714],
  [12400.0, 0.10714285714285714, 0.14285714285714285],
  [36100.0, 0.14285714285714285, 0.07142857142857142],
  [12600.0, 0.07142857142857142, 0.08571428571428572],
  [4600.0, 0.08571428571428572, 0.03571428571428571],
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
