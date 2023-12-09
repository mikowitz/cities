[
  [30400.0, 0.0, 0.0],
  [19500.0, 0.0, 0.09090909090909091],
  [10900.0, 0.09090909090909091, 0.01652892561983471],
  [32800.0, 0.01652892561983471, 0.051948051948051945],
  [3700.0, 0.051948051948051945, 0.09090909090909091],
  [67400.0, 0.09090909090909091, 0.018181818181818184],
  [59800.0, 0.018181818181818184, 0.09090909090909091],
  [85900.0, 0.09090909090909091, 0.045454545454545456],
  [56000.0, 0.045454545454545456, 0.06818181818181818],
] @=> float fades[][];

Gain g => dac;
0.0 => g.gain;

SinOsc s => Pan2 p => g;
-0.19 => p.pan;
1100.0 => s.freq;

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
