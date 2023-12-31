[
  [6000.0, 0.0, 0.0],
  [5200.0, 0.0, 0.1],
  [6200.0, 0.1, 0.11428571428571428],
  [6500.0, 0.11428571428571428, 0.14285714285714285],
  [6500.0, 0.14285714285714285, 0.13333333333333333],
  [1300.0, 0.13333333333333333, 0.08],
  [2400.0, 0.08, 0.2],
  [35900.0, 0.2, 0.14285714285714285],
  [2900.0, 0.14285714285714285, 0.13999999999999999],
  [7700.0, 0.13999999999999999, 0.08571428571428572],
  [12200.0, 0.08571428571428572, 0.04444444444444444],
  [300.0, 0.04444444444444444, 0.2],
  [3600.0, 0.2, 0.08],
  [9000.0, 0.08, 0.08],
  [9000.0, 0.08, 0.04],
  [600.0, 0.04, 0.2],
  [100.0, 0.2, 0.1],
  [3400.0, 0.1, 0.13333333333333333],
  [3600.0, 0.13333333333333333, 0.12],
  [7700.0, 0.12, 0.14285714285714285],
  [14900.0, 0.14285714285714285, 0.1],
  [3800.0, 0.1, 0.14285714285714285],
  [5200.0, 0.14285714285714285, 0.15555555555555556],
  [6300.0, 0.15555555555555556, 0.1],
  [8000.0, 0.1, 0.06666666666666667],
  [2200.0, 0.06666666666666667, 0.17777777777777776],
  [6000.0, 0.17777777777777776, 0.04444444444444444],
  [10800.0, 0.04444444444444444, 0.08],
  [4700.0, 0.08, 0.14285714285714285],
  [14900.0, 0.14285714285714285, 0.06666666666666667],
  [7100.0, 0.06666666666666667, 0.06666666666666667],
  [2800.0, 0.06666666666666667, 0.08],
  [6600.0, 0.08, 0.2],
  [11200.0, 0.2, 0.13333333333333333],
  [2500.0, 0.13333333333333333, 0.1],
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
