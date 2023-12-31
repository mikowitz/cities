[
  [31200.0, 0.0, 0.0],
  [34300.0, 0.0, 0.16666666666666666],
  [15200.0, 0.16666666666666666, 0.16666666666666666],
  [44700.0, 0.16666666666666666, 0.2777777777777778],
  [15800.0, 0.2777777777777778, 0.22727272727272727],
  [7800.0, 0.22727272727272727, 0.125],
  [13400.0, 0.125, 0.5],
  [56100.0, 0.5, 0.3],
  [152900.0, 0.3, 0.5],
  [29600.0, 0.5, 0.25],
  [5000.0, 0.25, 0.5],
  [30000.0, 0.5, 0.125],
  [5200.0, 0.125, 0.3],
  [31800.0, 0.3, 0.22727272727272727],
  [62600.0, 0.22727272727272727, 0.25],
  [6900.0, 0.25, 0.16666666666666666],
] @=> float fades[][];

Gain g => dac;
0.0 => g.gain;

SinOsc s => Pan2 p => g;
-0.85 => p.pan;
200.0 => s.freq;

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
