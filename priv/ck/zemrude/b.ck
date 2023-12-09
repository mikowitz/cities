[
  [4700.0, 0.0, 0.0],
  [19100.0, 0.0, 0.0625],
  [10700.0, 0.0625, 0.25],
  [13200.0, 0.25, 0.08333333333333333],
  [49400.0, 0.08333333333333333, 0.1],
  [46200.0, 0.1, 0.25],
  [19700.0, 0.25, 0.16666666666666666],
  [48300.0, 0.16666666666666666, 0.375],
  [24600.0, 0.375, 0.08333333333333333],
  [27800.0, 0.08333333333333333, 0.1],
  [300.0, 0.1, 0.125],
  [12000.0, 0.125, 0.16666666666666666],
  [600.0, 0.16666666666666666, 0.4],
  [48000.0, 0.4, 0.16666666666666666],
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
