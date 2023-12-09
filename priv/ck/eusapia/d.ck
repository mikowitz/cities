[
  [9100.0, 0.0, 0.0],
  [9100.0, 0.0, 0.5],
  [3300.0, 0.5, 0.5],
  [7100.0, 0.5, 0.5],
  [17100.0, 0.5, 0.1],
  [2000.0, 0.1, 0.5],
  [10200.0, 0.5, 0.1111111111111111],
  [4700.0, 0.1111111111111111, 0.13636363636363635],
  [3200.0, 0.13636363636363635, 0.5],
  [2300.0, 0.5, 0.1],
  [14800.0, 0.1, 0.5],
  [9900.0, 0.5, 0.5],
  [200.0, 0.5, 0.5],
  [19100.0, 0.5, 0.125],
  [31000.0, 0.125, 0.5],
  [3100.0, 0.5, 0.5],
  [600.0, 0.5, 0.5],
  [4700.0, 0.5, 0.3],
  [1800.0, 0.3, 0.5],
  [9300.0, 0.5, 0.07142857142857142],
  [12500.0, 0.07142857142857142, 0.375],
  [1500.0, 0.375, 0.3333333333333333],
  [20700.0, 0.3333333333333333, 0.5],
  [13900.0, 0.5, 0.5],
  [22000.0, 0.5, 0.5],
  [3300.0, 0.5, 0.5],
  [23300.0, 0.5, 0.5],
  [9200.0, 0.5, 0.20833333333333334],
  [23300.0, 0.20833333333333334, 0.16666666666666666],
  [46000.0, 0.16666666666666666, 0.25],
  [1400.0, 0.25, 0.1],
  [20200.0, 0.1, 0.05555555555555555],
  [300.0, 0.05555555555555555, 0.35714285714285715],
  [21000.0, 0.35714285714285715, 0.5],
  [25400.0, 0.5, 0.05555555555555555],
  [8000.0, 0.05555555555555555, 0.5],
  [500.0, 0.5, 0.125],
  [200.0, 0.125, 0.5],
  [3000.0, 0.5, 0.125],
  [10300.0, 0.125, 0.5],
  [2700.0, 0.5, 0.07142857142857142],
  [5500.0, 0.07142857142857142, 0.5],
  [8200.0, 0.5, 0.5],
  [300.0, 0.5, 0.3333333333333333],
  [14400.0, 0.3333333333333333, 0.5],
  [500.0, 0.5, 0.125],
  [1100.0, 0.125, 0.5],
  [14500.0, 0.5, 0.5],
  [19300.0, 0.5, 0.5],
  [500.0, 0.5, 0.125],
  [1100.0, 0.125, 0.5],
  [8400.0, 0.5, 0.5],
  [1800.0, 0.5, 0.5],
  [1900.0, 0.5, 0.5],
  [300.0, 0.5, 0.3333333333333333],
  [6100.0, 0.3333333333333333, 0.5],
  [29700.0, 0.5, 0.1],
  [400.0, 0.1, 0.42857142857142855],
  [500.0, 0.42857142857142855, 0.125],
  [10500.0, 0.125, 0.5],
  [200.0, 0.5, 0.5],
  [42900.0, 0.5, 0.125],
  [6500.0, 0.125, 0.5],
  [8300.0, 0.5, 0.5],
  [500.0, 0.5, 0.125],
  [51000.0, 0.125, 0.5],
  [500.0, 0.5, 0.125],
  [8800.0, 0.125, 0.5],
  [13100.0, 0.5, 0.5],
  [8200.0, 0.5, 0.25],
  [300.0, 0.25, 0.3333333333333333],
  [13400.0, 0.3333333333333333, 0.5],
  [500.0, 0.5, 0.125],
  [18300.0, 0.125, 0.5],
  [4700.0, 0.5, 0.13636363636363635],
  [22100.0, 0.13636363636363635, 0.5],
  [500.0, 0.5, 0.125],
  [47600.0, 0.125, 0.5],
  [2200.0, 0.5, 0.5],
  [500.0, 0.5, 0.125],
  [200.0, 0.125, 0.5],
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
