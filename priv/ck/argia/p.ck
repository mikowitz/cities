[
  [34600.0, 0.0, 0.0],
  [8700.0, 0.0, 0.2],
  [93500.0, 0.2, 0.1],
  [4400.0, 0.1, 0.25],
  [500.0, 0.25, 0.07142857142857142],
  [26100.0, 0.07142857142857142, 0.2857142857142857],
  [10800.0, 0.2857142857142857, 0.1],
  [27400.0, 0.1, 0.5],
  [8400.0, 0.5, 0.1],
  [22600.0, 0.1, 0.07142857142857142],
] @=> float fades[][];

Gain g => dac;
0.0 => g.gain;

SinOsc s => Pan2 p => g;
0.19 => p.pan;
1600.0 => s.freq;

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
