[
  [36700.0, 0.0, 0.0],
  [59400.0, 0.0, 0.018181818181818184],
  [16800.0, 0.018181818181818184, 0.0606060606060606],
  [97600.0, 0.0606060606060606, 0.0606060606060606],
  [39900.0, 0.0606060606060606, 0.051948051948051945],
  [117700.0, 0.051948051948051945, 0.05454545454545454],
  [25300.0, 0.05454545454545454, 0.09090909090909091],
  [31200.0, 0.09090909090909091, 0.05454545454545454],
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
