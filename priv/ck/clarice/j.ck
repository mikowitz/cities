[
  [439400.0, 0.0, 0.0],
  [53600.0, 0.0, 0.03333333333333333],
  [293600.0, 0.03333333333333333, 0.08571428571428572],
  [266000.0, 0.08571428571428572, 0.08571428571428572],
  [69000.0, 0.08571428571428572, 0.08571428571428572],
] @=> float fades[][];

Gain g => dac;
0.0 => g.gain;

SinOsc s => Pan2 p => g;
-0.26 => p.pan;
1000.0 => s.freq;

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