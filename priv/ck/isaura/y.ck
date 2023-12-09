[
  [5000.0, 0.0, 0.0],
  [48200.0, 0.0, 0.2],
  [15700.0, 0.2, 0.2],
  [46900.0, 0.2, 0.2],
  [17400.0, 0.2, 0.1],
  [16000.0, 0.1, 0.2],
  [4000.0, 0.2, 0.2],
  [17400.0, 0.2, 0.2],
  [58100.0, 0.2, 0.16],
  [16600.0, 0.16, 0.2],
  [115800.0, 0.2, 0.17142857142857143],
  [15700.0, 0.17142857142857143, 0.2],
  [9800.0, 0.2, 0.2],
  [6200.0, 0.2, 0.2],
  [3000.0, 0.2, 0.2],
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
