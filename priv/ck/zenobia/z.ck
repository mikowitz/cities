[
  [7500.0, 0.0, 0.0],
  [45700.0, 0.0, 0.010989010989010988],
  [101100.0, 0.010989010989010988, 0.019230769230769232],
  [98600.0, 0.019230769230769232, 0.009615384615384616],
  [21400.0, 0.009615384615384616, 0.010989010989010988],
  [25900.0, 0.010989010989010988, 0.010989010989010988],
  [62500.0, 0.010989010989010988, 0.010989010989010988],
  [101900.0, 0.010989010989010988, 0.010989010989010988],
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
