[
  [5200.0, 0.0, 0.0],
  [27400.0, 0.0, 0.056818181818181816],
  [30800.0, 0.056818181818181816, 0.06818181818181818],
  [164100.0, 0.06818181818181818, 0.07272727272727274],
  [15800.0, 0.07272727272727274, 0.045454545454545456],
  [11800.0, 0.045454545454545456, 0.07272727272727274],
  [15000.0, 0.07272727272727274, 0.06818181818181818],
  [20100.0, 0.06818181818181818, 0.07575757575757576],
  [28000.0, 0.07575757575757576, 0.03896103896103896],
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
