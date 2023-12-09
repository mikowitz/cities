[
  [17800.0, 0.0, 0.0],
  [1400.0, 0.0, 0.5],
  [29300.0, 0.5, 0.1875],
  [5900.0, 0.1875, 0.5],
  [17300.0, 0.5, 0.2222222222222222],
  [700.0, 0.2222222222222222, 0.3333333333333333],
  [4700.0, 0.3333333333333333, 0.1],
  [4800.0, 0.1, 0.3333333333333333],
  [3300.0, 0.3333333333333333, 0.25],
  [18500.0, 0.25, 0.5],
  [10100.0, 0.5, 0.5],
  [7200.0, 0.5, 0.5],
  [40400.0, 0.5, 0.5],
  [200.0, 0.5, 0.5],
  [6400.0, 0.5, 0.07142857142857142],
  [26200.0, 0.07142857142857142, 0.5],
  [9700.0, 0.5, 0.5],
  [9800.0, 0.5, 0.5],
  [6600.0, 0.5, 0.4],
  [1600.0, 0.4, 0.5],
  [3800.0, 0.5, 0.21428571428571427],
  [10100.0, 0.21428571428571427, 0.125],
  [6400.0, 0.125, 0.5],
  [6400.0, 0.5, 0.5],
  [2500.0, 0.5, 0.5],
  [8400.0, 0.5, 0.5],
  [3800.0, 0.5, 0.3333333333333333],
  [3800.0, 0.3333333333333333, 0.125],
  [14400.0, 0.125, 0.1],
  [3300.0, 0.1, 0.5],
  [6600.0, 0.5, 0.25],
  [35300.0, 0.25, 0.4166666666666667],
  [12900.0, 0.4166666666666667, 0.5],
  [2500.0, 0.5, 0.3333333333333333],
  [4900.0, 0.3333333333333333, 0.5],
  [900.0, 0.5, 0.25],
  [5800.0, 0.25, 0.5],
  [200.0, 0.5, 0.21428571428571427],
  [500.0, 0.21428571428571427, 0.2857142857142857],
  [4100.0, 0.2857142857142857, 0.5],
  [10000.0, 0.5, 0.5],
  [11000.0, 0.5, 0.5],
  [4600.0, 0.5, 0.5],
  [3800.0, 0.5, 0.5],
  [4400.0, 0.5, 0.5],
  [14200.0, 0.5, 0.1],
  [200.0, 0.1, 0.25],
  [2100.0, 0.25, 0.3333333333333333],
  [9300.0, 0.3333333333333333, 0.25],
  [12300.0, 0.25, 0.5],
  [8700.0, 0.5, 0.25],
  [4900.0, 0.25, 0.5],
  [7800.0, 0.5, 0.5],
  [10500.0, 0.5, 0.5],
  [25200.0, 0.5, 0.5],
  [10800.0, 0.5, 0.5],
  [6700.0, 0.5, 0.5],
  [5200.0, 0.5, 0.5],
  [10500.0, 0.5, 0.5],
  [10600.0, 0.5, 0.3333333333333333],
  [200.0, 0.3333333333333333, 0.25],
  [8800.0, 0.25, 0.3],
  [31600.0, 0.3, 0.3333333333333333],
  [20900.0, 0.3333333333333333, 0.3333333333333333],
  [800.0, 0.3333333333333333, 0.5],
  [7400.0, 0.5, 0.05555555555555555],
  [20000.0, 0.05555555555555555, 0.5],
  [6100.0, 0.5, 0.5],
  [3800.0, 0.5, 0.3],
  [8100.0, 0.3, 0.4],
  [11200.0, 0.4, 0.3333333333333333],
  [3700.0, 0.3333333333333333, 0.045454545454545456],
  [8600.0, 0.045454545454545456, 0.5],
  [18300.0, 0.5, 0.3333333333333333],
  [900.0, 0.3333333333333333, 0.25],
  [10600.0, 0.25, 0.5],
  [25000.0, 0.5, 0.07142857142857142],
  [3800.0, 0.07142857142857142, 0.5],
  [4100.0, 0.5, 0.07142857142857142],
  [2100.0, 0.07142857142857142, 0.5],
  [16000.0, 0.5, 0.5],
  [8100.0, 0.5, 0.5],
] @=> float fades[][];

Gain g => dac;
0.0 => g.gain;

SinOsc s => Pan2 p => g;
-0.7 => p.pan;
400.0 => s.freq;

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