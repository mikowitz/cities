[
  [71100.0, 0.0, 0.0],
  [36900.0, 0.0, 0.012987012987012986],
  [14000.0, 0.012987012987012986, 0.03636363636363637],
  [32100.0, 0.03636363636363637, 0.018181818181818184],
  [8500.0, 0.018181818181818184, 0.07272727272727274],
  [48800.0, 0.07272727272727274, 0.06818181818181818],
  [49400.0, 0.06818181818181818, 0.08181818181818182],
  [69700.0, 0.08181818181818182, 0.01515151515151515],
  [60200.0, 0.01515151515151515, 0.06493506493506494],
  [41700.0, 0.06493506493506494, 0.045454545454545456],
  [32200.0, 0.045454545454545456, 0.06818181818181818],
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
