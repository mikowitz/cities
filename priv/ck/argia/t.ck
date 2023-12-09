[
  [900.0, 0.0, 0.0],
  [8100.0, 0.0, 0.2],
  [2300.0, 0.2, 0.2],
  [3200.0, 0.2, 0.08],
  [2900.0, 0.08, 0.1],
  [1100.0, 0.1, 0.05],
  [1300.0, 0.05, 0.2],
  [2800.0, 0.2, 0.2],
  [2800.0, 0.2, 0.16],
  [3400.0, 0.16, 0.11428571428571428],
  [1300.0, 0.11428571428571428, 0.06666666666666667],
  [1700.0, 0.06666666666666667, 0.05714285714285714],
  [3400.0, 0.05714285714285714, 0.17142857142857143],
  [3800.0, 0.17142857142857143, 0.13999999999999999],
  [3100.0, 0.13999999999999999, 0.15],
  [2400.0, 0.15, 0.2],
  [3000.0, 0.2, 0.06666666666666667],
  [500.0, 0.06666666666666667, 0.1],
  [7300.0, 0.1, 0.06666666666666667],
  [3600.0, 0.06666666666666667, 0.08],
  [2400.0, 0.08, 0.11428571428571428],
  [4800.0, 0.11428571428571428, 0.05],
  [3600.0, 0.05, 0.2],
  [2900.0, 0.2, 0.125],
  [3100.0, 0.125, 0.06666666666666667],
  [9300.0, 0.06666666666666667, 0.06666666666666667],
  [8800.0, 0.06666666666666667, 0.02857142857142857],
  [4100.0, 0.02857142857142857, 0.15],
  [2700.0, 0.15, 0.2],
  [4500.0, 0.2, 0.06666666666666667],
  [1300.0, 0.06666666666666667, 0.12727272727272726],
  [3900.0, 0.12727272727272726, 0.18181818181818182],
  [400.0, 0.18181818181818182, 0.2],
  [2100.0, 0.2, 0.06666666666666667],
  [4900.0, 0.06666666666666667, 0.15],
  [2800.0, 0.15, 0.06666666666666667],
  [4300.0, 0.06666666666666667, 0.02857142857142857],
  [7300.0, 0.02857142857142857, 0.06666666666666667],
  [700.0, 0.06666666666666667, 0.16],
  [1800.0, 0.16, 0.04],
  [400.0, 0.04, 0.2],
  [4100.0, 0.2, 0.06666666666666667],
  [6500.0, 0.06666666666666667, 0.1],
  [3500.0, 0.1, 0.05],
  [700.0, 0.05, 0.2],
  [2900.0, 0.2, 0.05],
  [5000.0, 0.05, 0.175],
  [400.0, 0.175, 0.1],
  [8000.0, 0.1, 0.13333333333333333],
  [6600.0, 0.13333333333333333, 0.08],
  [8800.0, 0.08, 0.2],
  [11600.0, 0.2, 0.08571428571428572],
  [2800.0, 0.08571428571428572, 0.13333333333333333],
  [7700.0, 0.13333333333333333, 0.04],
  [1400.0, 0.04, 0.05],
  [5000.0, 0.05, 0.06666666666666667],
  [900.0, 0.06666666666666667, 0.15],
  [3100.0, 0.15, 0.2],
  [1500.0, 0.2, 0.2],
  [400.0, 0.2, 0.08571428571428572],
  [6200.0, 0.08571428571428572, 0.11428571428571428],
  [500.0, 0.11428571428571428, 0.1],
  [7600.0, 0.1, 0.06666666666666667],
  [6800.0, 0.06666666666666667, 0.11111111111111112],
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