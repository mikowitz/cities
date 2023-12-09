[
  [35900.0, 0.0, 0.0],
  [7200.0, 0.0, 0.2],
  [11700.0, 0.2, 0.2],
  [9500.0, 0.2, 0.2],
  [16900.0, 0.2, 0.2],
  [3600.0, 0.2, 0.1],
  [28400.0, 0.1, 0.2],
  [27500.0, 0.2, 0.2],
  [5900.0, 0.2, 0.175],
  [8400.0, 0.175, 0.2],
  [16000.0, 0.2, 0.125],
  [600.0, 0.125, 0.1],
  [20400.0, 0.1, 0.2],
  [9600.0, 0.2, 0.2],
  [16900.0, 0.2, 0.2],
  [8600.0, 0.2, 0.05],
  [9900.0, 0.05, 0.06666666666666667],
] @=> float fades[][];

Gain g => dac;
0.0 => g.gain;

SinOsc s => Pan2 p => g;
0.85 => p.pan;
2500.0 => s.freq;

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
