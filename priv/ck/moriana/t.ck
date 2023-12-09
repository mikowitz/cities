[
  [5400.0, 0.0, 0.0],
  [10100.0, 0.0, 0.06666666666666667],
  [3000.0, 0.06666666666666667, 0.06666666666666667],
  [12100.0, 0.06666666666666667, 0.125],
  [2100.0, 0.125, 0.06666666666666667],
  [5400.0, 0.06666666666666667, 0.15],
  [2100.0, 0.15, 0.13333333333333333],
  [2400.0, 0.13333333333333333, 0.15555555555555556],
  [800.0, 0.15555555555555556, 0.12],
  [5100.0, 0.12, 0.01818181818181818],
  [2000.0, 0.01818181818181818, 0.2],
  [5000.0, 0.2, 0.06666666666666667],
  [1300.0, 0.06666666666666667, 0.2],
  [8100.0, 0.2, 0.13333333333333333],
  [5300.0, 0.13333333333333333, 0.13999999999999999],
  [3900.0, 0.13999999999999999, 0.17777777777777776],
  [1800.0, 0.17777777777777776, 0.15555555555555556],
  [3500.0, 0.15555555555555556, 0.15],
  [3000.0, 0.15, 0.13999999999999999],
  [13400.0, 0.13999999999999999, 0.13333333333333333],
  [10800.0, 0.13333333333333333, 0.06666666666666667],
  [8300.0, 0.06666666666666667, 0.15],
  [900.0, 0.15, 0.17142857142857143],
  [10200.0, 0.17142857142857143, 0.06666666666666667],
  [4100.0, 0.06666666666666667, 0.05],
  [5100.0, 0.05, 0.2],
  [8300.0, 0.2, 0.2],
  [1100.0, 0.2, 0.05],
  [1500.0, 0.05, 0.2],
  [3100.0, 0.2, 0.1],
  [9200.0, 0.1, 0.05],
  [13600.0, 0.05, 0.1],
  [14600.0, 0.1, 0.15],
  [3600.0, 0.15, 0.11428571428571428],
  [900.0, 0.11428571428571428, 0.2],
  [2200.0, 0.2, 0.12],
  [5400.0, 0.12, 0.17777777777777776],
  [3900.0, 0.17777777777777776, 0.11111111111111112],
  [7100.0, 0.11111111111111112, 0.15],
  [1400.0, 0.15, 0.15],
  [2500.0, 0.15, 0.2],
  [6800.0, 0.2, 0.05],
  [9400.0, 0.05, 0.15],
  [2900.0, 0.15, 0.05],
  [19700.0, 0.05, 0.08],
  [400.0, 0.08, 0.1],
  [6500.0, 0.1, 0.13333333333333333],
  [400.0, 0.13333333333333333, 0.2],
  [500.0, 0.2, 0.1],
  [1100.0, 0.1, 0.06666666666666667],
  [2100.0, 0.06666666666666667, 0.08],
  [2100.0, 0.08, 0.06666666666666667],
  [1800.0, 0.06666666666666667, 0.15],
  [1500.0, 0.15, 0.1],
  [6900.0, 0.1, 0.1],
  [2900.0, 0.1, 0.14545454545454545],
  [5100.0, 0.14545454545454545, 0.07272727272727272],
  [3400.0, 0.07272727272727272, 0.13333333333333333],
  [5700.0, 0.13333333333333333, 0.13333333333333333],
  [2300.0, 0.13333333333333333, 0.2],
  [1800.0, 0.2, 0.11428571428571428],
  [2200.0, 0.11428571428571428, 0.2],
  [4500.0, 0.2, 0.02222222222222222],
  [2900.0, 0.02222222222222222, 0.2],
  [9800.0, 0.2, 0.175],
  [3800.0, 0.175, 0.2],
  [6600.0, 0.2, 0.15],
  [8700.0, 0.15, 0.1],
  [4700.0, 0.1, 0.11428571428571428],
  [3400.0, 0.11428571428571428, 0.15555555555555556],
  [1500.0, 0.15555555555555556, 0.2],
  [2100.0, 0.2, 0.08],
] @=> float fades[][];

Gain g => dac;
0.0 => g.gain;

SinOsc s => Pan2 p => g;
0.48 => p.pan;
2000.0 => s.freq;

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