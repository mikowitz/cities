[
  [6800.0, 0.0, 0.0],
  [25100.0, 0.0, 0.2],
  [50800.0, 0.2, 0.2],
  [1200.0, 0.2, 0.1],
  [8700.0, 0.1, 0.1],
  [5400.0, 0.1, 0.2],
  [34800.0, 0.2, 0.1],
  [24400.0, 0.1, 0.2],
  [24800.0, 0.2, 0.1],
  [237600.0, 0.1, 0.04],
  [9200.0, 0.04, 0.075],
  [15100.0, 0.075, 0.13333333333333333],
  [29600.0, 0.13333333333333333, 0.2],
  [16700.0, 0.2, 0.2],
  [35200.0, 0.2, 0.2],
] @=> float fades[][];

Gain g => dac;
0.0 => g.gain;

SinOsc s => Pan2 p => g;
0.85 => p.pan;
2500.0 => s.freq;

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
