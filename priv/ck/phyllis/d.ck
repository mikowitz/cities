[
  [7000.0, 0.0, 0.0],
  [17100.0, 0.0, 0.5],
  [6400.0, 0.5, 0.2857142857142857],
  [11600.0, 0.2857142857142857, 0.05555555555555555],
  [1900.0, 0.05555555555555555, 0.5],
  [10100.0, 0.5, 0.5],
  [300.0, 0.5, 0.3888888888888889],
  [9000.0, 0.3888888888888889, 0.5],
  [1500.0, 0.5, 0.4090909090909091],
  [6800.0, 0.4090909090909091, 0.5],
  [1700.0, 0.5, 0.2857142857142857],
  [9100.0, 0.2857142857142857, 0.125],
  [7900.0, 0.125, 0.5],
  [4900.0, 0.5, 0.5],
  [7500.0, 0.5, 0.5],
  [7800.0, 0.5, 0.2916666666666667],
  [9000.0, 0.2916666666666667, 0.4],
  [7600.0, 0.4, 0.5],
  [53100.0, 0.5, 0.5],
  [12600.0, 0.5, 0.125],
  [300.0, 0.125, 0.375],
  [18200.0, 0.375, 0.5],
  [1500.0, 0.5, 0.16666666666666666],
  [55800.0, 0.16666666666666666, 0.5],
  [9400.0, 0.5, 0.5],
  [1600.0, 0.5, 0.5],
  [5600.0, 0.5, 0.5],
  [7400.0, 0.5, 0.125],
  [9800.0, 0.125, 0.3],
  [5000.0, 0.3, 0.2857142857142857],
  [8800.0, 0.2857142857142857, 0.5],
  [28600.0, 0.5, 0.1],
  [20300.0, 0.1, 0.045454545454545456],
  [500.0, 0.045454545454545456, 0.4],
  [16900.0, 0.4, 0.125],
  [46700.0, 0.125, 0.125],
  [9500.0, 0.125, 0.1],
  [300.0, 0.1, 0.3888888888888889],
  [4700.0, 0.3888888888888889, 0.5],
  [19500.0, 0.5, 0.5],
  [8900.0, 0.5, 0.3125],
  [4800.0, 0.3125, 0.2222222222222222],
  [12100.0, 0.2222222222222222, 0.3333333333333333],
  [12800.0, 0.3333333333333333, 0.42857142857142855],
  [2000.0, 0.42857142857142855, 0.5],
  [4000.0, 0.5, 0.5],
  [32300.0, 0.5, 0.35714285714285715],
  [3100.0, 0.35714285714285715, 0.5],
  [1500.0, 0.5, 0.3181818181818182],
  [12200.0, 0.3181818181818182, 0.5],
  [19500.0, 0.5, 0.4166666666666667],
  [16500.0, 0.4166666666666667, 0.4166666666666667],
  [3100.0, 0.4166666666666667, 0.2857142857142857],
  [4300.0, 0.2857142857142857, 0.2857142857142857],
  [26000.0, 0.2857142857142857, 0.5],
  [16400.0, 0.5, 0.4],
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