[
  [339400.0, 0.0, 0.0],
  [214000.0, 0.0, 0.06293706293706294],
  [176200.0, 0.06293706293706294, 0.057692307692307696],
  [521500.0, 0.057692307692307696, 0.06837606837606837],
  [142400.0, 0.06837606837606837, 0.04807692307692308],
] @=> float fades[][];

Gain g => dac;
0.0 => g.gain;

SinOsc s => Pan2 p => g;
0.93 => p.pan;
2600.0 => s.freq;

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
