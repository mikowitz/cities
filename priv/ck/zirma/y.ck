[
  [14300.0, 0.0, 0.0],
  [35800.0, 0.0, 0.2],
  [21500.0, 0.2, 0.05454545454545454],
  [1500.0, 0.05454545454545454, 0.2],
  [23700.0, 0.2, 0.2],
  [700.0, 0.2, 0.2],
  [46300.0, 0.2, 0.06],
  [39400.0, 0.06, 0.2],
  [2300.0, 0.2, 0.2],
  [9500.0, 0.2, 0.2],
  [60100.0, 0.2, 0.1],
  [600.0, 0.1, 0.2],
  [16900.0, 0.2, 0.2],
  [1900.0, 0.2, 0.2],
  [14900.0, 0.2, 0.2],
  [4500.0, 0.2, 0.16],
  [29800.0, 0.16, 0.2],
  [19600.0, 0.2, 0.2],
  [16800.0, 0.2, 0.2],
  [6300.0, 0.2, 0.2],
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
