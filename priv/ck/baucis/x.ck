[
  [142900.0, 0.0, 0.0],
  [90600.0, 0.0, 0.1111111111111111],
  [22100.0, 0.1111111111111111, 0.09523809523809523],
  [32500.0, 0.09523809523809523, 0.07407407407407407],
] @=> float fades[][];

Gain g => dac;
0.0 => g.gain;

SinOsc s => Pan2 p => g;
0.78 => p.pan;
2400.0 => s.freq;

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
