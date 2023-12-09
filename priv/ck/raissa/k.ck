[
  [21700.0, 0.0, 0.0],
  [52400.0, 0.0, 0.09090909090909091],
  [15800.0, 0.09090909090909091, 0.06818181818181818],
  [25400.0, 0.06818181818181818, 0.03305785123966942],
  [29700.0, 0.03305785123966942, 0.09090909090909091],
  [81600.0, 0.09090909090909091, 0.051948051948051945],
  [109500.0, 0.051948051948051945, 0.0606060606060606],
  [49900.0, 0.0606060606060606, 0.07692307692307693],
  [39700.0, 0.07692307692307693, 0.045454545454545456],
  [30800.0, 0.045454545454545456, 0.0606060606060606],
  [132400.0, 0.0606060606060606, 0.056818181818181816],
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
