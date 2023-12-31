[
  [9300.0, 0.0, 0.0],
  [800.0, 0.0, 0.15],
  [3700.0, 0.15, 0.2],
  [3800.0, 0.2, 0.2],
  [2300.0, 0.2, 0.2],
  [28500.0, 0.2, 0.175],
  [24100.0, 0.175, 0.2],
  [30800.0, 0.2, 0.05454545454545454],
  [17500.0, 0.05454545454545454, 0.175],
  [15000.0, 0.175, 0.2],
  [20800.0, 0.2, 0.2],
  [7500.0, 0.2, 0.2],
  [154500.0, 0.2, 0.06666666666666667],
  [8700.0, 0.06666666666666667, 0.11428571428571428],
  [36000.0, 0.11428571428571428, 0.2],
  [17000.0, 0.2, 0.2],
  [63800.0, 0.2, 0.2],
  [11600.0, 0.2, 0.2],
  [34100.0, 0.2, 0.2],
  [5300.0, 0.2, 0.2],
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
