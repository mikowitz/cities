[
  [98600.0, 0.0, 0.0],
  [21300.0, 0.0, 0.06153846153846154],
  [85800.0, 0.06153846153846154, 0.057692307692307696],
  [345500.0, 0.057692307692307696, 0.057692307692307696],
  [30700.0, 0.057692307692307696, 0.06837606837606837],
  [62000.0, 0.06837606837606837, 0.057692307692307696],
  [10400.0, 0.057692307692307696, 0.06837606837606837],
  [117100.0, 0.06837606837606837, 0.06153846153846154],
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
