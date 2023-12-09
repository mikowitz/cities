[
  [6700.0, 0.0, 0.0],
  [4300.0, 0.0, 0.14285714285714285],
  [12500.0, 0.14285714285714285, 0.16666666666666666],
  [5600.0, 0.16666666666666666, 0.4],
  [2000.0, 0.4, 0.3333333333333333],
  [45500.0, 0.3333333333333333, 0.05555555555555555],
  [12300.0, 0.05555555555555555, 0.3333333333333333],
  [6100.0, 0.3333333333333333, 0.0625],
  [29500.0, 0.0625, 0.1875],
  [5700.0, 0.1875, 0.16666666666666666],
  [19800.0, 0.16666666666666666, 0.15],
  [17900.0, 0.15, 0.1],
  [5100.0, 0.1, 0.1],
  [3700.0, 0.1, 0.3333333333333333],
  [2300.0, 0.3333333333333333, 0.3181818181818182],
  [49000.0, 0.3181818181818182, 0.1],
  [3400.0, 0.1, 0.5],
  [36100.0, 0.5, 0.35714285714285715],
  [19400.0, 0.35714285714285715, 0.2222222222222222],
  [1100.0, 0.2222222222222222, 0.3],
  [1800.0, 0.3, 0.045454545454545456],
  [5400.0, 0.045454545454545456, 0.22727272727272727],
  [4300.0, 0.22727272727272727, 0.5],
  [800.0, 0.5, 0.3333333333333333],
  [7100.0, 0.3333333333333333, 0.08333333333333333],
  [14600.0, 0.08333333333333333, 0.1],
  [1500.0, 0.1, 0.045454545454545456],
  [12100.0, 0.045454545454545456, 0.18181818181818182],
  [38000.0, 0.18181818181818182, 0.1875],
  [37100.0, 0.1875, 0.3333333333333333],
  [6800.0, 0.3333333333333333, 0.5],
  [2200.0, 0.5, 0.08333333333333333],
  [25900.0, 0.08333333333333333, 0.3333333333333333],
  [4500.0, 0.3333333333333333, 0.25],
  [82500.0, 0.25, 0.2857142857142857],
  [14200.0, 0.2857142857142857, 0.3333333333333333],
  [34000.0, 0.3333333333333333, 0.21428571428571427],
  [300.0, 0.21428571428571427, 0.09090909090909091],
  [34300.0, 0.09090909090909091, 0.13636363636363635],
  [6200.0, 0.13636363636363635, 0.2857142857142857],
  [18200.0, 0.2857142857142857, 0.07142857142857142],
  [28100.0, 0.07142857142857142, 0.2727272727272727],
  [300.0, 0.2727272727272727, 0.125],
  [11800.0, 0.125, 0.1875],
  [21800.0, 0.1875, 0.5],
  [4500.0, 0.5, 0.14285714285714285],
  [16800.0, 0.14285714285714285, 0.18181818181818182],
  [20700.0, 0.18181818181818182, 0.25],
] @=> float fades[][];

Gain g => dac;
0.0 => g.gain;

SinOsc s => Pan2 p => g;
0.19 => p.pan;
1600.0 => s.freq;

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