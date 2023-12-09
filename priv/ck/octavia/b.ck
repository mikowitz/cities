[
  [4000.0, 0.0, 0.0],
  [14700.0, 0.0, 0.07142857142857142],
  [11800.0, 0.07142857142857142, 0.5],
  [15900.0, 0.5, 0.07142857142857142],
  [51700.0, 0.07142857142857142, 0.1],
  [38000.0, 0.1, 0.1],
  [41300.0, 0.1, 0.16666666666666666],
  [34500.0, 0.16666666666666666, 0.1],
  [8300.0, 0.1, 0.07142857142857142],
  [21100.0, 0.07142857142857142, 0.18181818181818182],
  [22700.0, 0.18181818181818182, 0.3],
  [8500.0, 0.3, 0.2],
  [29200.0, 0.2, 0.22727272727272727],
] @=> float fades[][];

Gain g => dac;
0.0 => g.gain;

SinOsc s => Pan2 p => g;
-0.85 => p.pan;
200.0 => s.freq;

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
