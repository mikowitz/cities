[
  [457100.0, 0.0, 0.0],
  [84800.0, 0.0, 0.057692307692307696],
  [202800.0, 0.057692307692307696, 0.04807692307692308],
  [136300.0, 0.04807692307692308, 0.01282051282051282],
  [27700.0, 0.01282051282051282, 0.04807692307692308],
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
