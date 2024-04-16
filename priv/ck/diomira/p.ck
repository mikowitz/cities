[
  [6100.0, 0.0, 0.0],
  [40500.0, 0.0, 0.025],
  [57000.0, 0.025, 0.05],
  [20800.0, 0.05, 0.07142857142857142],
  [26100.0, 0.07142857142857142, 0.08333333333333333],
  [64800.0, 0.08333333333333333, 0.2],
  [300.0, 0.2, 0.15],
  [3800.0, 0.15, 0.2],
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
