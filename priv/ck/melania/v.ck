[
  [3400.0, 0.0, 0.0],
  [107000.0, 0.0, 0.03636363636363637],
  [55900.0, 0.03636363636363637, 0.051948051948051945],
  [35000.0, 0.051948051948051945, 0.06818181818181818],
  [2100.0, 0.06818181818181818, 0.051948051948051945],
  [104900.0, 0.051948051948051945, 0.06818181818181818],
  [31600.0, 0.06818181818181818, 0.06493506493506494],
  [29100.0, 0.06493506493506494, 0.06818181818181818],
  [7400.0, 0.06818181818181818, 0.06611570247933884],
  [27100.0, 0.06611570247933884, 0.05454545454545454],
  [10100.0, 0.05454545454545454, 0.045454545454545456],
  [7000.0, 0.045454545454545456, 0.018181818181818184],
  [194200.0, 0.018181818181818184, 0.045454545454545456],
  [34700.0, 0.045454545454545456, 0.045454545454545456],
  [17100.0, 0.045454545454545456, 0.08181818181818182],
  [4100.0, 0.08181818181818182, 0.045454545454545456],
  [21100.0, 0.045454545454545456, 0.05454545454545454],
] @=> float fades[][];

Gain g => dac;
0.0 => g.gain;

SinOsc s => Pan2 p => g;
0.63 => p.pan;
2200.0 => s.freq;

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