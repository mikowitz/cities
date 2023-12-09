[
  [50200.0, 0.0, 0.0],
  [201100.0, 0.0, 0.038461538461538464],
  [140900.0, 0.038461538461538464, 0.02564102564102564],
  [48700.0, 0.02564102564102564, 0.02564102564102564],
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
