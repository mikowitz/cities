[
  [1400.0, 0.0, 0.0],
  [20100.0, 0.0, 0.06349206349206349],
  [16100.0, 0.06349206349206349, 0.07936507936507937],
  [19400.0, 0.07936507936507937, 0.07142857142857142],
  [47200.0, 0.07142857142857142, 0.03571428571428571],
  [45000.0, 0.03571428571428571, 0.03571428571428571],
  [1200.0, 0.03571428571428571, 0.04081632653061224],
  [7000.0, 0.04081632653061224, 0.10204081632653061],
  [34800.0, 0.10204081632653061, 0.08333333333333334],
  [5200.0, 0.08333333333333334, 0.07936507936507937],
  [11300.0, 0.07936507936507937, 0.05714285714285715],
  [4500.0, 0.05714285714285715, 0.08791208791208792],
  [12500.0, 0.08791208791208792, 0.09523809523809523],
  [16900.0, 0.09523809523809523, 0.015873015873015872],
  [46700.0, 0.015873015873015872, 0.08571428571428572],
  [9900.0, 0.08571428571428572, 0.031746031746031744],
  [7900.0, 0.031746031746031744, 0.061224489795918366],
  [30600.0, 0.061224489795918366, 0.047619047619047616],
  [24100.0, 0.047619047619047616, 0.07792207792207792],
  [3400.0, 0.07792207792207792, 0.031746031746031744],
  [7500.0, 0.031746031746031744, 0.12698412698412698],
  [42800.0, 0.12698412698412698, 0.09523809523809523],
  [42900.0, 0.09523809523809523, 0.047619047619047616],
  [15700.0, 0.047619047619047616, 0.028571428571428574],
  [8100.0, 0.028571428571428574, 0.07142857142857142],
  [9000.0, 0.07142857142857142, 0.08571428571428572],
  [9800.0, 0.08571428571428572, 0.08571428571428572],
  [2200.0, 0.08571428571428572, 0.08163265306122448],
  [5900.0, 0.08163265306122448, 0.047619047619047616],
  [32400.0, 0.047619047619047616, 0.125],
  [52600.0, 0.125, 0.08571428571428572],
  [25000.0, 0.08571428571428572, 0.08571428571428572],
  [2000.0, 0.08571428571428572, 0.05714285714285715],
  [56300.0, 0.05714285714285715, 0.1142857142857143],
  [11400.0, 0.1142857142857143, 0.017857142857142856],
  [11800.0, 0.017857142857142856, 0.07142857142857142],
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