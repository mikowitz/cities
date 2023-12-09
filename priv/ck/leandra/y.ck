[
  [9500.0, 0.0, 0.0],
  [8500.0, 0.0, 0.2],
  [43100.0, 0.2, 0.2],
  [24900.0, 0.2, 0.2],
  [4900.0, 0.2, 0.15],
  [9900.0, 0.15, 0.2],
  [14800.0, 0.2, 0.2],
  [6600.0, 0.2, 0.2],
  [11000.0, 0.2, 0.2],
  [8100.0, 0.2, 0.2],
  [1200.0, 0.2, 0.2],
  [14200.0, 0.2, 0.2],
  [3700.0, 0.2, 0.2],
  [23400.0, 0.2, 0.2],
  [16200.0, 0.2, 0.2],
  [12400.0, 0.2, 0.2],
  [17500.0, 0.2, 0.2],
  [46400.0, 0.2, 0.2],
  [1100.0, 0.2, 0.2],
  [12400.0, 0.2, 0.2],
  [7800.0, 0.2, 0.2],
  [22100.0, 0.2, 0.2],
  [5200.0, 0.2, 0.2],
  [8500.0, 0.2, 0.2],
  [1200.0, 0.2, 0.2],
  [6400.0, 0.2, 0.2],
  [7300.0, 0.2, 0.2],
  [1600.0, 0.2, 0.2],
  [10600.0, 0.2, 0.04],
  [68200.0, 0.04, 0.06666666666666667],
  [53000.0, 0.06666666666666667, 0.125],
  [4100.0, 0.125, 0.2],
  [5000.0, 0.2, 0.16],
  [5000.0, 0.16, 0.2],
  [3700.0, 0.2, 0.05],
  [3000.0, 0.05, 0.2],
  [9700.0, 0.2, 0.2],
  [17300.0, 0.2, 0.2],
  [67300.0, 0.2, 0.2],
  [19900.0, 0.2, 0.2],
  [5400.0, 0.2, 0.2],
  [1200.0, 0.2, 0.2],
  [1000.0, 0.2, 0.2],
  [34000.0, 0.2, 0.16666666666666669],
  [30300.0, 0.16666666666666669, 0.2],
  [2500.0, 0.2, 0.2],
  [5400.0, 0.2, 0.2],
  [600.0, 0.2, 0.2],
  [16500.0, 0.2, 0.075],
  [38100.0, 0.075, 0.2],
  [6700.0, 0.2, 0.06666666666666667],
  [2700.0, 0.06666666666666667, 0.2],
  [3900.0, 0.2, 0.2],
  [22300.0, 0.2, 0.06666666666666667],
  [32900.0, 0.06666666666666667, 0.2],
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
