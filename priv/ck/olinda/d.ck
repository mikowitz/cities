[
  [3500.0, 0.0, 0.0],
  [14700.0, 0.0, 0.4166666666666667],
  [9500.0, 0.4166666666666667, 0.5],
  [13700.0, 0.5, 0.5],
  [15900.0, 0.5, 0.5],
  [22600.0, 0.5, 0.5],
  [35600.0, 0.5, 0.2857142857142857],
  [15700.0, 0.2857142857142857, 0.125],
  [21200.0, 0.125, 0.5],
  [11200.0, 0.5, 0.5],
  [19800.0, 0.5, 0.5],
  [9100.0, 0.5, 0.5],
  [4700.0, 0.5, 0.5],
  [3700.0, 0.5, 0.5],
  [2200.0, 0.5, 0.42857142857142855],
  [35400.0, 0.42857142857142855, 0.4166666666666667],
  [200.0, 0.4166666666666667, 0.3333333333333333],
  [25700.0, 0.3333333333333333, 0.5],
  [6200.0, 0.5, 0.5],
  [11300.0, 0.5, 0.3333333333333333],
  [11400.0, 0.3333333333333333, 0.5],
  [3000.0, 0.5, 0.5],
  [14400.0, 0.5, 0.1],
  [4800.0, 0.1, 0.5],
  [4300.0, 0.5, 0.5],
  [1700.0, 0.5, 0.4166666666666667],
  [2800.0, 0.4166666666666667, 0.5],
  [5400.0, 0.5, 0.5],
  [10800.0, 0.5, 0.5],
  [19400.0, 0.5, 0.5],
  [6700.0, 0.5, 0.35714285714285715],
  [10100.0, 0.35714285714285715, 0.2],
  [24000.0, 0.2, 0.5],
  [26800.0, 0.5, 0.5],
  [1200.0, 0.5, 0.4166666666666667],
  [2300.0, 0.4166666666666667, 0.5],
  [12600.0, 0.5, 0.5],
  [7100.0, 0.5, 0.4166666666666667],
  [1300.0, 0.4166666666666667, 0.21428571428571427],
  [200.0, 0.21428571428571427, 0.5],
  [13400.0, 0.5, 0.05],
  [9900.0, 0.05, 0.5],
  [1300.0, 0.5, 0.4166666666666667],
  [4000.0, 0.4166666666666667, 0.5],
  [4900.0, 0.5, 0.35714285714285715],
  [7000.0, 0.35714285714285715, 0.5],
  [18700.0, 0.5, 0.5],
  [12300.0, 0.5, 0.42857142857142855],
  [700.0, 0.42857142857142855, 0.5],
  [10000.0, 0.5, 0.07142857142857142],
  [1300.0, 0.07142857142857142, 0.4166666666666667],
  [9900.0, 0.4166666666666667, 0.5],
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
