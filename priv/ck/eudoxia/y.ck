[
  [22200.0, 0.0, 0.0],
  [16200.0, 0.0, 0.16666666666666669],
  [6800.0, 0.16666666666666669, 0.06666666666666667],
  [36100.0, 0.06666666666666667, 0.16],
  [40700.0, 0.16, 0.03636363636363636],
  [26900.0, 0.03636363636363636, 0.2],
  [10800.0, 0.2, 0.06666666666666667],
  [200.0, 0.06666666666666667, 0.2],
  [24200.0, 0.2, 0.06666666666666667],
  [13900.0, 0.06666666666666667, 0.2],
  [34100.0, 0.2, 0.2],
  [2300.0, 0.2, 0.05],
  [4600.0, 0.05, 0.13333333333333333],
  [24300.0, 0.13333333333333333, 0.2],
  [28600.0, 0.2, 0.11428571428571428],
  [24500.0, 0.11428571428571428, 0.06666666666666667],
  [26700.0, 0.06666666666666667, 0.2],
  [9000.0, 0.2, 0.2],
  [9900.0, 0.2, 0.2],
  [12400.0, 0.2, 0.06666666666666667],
  [8500.0, 0.06666666666666667, 0.06666666666666667],
  [32000.0, 0.06666666666666667, 0.06666666666666667],
  [11700.0, 0.06666666666666667, 0.06666666666666667],
  [10100.0, 0.06666666666666667, 0.05],
  [30100.0, 0.05, 0.2],
  [28300.0, 0.2, 0.2],
  [18800.0, 0.2, 0.2],
  [23100.0, 0.2, 0.04],
  [23400.0, 0.04, 0.2],
  [700.0, 0.2, 0.2],
  [30500.0, 0.2, 0.2],
  [65200.0, 0.2, 0.2],
  [1700.0, 0.2, 0.2],
  [6800.0, 0.2, 0.06666666666666667],
  [24100.0, 0.06666666666666667, 0.2],
  [18400.0, 0.2, 0.2],
  [36000.0, 0.2, 0.2],
] @=> float fades[][];

Gain g => dac;
0.0 => g.gain;

SinOsc s => Pan2 p => g;
0.85 => p.pan;
2500.0 => s.freq;

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