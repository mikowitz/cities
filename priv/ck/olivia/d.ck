[
  [23600.0, 0.0, 0.0],
  [4600.0, 0.0, 0.5],
  [2000.0, 0.5, 0.4],
  [5400.0, 0.4, 0.0625],
  [5600.0, 0.0625, 0.5],
  [13100.0, 0.5, 0.5],
  [14900.0, 0.5, 0.0625],
  [2800.0, 0.0625, 0.25],
  [8700.0, 0.25, 0.5],
  [24900.0, 0.5, 0.1875],
  [12000.0, 0.1875, 0.5],
  [2000.0, 0.5, 0.5],
  [2200.0, 0.5, 0.2857142857142857],
  [23500.0, 0.2857142857142857, 0.5],
  [9900.0, 0.5, 0.42857142857142855],
  [13300.0, 0.42857142857142855, 0.4],
  [300.0, 0.4, 0.375],
  [3300.0, 0.375, 0.5],
  [2300.0, 0.5, 0.5],
  [34100.0, 0.5, 0.5],
  [24600.0, 0.5, 0.13636363636363635],
  [6800.0, 0.13636363636363635, 0.1875],
  [200.0, 0.1875, 0.1875],
  [35200.0, 0.1875, 0.25],
  [2800.0, 0.25, 0.375],
  [200.0, 0.375, 0.21428571428571427],
  [11600.0, 0.21428571428571427, 0.2857142857142857],
  [9200.0, 0.2857142857142857, 0.4],
  [2200.0, 0.4, 0.5],
  [4000.0, 0.5, 0.5],
  [16600.0, 0.5, 0.2857142857142857],
  [3700.0, 0.2857142857142857, 0.5],
  [2200.0, 0.5, 0.4444444444444444],
  [3500.0, 0.4444444444444444, 0.4],
  [8600.0, 0.4, 0.4444444444444444],
  [21600.0, 0.4444444444444444, 0.5],
  [2500.0, 0.5, 0.4],
  [4200.0, 0.4, 0.5],
  [3500.0, 0.5, 0.5],
  [11000.0, 0.5, 0.5],
  [4000.0, 0.5, 0.25],
  [10400.0, 0.25, 0.4],
  [21500.0, 0.4, 0.5],
  [13200.0, 0.5, 0.5],
  [2800.0, 0.5, 0.5],
  [31100.0, 0.5, 0.5],
  [11300.0, 0.5, 0.0625],
  [8900.0, 0.0625, 0.5],
  [10600.0, 0.5, 0.25],
  [2600.0, 0.25, 0.5],
  [5300.0, 0.5, 0.05555555555555555],
  [14300.0, 0.05555555555555555, 0.4],
  [2000.0, 0.4, 0.5],
  [1700.0, 0.5, 0.2857142857142857],
  [2600.0, 0.2857142857142857, 0.5],
  [200.0, 0.5, 0.1875],
  [2800.0, 0.1875, 0.25],
  [5700.0, 0.25, 0.5],
  [2700.0, 0.5, 0.5],
  [7000.0, 0.5, 0.5],
  [3400.0, 0.5, 0.5],
  [3900.0, 0.5, 0.5],
  [200.0, 0.5, 0.3333333333333333],
  [2800.0, 0.3333333333333333, 0.3888888888888889],
  [700.0, 0.3888888888888889, 0.5],
  [6700.0, 0.5, 0.0625],
  [18700.0, 0.0625, 0.5],
  [7400.0, 0.5, 0.5],
  [6500.0, 0.5, 0.5],
  [8000.0, 0.5, 0.4],
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
