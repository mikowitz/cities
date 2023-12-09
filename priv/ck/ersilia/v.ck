[
  [120500.0, 0.0, 0.0],
  [109200.0, 0.0, 0.07272727272727274],
  [49600.0, 0.07272727272727274, 0.07272727272727274],
  [18300.0, 0.07272727272727274, 0.07272727272727274],
  [76000.0, 0.07272727272727274, 0.0404040404040404],
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
