[
  [455900.0, 0.0, 0.0],
  [339900.0, 0.0, 0.01680672268907563],
  [27400.0, 0.01680672268907563, 0.029411764705882353],
  [91700.0, 0.029411764705882353, 0.0065359477124183],
  [478600.0, 0.0065359477124183, 0.029411764705882353],
] @=> float fades[][];

Gain g => dac;
0.0 => g.gain;

SinOsc s => Pan2 p => g;
0.26 => p.pan;
1700.0 => s.freq;

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
