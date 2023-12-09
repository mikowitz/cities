[
  [1300.0, 0.0, 0.0],
  [1600.0, 0.0, 0.13333333333333333],
  [100.0, 0.13333333333333333, 0.1],
  [900.0, 0.1, 0.13333333333333333],
  [3000.0, 0.13333333333333333, 0.2],
  [100.0, 0.2, 0.1],
  [1000.0, 0.1, 0.15],
  [4100.0, 0.15, 0.13333333333333333],
  [300.0, 0.13333333333333333, 0.13333333333333333],
  [20600.0, 0.13333333333333333, 0.02857142857142857],
  [1700.0, 0.02857142857142857, 0.2],
  [8000.0, 0.2, 0.04444444444444444],
  [2500.0, 0.04444444444444444, 0.05],
  [1500.0, 0.05, 0.1],
  [2200.0, 0.1, 0.08],
  [1700.0, 0.08, 0.2],
  [5600.0, 0.2, 0.2],
  [7900.0, 0.2, 0.08],
  [1700.0, 0.08, 0.13333333333333333],
  [4200.0, 0.13333333333333333, 0.1],
  [100.0, 0.1, 0.06666666666666667],
  [6300.0, 0.06666666666666667, 0.1],
  [900.0, 0.1, 0.13333333333333333],
  [1100.0, 0.13333333333333333, 0.2],
  [2200.0, 0.2, 0.1],
  [100.0, 0.1, 0.1],
  [3100.0, 0.1, 0.15],
  [2600.0, 0.15, 0.05],
  [1400.0, 0.05, 0.1],
  [3900.0, 0.1, 0.13333333333333333],
  [7000.0, 0.13333333333333333, 0.2],
  [4400.0, 0.2, 0.16],
  [3400.0, 0.16, 0.05714285714285714],
  [10100.0, 0.05714285714285714, 0.13333333333333333],
  [2200.0, 0.13333333333333333, 0.1],
  [8400.0, 0.1, 0.1],
  [1200.0, 0.1, 0.1],
  [12800.0, 0.1, 0.13333333333333333],
  [3300.0, 0.13333333333333333, 0.04],
  [800.0, 0.04, 0.18],
  [14500.0, 0.18, 0.1],
  [7900.0, 0.1, 0.14285714285714285],
  [10300.0, 0.14285714285714285, 0.1],
  [1400.0, 0.1, 0.16],
  [4300.0, 0.16, 0.1],
  [1300.0, 0.1, 0.125],
  [5500.0, 0.125, 0.06666666666666667],
  [10400.0, 0.06666666666666667, 0.08571428571428572],
  [1000.0, 0.08571428571428572, 0.05],
  [3200.0, 0.05, 0.125],
  [8600.0, 0.125, 0.1],
  [10800.0, 0.1, 0.1],
  [9400.0, 0.1, 0.08571428571428572],
  [14600.0, 0.08571428571428572, 0.13333333333333333],
  [12900.0, 0.13333333333333333, 0.1],
  [6100.0, 0.1, 0.05],
  [300.0, 0.05, 0.1],
  [18500.0, 0.1, 0.025],
  [7100.0, 0.025, 0.04],
  [4000.0, 0.04, 0.15],
  [2600.0, 0.15, 0.05],
  [300.0, 0.05, 0.2],
  [1400.0, 0.2, 0.1],
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