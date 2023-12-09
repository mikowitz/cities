[
  [16500.0, 0.0, 0.0],
  [17100.0, 0.0, 0.009615384615384616],
  [27000.0, 0.009615384615384616, 0.010989010989010988],
  [8400.0, 0.010989010989010988, 0.054945054945054944],
  [24100.0, 0.054945054945054944, 0.042735042735042736],
  [20000.0, 0.042735042735042736, 0.06837606837606837],
  [3700.0, 0.06837606837606837, 0.07692307692307693],
  [45100.0, 0.07692307692307693, 0.00641025641025641],
  [8000.0, 0.00641025641025641, 0.023076923076923075],
  [4200.0, 0.023076923076923075, 0.057692307692307696],
  [16500.0, 0.057692307692307696, 0.009615384615384616],
  [37800.0, 0.009615384615384616, 0.015384615384615385],
  [22200.0, 0.015384615384615385, 0.05128205128205128],
  [4000.0, 0.05128205128205128, 0.07692307692307693],
  [1800.0, 0.07692307692307693, 0.07692307692307693],
  [10200.0, 0.07692307692307693, 0.07692307692307693],
  [10600.0, 0.07692307692307693, 0.06153846153846154],
  [12900.0, 0.06153846153846154, 0.006993006993006993],
  [57000.0, 0.006993006993006993, 0.02564102564102564],
] @=> float fades[][];

Gain g => dac;
0.0 => g.gain;

SinOsc s => Pan2 p => g;
-0.04 => p.pan;
1300.0 => s.freq;

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
