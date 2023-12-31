[
  [19600.0, 0.0, 0.0],
  [18100.0, 0.0, 0.21428571428571427],
  [63300.0, 0.21428571428571427, 0.2],
  [60500.0, 0.2, 0.08333333333333333],
  [12300.0, 0.08333333333333333, 0.16666666666666666],
  [70900.0, 0.16666666666666666, 0.1],
  [2100.0, 0.1, 0.25],
  [11000.0, 0.25, 0.3333333333333333],
  [15200.0, 0.3333333333333333, 0.21428571428571427],
  [62600.0, 0.21428571428571427, 0.25],
  [33200.0, 0.25, 0.125],
  [39600.0, 0.125, 0.21428571428571427],
  [56400.0, 0.21428571428571427, 0.375],
  [11300.0, 0.375, 0.21428571428571427],
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
