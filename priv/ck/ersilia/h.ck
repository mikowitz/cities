[
  [8500.0, 0.0, 0.0],
  [900.0, 0.0, 0.5],
  [4600.0, 0.5, 0.3333333333333333],
  [2400.0, 0.3333333333333333, 0.38461538461538464],
  [5100.0, 0.38461538461538464, 0.25],
  [4400.0, 0.25, 0.3333333333333333],
  [2200.0, 0.3333333333333333, 0.3333333333333333],
  [6400.0, 0.3333333333333333, 0.13636363636363635],
  [7000.0, 0.13636363636363635, 0.5],
  [4900.0, 0.5, 0.3333333333333333],
  [600.0, 0.3333333333333333, 0.3333333333333333],
  [2300.0, 0.3333333333333333, 0.08333333333333333],
  [11100.0, 0.08333333333333333, 0.2],
  [6800.0, 0.2, 0.38461538461538464],
  [1000.0, 0.38461538461538464, 0.14285714285714285],
  [2100.0, 0.14285714285714285, 0.35714285714285715],
  [6900.0, 0.35714285714285715, 0.25],
  [6600.0, 0.25, 0.4166666666666667],
  [5400.0, 0.4166666666666667, 0.2222222222222222],
  [1700.0, 0.2222222222222222, 0.25],
  [11200.0, 0.25, 0.3333333333333333],
  [10400.0, 0.3333333333333333, 0.25],
  [1400.0, 0.25, 0.25],
  [2200.0, 0.25, 0.3333333333333333],
  [5000.0, 0.3333333333333333, 0.13636363636363635],
  [600.0, 0.13636363636363635, 0.3333333333333333],
  [8700.0, 0.3333333333333333, 0.08333333333333333],
  [6400.0, 0.08333333333333333, 0.3333333333333333],
  [22100.0, 0.3333333333333333, 0.2],
  [900.0, 0.2, 0.5],
  [2600.0, 0.5, 0.2],
  [1800.0, 0.2, 0.05555555555555555],
  [11200.0, 0.05555555555555555, 0.3333333333333333],
  [4600.0, 0.3333333333333333, 0.3333333333333333],
  [9400.0, 0.3333333333333333, 0.5],
  [5500.0, 0.5, 0.25],
  [3300.0, 0.25, 0.3333333333333333],
  [2700.0, 0.3333333333333333, 0.25],
  [9800.0, 0.25, 0.3333333333333333],
  [3400.0, 0.3333333333333333, 0.25],
  [3100.0, 0.25, 0.2857142857142857],
  [9000.0, 0.2857142857142857, 0.25],
  [2200.0, 0.25, 0.3333333333333333],
  [13700.0, 0.3333333333333333, 0.25],
  [1600.0, 0.25, 0.2],
  [900.0, 0.2, 0.5],
  [9900.0, 0.5, 0.25],
  [9600.0, 0.25, 0.3333333333333333],
  [1800.0, 0.3333333333333333, 0.25],
  [1100.0, 0.25, 0.3333333333333333],
  [2100.0, 0.3333333333333333, 0.3],
  [1700.0, 0.3, 0.25],
  [6900.0, 0.25, 0.25],
  [3600.0, 0.25, 0.1],
  [2600.0, 0.1, 0.2],
  [6000.0, 0.2, 0.08333333333333333],
  [2900.0, 0.08333333333333333, 0.35714285714285715],
  [1800.0, 0.35714285714285715, 0.25],
  [7600.0, 0.25, 0.25],
  [14200.0, 0.25, 0.3333333333333333],
  [5100.0, 0.3333333333333333, 0.3333333333333333],
  [7600.0, 0.3333333333333333, 0.3333333333333333],
  [2200.0, 0.3333333333333333, 0.2857142857142857],
  [1900.0, 0.2857142857142857, 0.3333333333333333],
  [1600.0, 0.3333333333333333, 0.2],
  [4600.0, 0.2, 0.5],
  [2200.0, 0.5, 0.2857142857142857],
  [2800.0, 0.2857142857142857, 0.3333333333333333],
  [1500.0, 0.3333333333333333, 0.3333333333333333],
  [1600.0, 0.3333333333333333, 0.2],
  [900.0, 0.2, 0.5],
  [18300.0, 0.5, 0.3333333333333333],
  [6900.0, 0.3333333333333333, 0.38461538461538464],
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
