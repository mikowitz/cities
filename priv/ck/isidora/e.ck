[
  [700.0, 0.0, 0.0],
  [4500.0, 0.0, 0.15],
  [3900.0, 0.15, 0.16],
  [6700.0, 0.16, 0.2],
  [3200.0, 0.2, 0.05714285714285714],
  [300.0, 0.05714285714285714, 0.2],
  [100.0, 0.2, 0.08],
  [1500.0, 0.08, 0.12],
  [300.0, 0.12, 0.2],
  [2400.0, 0.2, 0.06666666666666667],
  [6500.0, 0.06666666666666667, 0.2],
  [800.0, 0.2, 0.2],
  [7200.0, 0.2, 0.16],
  [1200.0, 0.16, 0.12],
  [1000.0, 0.12, 0.2],
  [5800.0, 0.2, 0.2],
  [6700.0, 0.2, 0.2],
  [400.0, 0.2, 0.18],
  [3600.0, 0.18, 0.02222222222222222],
  [5600.0, 0.02222222222222222, 0.17777777777777776],
  [1100.0, 0.17777777777777776, 0.04444444444444444],
  [1500.0, 0.04444444444444444, 0.13333333333333333],
  [1200.0, 0.13333333333333333, 0.12],
  [400.0, 0.12, 0.2],
  [1400.0, 0.2, 0.05714285714285714],
  [1100.0, 0.05714285714285714, 0.14285714285714285],
  [300.0, 0.14285714285714285, 0.04],
  [1000.0, 0.04, 0.08],
  [6000.0, 0.08, 0.18],
  [900.0, 0.18, 0.2],
  [800.0, 0.2, 0.2],
  [1200.0, 0.2, 0.12],
  [1000.0, 0.12, 0.2],
  [1500.0, 0.2, 0.2],
  [2300.0, 0.2, 0.08888888888888888],
  [1700.0, 0.08888888888888888, 0.17777777777777776],
  [4800.0, 0.17777777777777776, 0.04],
  [700.0, 0.04, 0.05714285714285714],
  [100.0, 0.05714285714285714, 0.14285714285714285],
  [2200.0, 0.14285714285714285, 0.17142857142857143],
  [2100.0, 0.17142857142857143, 0.16],
  [3000.0, 0.16, 0.02],
  [5500.0, 0.02, 0.16],
  [1200.0, 0.16, 0.12],
  [3900.0, 0.12, 0.2],
  [700.0, 0.2, 0.04],
  [800.0, 0.04, 0.08],
  [1800.0, 0.08, 0.12],
  [8500.0, 0.12, 0.2],
  [400.0, 0.2, 0.2],
  [2900.0, 0.2, 0.05714285714285714],
  [7500.0, 0.05714285714285714, 0.2],
  [400.0, 0.2, 0.12],
  [4200.0, 0.12, 0.2],
  [1300.0, 0.2, 0.15],
  [300.0, 0.15, 0.2],
  [2400.0, 0.2, 0.05714285714285714],
  [6800.0, 0.05714285714285714, 0.17142857142857143],
  [1200.0, 0.17142857142857143, 0.06666666666666667],
  [1500.0, 0.06666666666666667, 0.11111111111111112],
  [2200.0, 0.11111111111111112, 0.2],
  [5100.0, 0.2, 0.2],
  [3800.0, 0.2, 0.1],
  [1600.0, 0.1, 0.2],
  [1200.0, 0.2, 0.1],
  [1000.0, 0.1, 0.13999999999999999],
  [1000.0, 0.13999999999999999, 0.2],
  [1400.0, 0.2, 0.2],
  [700.0, 0.2, 0.06666666666666667],
  [5500.0, 0.06666666666666667, 0.13333333333333333],
  [7000.0, 0.13333333333333333, 0.17777777777777776],
  [3500.0, 0.17777777777777776, 0.2],
  [9300.0, 0.2, 0.17142857142857143],
  [2600.0, 0.17142857142857143, 0.2],
  [2700.0, 0.2, 0.2],
  [1000.0, 0.2, 0.2],
  [1200.0, 0.2, 0.12],
  [2200.0, 0.12, 0.2],
  [1600.0, 0.2, 0.2],
  [1200.0, 0.2, 0.12],
  [1000.0, 0.12, 0.2],
  [1000.0, 0.2, 0.2],
  [5900.0, 0.2, 0.13333333333333333],
  [4200.0, 0.13333333333333333, 0.2],
  [1600.0, 0.2, 0.2],
  [700.0, 0.2, 0.06666666666666667],
  [6400.0, 0.06666666666666667, 0.16666666666666669],
  [700.0, 0.16666666666666669, 0.15],
  [2400.0, 0.15, 0.05714285714285714],
  [1700.0, 0.05714285714285714, 0.17142857142857143],
  [1600.0, 0.17142857142857143, 0.2],
  [1100.0, 0.2, 0.11428571428571428],
  [2600.0, 0.11428571428571428, 0.05],
  [400.0, 0.05, 0.175],
] @=> float fades[][];

Gain g => dac;
0.0 => g.gain;

SinOsc s => Pan2 p => g;
-0.63 => p.pan;
500.0 => s.freq;

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