[
  [2200.0, 0.0, 0.0],
  [2700.0, 0.0, 0.2],
  [5300.0, 0.2, 0.3333333333333333],
  [1600.0, 0.3333333333333333, 0.2],
  [7300.0, 0.2, 0.5],
  [2400.0, 0.5, 0.25],
  [2600.0, 0.25, 0.2857142857142857],
  [2000.0, 0.2857142857142857, 0.16666666666666666],
  [12300.0, 0.16666666666666666, 0.5],
  [2000.0, 0.5, 0.125],
  [5900.0, 0.125, 0.5],
  [600.0, 0.5, 0.3333333333333333],
  [9800.0, 0.3333333333333333, 0.08333333333333333],
  [17900.0, 0.08333333333333333, 0.5],
  [2100.0, 0.5, 0.07142857142857142],
  [7700.0, 0.07142857142857142, 0.35714285714285715],
  [7900.0, 0.35714285714285715, 0.35714285714285715],
  [28000.0, 0.35714285714285715, 0.07142857142857142],
  [11900.0, 0.07142857142857142, 0.35714285714285715],
  [11000.0, 0.35714285714285715, 0.5],
  [20000.0, 0.5, 0.25],
  [4700.0, 0.25, 0.2],
  [5400.0, 0.2, 0.25],
  [7100.0, 0.25, 0.2],
  [1000.0, 0.2, 0.14285714285714285],
  [8100.0, 0.14285714285714285, 0.35714285714285715],
  [6200.0, 0.35714285714285715, 0.3333333333333333],
  [1600.0, 0.3333333333333333, 0.2],
  [500.0, 0.2, 0.5],
  [2500.0, 0.5, 0.16666666666666666],
  [4400.0, 0.16666666666666666, 0.2857142857142857],
  [3100.0, 0.2857142857142857, 0.14285714285714285],
  [13900.0, 0.14285714285714285, 0.5],
  [7700.0, 0.5, 0.3333333333333333],
  [5600.0, 0.3333333333333333, 0.2857142857142857],
  [7500.0, 0.2857142857142857, 0.25],
  [6500.0, 0.25, 0.25],
  [10100.0, 0.25, 0.15],
  [5200.0, 0.15, 0.16666666666666666],
  [12900.0, 0.16666666666666666, 0.1],
  [1100.0, 0.1, 0.25],
  [6200.0, 0.25, 0.25],
  [19700.0, 0.25, 0.5],
  [12500.0, 0.5, 0.2857142857142857],
  [22500.0, 0.2857142857142857, 0.5],
  [5400.0, 0.5, 0.25],
  [15400.0, 0.25, 0.25],
  [1000.0, 0.25, 0.14285714285714285],
  [11800.0, 0.14285714285714285, 0.35714285714285715],
  [7900.0, 0.35714285714285715, 0.1],
  [2100.0, 0.1, 0.3333333333333333],
  [14500.0, 0.3333333333333333, 0.21428571428571427],
  [7100.0, 0.21428571428571427, 0.2],
  [5200.0, 0.2, 0.3333333333333333],
  [2800.0, 0.3333333333333333, 0.35714285714285715],
  [1400.0, 0.35714285714285715, 0.2],
  [1500.0, 0.2, 0.25],
  [3100.0, 0.25, 0.14285714285714285],
  [900.0, 0.14285714285714285, 0.5],
  [4000.0, 0.5, 0.3333333333333333],
  [800.0, 0.3333333333333333, 0.3333333333333333],
  [8900.0, 0.3333333333333333, 0.14285714285714285],
  [9700.0, 0.14285714285714285, 0.2],
  [2800.0, 0.2, 0.2],
  [1600.0, 0.2, 0.2],
  [4900.0, 0.2, 0.5],
  [3900.0, 0.5, 0.3333333333333333],
  [8700.0, 0.3333333333333333, 0.3333333333333333],
] @=> float fades[][];

Gain g => dac;
0.0 => g.gain;

SinOsc s => Pan2 p => g;
-0.41 => p.pan;
800.0 => s.freq;

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