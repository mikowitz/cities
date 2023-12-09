[
  [352200.0, 0.0, 0.0],
  [95500.0, 0.0, 0.04615384615384615],
  [81500.0, 0.04615384615384615, 0.057692307692307696],
  [252000.0, 0.057692307692307696, 0.05128205128205128],
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
