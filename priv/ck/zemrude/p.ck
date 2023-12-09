[
  [53400.0, 0.0, 0.0],
  [300.0, 0.0, 0.25],
  [32800.0, 0.25, 0.3125],
  [34100.0, 0.3125, 0.1],
  [500.0, 0.1, 0.3],
  [8500.0, 0.3, 0.4],
  [20300.0, 0.4, 0.25],
  [300.0, 0.25, 0.2],
  [99500.0, 0.2, 0.3],
  [1200.0, 0.3, 0.3],
  [23200.0, 0.3, 0.4],
  [50500.0, 0.4, 0.15],
] @=> float fades[][];

Gain g => dac;
0.0 => g.gain;

SinOsc s => Pan2 p => g;
0.19 => p.pan;
1600.0 => s.freq;

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
