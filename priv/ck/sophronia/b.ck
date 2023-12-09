[
  [78500.0, 0.0, 0.0],
  [31200.0, 0.0, 0.16666666666666666],
  [6600.0, 0.16666666666666666, 0.3333333333333333],
  [105900.0, 0.3333333333333333, 0.125],
  [115900.0, 0.125, 0.2857142857142857],
  [15800.0, 0.2857142857142857, 0.08333333333333333],
  [15700.0, 0.08333333333333333, 0.08333333333333333],
  [5200.0, 0.08333333333333333, 0.1],
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
