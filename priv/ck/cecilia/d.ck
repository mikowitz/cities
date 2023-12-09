[
  [47000.0, 0.0, 0.0],
  [10500.0, 0.0, 0.5],
  [4200.0, 0.5, 0.5],
  [42000.0, 0.5, 0.4166666666666667],
  [200.0, 0.4166666666666667, 0.5],
  [16700.0, 0.5, 0.07142857142857142],
  [3800.0, 0.07142857142857142, 0.5],
  [21400.0, 0.5, 0.5],
  [7300.0, 0.5, 0.375],
  [30600.0, 0.375, 0.5],
  [3000.0, 0.5, 0.5],
  [5300.0, 0.5, 0.2222222222222222],
  [7900.0, 0.2222222222222222, 0.25],
  [16400.0, 0.25, 0.5],
  [18500.0, 0.5, 0.045454545454545456],
  [6300.0, 0.045454545454545456, 0.4],
  [12000.0, 0.4, 0.3333333333333333],
  [600.0, 0.3333333333333333, 0.25],
  [33400.0, 0.25, 0.5],
  [10800.0, 0.5, 0.5],
  [7700.0, 0.5, 0.5],
  [3900.0, 0.5, 0.5],
  [1800.0, 0.5, 0.16666666666666666],
  [18800.0, 0.16666666666666666, 0.5],
  [10000.0, 0.5, 0.5],
  [2500.0, 0.5, 0.5],
  [11500.0, 0.5, 0.045454545454545456],
  [8800.0, 0.045454545454545456, 0.42857142857142855],
  [5000.0, 0.42857142857142855, 0.5],
  [20300.0, 0.5, 0.5],
  [22900.0, 0.5, 0.5],
  [4100.0, 0.5, 0.5],
  [5600.0, 0.5, 0.5],
  [10100.0, 0.5, 0.16666666666666666],
  [9300.0, 0.16666666666666666, 0.1111111111111111],
  [30800.0, 0.1111111111111111, 0.5],
  [3700.0, 0.5, 0.5],
  [15000.0, 0.5, 0.2222222222222222],
  [5200.0, 0.2222222222222222, 0.5],
  [4600.0, 0.5, 0.5],
  [9000.0, 0.5, 0.5],
  [2000.0, 0.5, 0.5],
  [9400.0, 0.5, 0.07142857142857142],
  [5900.0, 0.07142857142857142, 0.5],
  [8000.0, 0.5, 0.25],
  [7400.0, 0.25, 0.5],
  [1100.0, 0.5, 0.16666666666666666],
  [9200.0, 0.16666666666666666, 0.5],
  [1300.0, 0.5, 0.21428571428571427],
  [3700.0, 0.21428571428571427, 0.5],
  [5000.0, 0.5, 0.2916666666666667],
  [19700.0, 0.2916666666666667, 0.5],
  [4200.0, 0.5, 0.5],
  [11300.0, 0.5, 0.5],
  [8200.0, 0.5, 0.5],
  [2800.0, 0.5, 0.08333333333333333],
  [200.0, 0.08333333333333333, 0.5],
  [14600.0, 0.5, 0.08333333333333333],
  [26700.0, 0.08333333333333333, 0.5],
  [12200.0, 0.5, 0.5],
  [4200.0, 0.5, 0.5],
  [1600.0, 0.5, 0.5],
  [22400.0, 0.5, 0.5],
  [20500.0, 0.5, 0.3333333333333333],
  [200.0, 0.3333333333333333, 0.5],
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