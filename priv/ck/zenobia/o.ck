[
  [700.0, 0.0, 0.0],
  [3500.0, 0.0, 0.13333333333333333],
  [3000.0, 0.13333333333333333, 0.1],
  [1300.0, 0.1, 0.1],
  [5200.0, 0.1, 0.11428571428571428],
  [9200.0, 0.11428571428571428, 0.04444444444444444],
  [1700.0, 0.04444444444444444, 0.17142857142857143],
  [2800.0, 0.17142857142857143, 0.1],
  [10200.0, 0.1, 0.1],
  [9800.0, 0.1, 0.1],
  [3000.0, 0.1, 0.06666666666666667],
  [1500.0, 0.06666666666666667, 0.1],
  [100.0, 0.1, 0.16666666666666669],
  [8000.0, 0.16666666666666669, 0.2],
  [3900.0, 0.2, 0.13333333333333333],
  [3300.0, 0.13333333333333333, 0.11111111111111112],
  [6200.0, 0.11111111111111112, 0.1],
  [5800.0, 0.1, 0.14285714285714285],
  [2900.0, 0.14285714285714285, 0.075],
  [1800.0, 0.075, 0.06666666666666667],
  [17800.0, 0.06666666666666667, 0.08571428571428572],
  [3000.0, 0.08571428571428572, 0.1],
  [2000.0, 0.1, 0.04],
  [100.0, 0.04, 0.12],
  [7200.0, 0.12, 0.13999999999999999],
  [19000.0, 0.13999999999999999, 0.08571428571428572],
  [5100.0, 0.08571428571428572, 0.08],
  [100.0, 0.08, 0.2],
  [7200.0, 0.2, 0.06666666666666667],
  [1400.0, 0.06666666666666667, 0.1],
  [2000.0, 0.1, 0.05714285714285714],
  [5200.0, 0.05714285714285714, 0.1],
  [1300.0, 0.1, 0.12],
  [2000.0, 0.12, 0.1],
  [3700.0, 0.1, 0.05],
  [8800.0, 0.05, 0.2],
  [3000.0, 0.2, 0.1],
  [4200.0, 0.1, 0.2],
  [17800.0, 0.2, 0.2],
  [8500.0, 0.2, 0.08],
  [3000.0, 0.08, 0.12],
  [9500.0, 0.12, 0.11428571428571428],
  [2600.0, 0.11428571428571428, 0.1125],
  [2400.0, 0.1125, 0.175],
  [5100.0, 0.175, 0.15],
  [19000.0, 0.15, 0.13333333333333333],
  [7700.0, 0.13333333333333333, 0.13333333333333333],
  [1300.0, 0.13333333333333333, 0.1],
  [1900.0, 0.1, 0.11428571428571428],
  [7200.0, 0.11428571428571428, 0.2],
  [800.0, 0.2, 0.16666666666666669],
  [11500.0, 0.16666666666666669, 0.1],
  [25900.0, 0.1, 0.11428571428571428],
  [23100.0, 0.11428571428571428, 0.11428571428571428],
  [7300.0, 0.11428571428571428, 0.14285714285714285],
  [6900.0, 0.14285714285714285, 0.04444444444444444],
  [5100.0, 0.04444444444444444, 0.1],
  [7100.0, 0.1, 0.08],
  [7300.0, 0.08, 0.04444444444444444],
  [5700.0, 0.04444444444444444, 0.2],
  [3100.0, 0.2, 0.11428571428571428],
  [4600.0, 0.11428571428571428, 0.2],
  [5700.0, 0.2, 0.12],
  [1800.0, 0.12, 0.1],
  [8600.0, 0.1, 0.12],
  [2000.0, 0.12, 0.2],
  [7300.0, 0.2, 0.2],
  [2100.0, 0.2, 0.2],
  [9200.0, 0.2, 0.2],
  [1000.0, 0.2, 0.2],
  [2800.0, 0.2, 0.08571428571428572],
  [1000.0, 0.08571428571428572, 0.2],
  [4000.0, 0.2, 0.12],
  [9800.0, 0.12, 0.11428571428571428],
  [4100.0, 0.11428571428571428, 0.05],
  [5000.0, 0.05, 0.2],
  [2300.0, 0.2, 0.08],
  [5100.0, 0.08, 0.2],
  [15000.0, 0.2, 0.12],
  [6400.0, 0.12, 0.1],
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