[
  [2500.0, 0.0, 0.0],
  [1900.0, 0.0, 0.14285714285714285],
  [26500.0, 0.14285714285714285, 0.07142857142857142],
  [70100.0, 0.07142857142857142, 0.14285714285714285],
  [6900.0, 0.14285714285714285, 0.05],
  [45000.0, 0.05, 0.125],
  [2200.0, 0.125, 0.07142857142857142],
  [55300.0, 0.07142857142857142, 0.42857142857142855],
  [8800.0, 0.42857142857142855, 0.1],
  [11100.0, 0.1, 0.3],
  [12900.0, 0.3, 0.1],
  [9300.0, 0.1, 0.14285714285714285],
  [30100.0, 0.14285714285714285, 0.07142857142857142],
  [4100.0, 0.07142857142857142, 0.07142857142857142],
  [30100.0, 0.07142857142857142, 0.07142857142857142],
  [1200.0, 0.07142857142857142, 0.1],
  [28000.0, 0.1, 0.3],
  [22300.0, 0.3, 0.05],
  [7000.0, 0.05, 0.2],
  [15400.0, 0.2, 0.07142857142857142],
  [10200.0, 0.07142857142857142, 0.125],
  [4600.0, 0.125, 0.07142857142857142],
  [25600.0, 0.07142857142857142, 0.1],
  [19400.0, 0.1, 0.07142857142857142],
  [26300.0, 0.07142857142857142, 0.2727272727272727],
  [46900.0, 0.2727272727272727, 0.07142857142857142],
  [3000.0, 0.07142857142857142, 0.07142857142857142],
  [6800.0, 0.07142857142857142, 0.2222222222222222],
  [44000.0, 0.2222222222222222, 0.13636363636363635],
  [21500.0, 0.13636363636363635, 0.125],
  [11500.0, 0.125, 0.16666666666666666],
  [300.0, 0.16666666666666666, 0.21428571428571427],
  [19900.0, 0.21428571428571427, 0.2857142857142857],
  [8500.0, 0.2857142857142857, 0.07142857142857142],
  [500.0, 0.07142857142857142, 0.08333333333333333],
  [6800.0, 0.08333333333333333, 0.3333333333333333],
  [13300.0, 0.3333333333333333, 0.3235294117647059],
  [56800.0, 0.3235294117647059, 0.125],
  [1300.0, 0.125, 0.5],
  [41100.0, 0.5, 0.07142857142857142],
  [33600.0, 0.07142857142857142, 0.15],
  [27600.0, 0.15, 0.3333333333333333],
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