[
  [4200.0, 0.0, 0.0],
  [1000.0, 0.0, 0.2],
  [8300.0, 0.2, 0.1],
  [500.0, 0.1, 0.1],
  [1200.0, 0.1, 0.05],
  [1500.0, 0.05, 0.1],
  [4400.0, 0.1, 0.13333333333333333],
  [6800.0, 0.13333333333333333, 0.1],
  [5500.0, 0.1, 0.06666666666666667],
  [15700.0, 0.06666666666666667, 0.15],
  [12100.0, 0.15, 0.1],
  [1400.0, 0.1, 0.1],
  [3600.0, 0.1, 0.12],
  [10000.0, 0.12, 0.1],
  [11200.0, 0.1, 0.12],
  [16000.0, 0.12, 0.2],
  [28300.0, 0.2, 0.06666666666666667],
  [8400.0, 0.06666666666666667, 0.1],
  [2100.0, 0.1, 0.06666666666666667],
  [300.0, 0.06666666666666667, 0.1],
  [17800.0, 0.1, 0.04],
  [100.0, 0.04, 0.1],
  [5400.0, 0.1, 0.15],
  [2800.0, 0.15, 0.08],
  [800.0, 0.08, 0.05],
  [400.0, 0.05, 0.1],
  [4000.0, 0.1, 0.15],
  [3800.0, 0.15, 0.175],
  [1900.0, 0.175, 0.175],
  [2200.0, 0.175, 0.13333333333333333],
  [5000.0, 0.13333333333333333, 0.1],
  [3900.0, 0.1, 0.13333333333333333],
  [2700.0, 0.13333333333333333, 0.1],
  [6400.0, 0.1, 0.15],
  [8100.0, 0.15, 0.13333333333333333],
  [3300.0, 0.13333333333333333, 0.13333333333333333],
  [14600.0, 0.13333333333333333, 0.12],
  [2100.0, 0.12, 0.1],
  [10400.0, 0.1, 0.13333333333333333],
  [500.0, 0.13333333333333333, 0.2],
  [100.0, 0.2, 0.1],
  [14700.0, 0.1, 0.15],
  [1800.0, 0.15, 0.08],
  [1300.0, 0.08, 0.06666666666666667],
  [6000.0, 0.06666666666666667, 0.05714285714285714],
  [8500.0, 0.05714285714285714, 0.1],
  [5500.0, 0.1, 0.12],
  [6400.0, 0.12, 0.06666666666666667],
  [6900.0, 0.06666666666666667, 0.08],
  [100.0, 0.08, 0.06666666666666667],
  [800.0, 0.06666666666666667, 0.1],
  [10800.0, 0.1, 0.13333333333333333],
  [2900.0, 0.13333333333333333, 0.05],
  [2300.0, 0.05, 0.1],
  [10300.0, 0.1, 0.15],
  [7800.0, 0.15, 0.1],
  [300.0, 0.1, 0.05714285714285714],
  [13600.0, 0.05714285714285714, 0.11428571428571428],
  [5700.0, 0.11428571428571428, 0.13333333333333333],
  [1000.0, 0.13333333333333333, 0.12],
  [10300.0, 0.12, 0.05],
  [7900.0, 0.05, 0.06666666666666667],
  [500.0, 0.06666666666666667, 0.05],
  [6800.0, 0.05, 0.125],
  [300.0, 0.125, 0.2],
  [13900.0, 0.2, 0.03636363636363636],
  [3900.0, 0.03636363636363636, 0.06666666666666667],
  [2100.0, 0.06666666666666667, 0.13333333333333333],
  [5000.0, 0.13333333333333333, 0.15],
  [1200.0, 0.15, 0.05],
  [900.0, 0.05, 0.06666666666666667],
  [4300.0, 0.06666666666666667, 0.1],
  [2100.0, 0.1, 0.03333333333333333],
  [1800.0, 0.03333333333333333, 0.13333333333333333],
  [2700.0, 0.13333333333333333, 0.1],
  [5900.0, 0.1, 0.05714285714285714],
  [1200.0, 0.05714285714285714, 0.05],
  [1300.0, 0.05, 0.1],
] @=> float fades[][];

Gain g => dac;
0.0 => g.gain;

SinOsc s => Pan2 p => g;
0.11 => p.pan;
1500.0 => s.freq;

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