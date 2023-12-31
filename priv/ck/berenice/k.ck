[
  [130500.0, 0.0, 0.0],
  [27300.0, 0.0, 0.0303030303030303],
  [5200.0, 0.0303030303030303, 0.051948051948051945],
  [28900.0, 0.051948051948051945, 0.09090909090909091],
  [23200.0, 0.09090909090909091, 0.06818181818181818],
  [151600.0, 0.06818181818181818, 0.051948051948051945],
  [71800.0, 0.051948051948051945, 0.056818181818181816],
  [58200.0, 0.056818181818181816, 0.0606060606060606],
  [302900.0, 0.0606060606060606, 0.012987012987012986],
  [97700.0, 0.012987012987012986, 0.0404040404040404],
  [152900.0, 0.0404040404040404, 0.06818181818181818],
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
