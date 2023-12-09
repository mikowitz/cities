[
  [200.0, 0.0, 0.0],
  [3500.0, 0.0, 0.05714285714285714],
  [1200.0, 0.05714285714285714, 0.12],
  [2900.0, 0.12, 0.2],
  [100.0, 0.2, 0.1],
  [5900.0, 0.1, 0.12],
  [100.0, 0.12, 0.16],
  [4100.0, 0.16, 0.2],
  [100.0, 0.2, 0.2],
  [3200.0, 0.2, 0.05],
  [12200.0, 0.05, 0.08],
  [1900.0, 0.08, 0.16666666666666669],
  [2800.0, 0.16666666666666669, 0.16],
  [2200.0, 0.16, 0.2],
  [2200.0, 0.2, 0.17142857142857143],
  [3100.0, 0.17142857142857143, 0.2],
  [100.0, 0.2, 0.11428571428571428],
  [1400.0, 0.11428571428571428, 0.14285714285714285],
  [2500.0, 0.14285714285714285, 0.16],
  [4200.0, 0.16, 0.1],
  [700.0, 0.1, 0.08571428571428572],
  [2500.0, 0.08571428571428572, 0.17142857142857143],
  [4900.0, 0.17142857142857143, 0.16666666666666669],
  [7200.0, 0.16666666666666669, 0.05],
  [2700.0, 0.05, 0.16],
  [400.0, 0.16, 0.12],
  [400.0, 0.12, 0.2],
  [2400.0, 0.2, 0.05],
  [3400.0, 0.05, 0.175],
  [1000.0, 0.175, 0.11428571428571428],
  [5600.0, 0.11428571428571428, 0.2],
  [6000.0, 0.2, 0.2],
  [100.0, 0.2, 0.1],
  [1700.0, 0.1, 0.15],
  [3900.0, 0.15, 0.15],
  [3600.0, 0.15, 0.16],
  [2800.0, 0.16, 0.16666666666666669],
  [700.0, 0.16666666666666669, 0.2],
  [10900.0, 0.2, 0.08571428571428572],
  [5600.0, 0.08571428571428572, 0.2],
  [1300.0, 0.2, 0.17142857142857143],
  [1200.0, 0.17142857142857143, 0.12],
  [1400.0, 0.12, 0.2],
  [800.0, 0.2, 0.04444444444444444],
  [800.0, 0.04444444444444444, 0.11111111111111112],
  [1200.0, 0.11111111111111112, 0.17777777777777776],
  [200.0, 0.17777777777777776, 0.02857142857142857],
  [3700.0, 0.02857142857142857, 0.08571428571428572],
  [1700.0, 0.08571428571428572, 0.15],
  [2300.0, 0.15, 0.2],
  [6700.0, 0.2, 0.2],
  [3200.0, 0.2, 0.17142857142857143],
  [4500.0, 0.17142857142857143, 0.2],
  [3000.0, 0.2, 0.18333333333333332],
  [2700.0, 0.18333333333333332, 0.2],
  [2500.0, 0.2, 0.17142857142857143],
  [1600.0, 0.17142857142857143, 0.2],
  [3100.0, 0.2, 0.2],
  [5800.0, 0.2, 0.2],
  [2700.0, 0.2, 0.05714285714285714],
  [3500.0, 0.05714285714285714, 0.2],
  [2300.0, 0.2, 0.2],
  [4300.0, 0.2, 0.16],
  [300.0, 0.16, 0.2],
  [100.0, 0.2, 0.08],
  [600.0, 0.08, 0.12],
  [4600.0, 0.12, 0.05],
  [2200.0, 0.05, 0.2],
  [1200.0, 0.2, 0.05714285714285714],
  [200.0, 0.05714285714285714, 0.14285714285714285],
  [1000.0, 0.14285714285714285, 0.2],
  [1100.0, 0.2, 0.15],
  [1100.0, 0.15, 0.2],
  [400.0, 0.2, 0.2],
  [1500.0, 0.2, 0.06666666666666667],
  [1300.0, 0.06666666666666667, 0.2],
  [1200.0, 0.2, 0.16],
  [200.0, 0.16, 0.02857142857142857],
  [4100.0, 0.02857142857142857, 0.08571428571428572],
  [10800.0, 0.08571428571428572, 0.06666666666666667],
  [500.0, 0.06666666666666667, 0.15],
  [1200.0, 0.15, 0.1],
  [4800.0, 0.1, 0.2],
  [100.0, 0.2, 0.2],
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