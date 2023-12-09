[
  [61900.0, 0.0, 0.0],
  [20800.0, 0.0, 0.057692307692307696],
  [11400.0, 0.057692307692307696, 0.07692307692307693],
  [22600.0, 0.07692307692307693, 0.06593406593406594],
  [8900.0, 0.06593406593406594, 0.05384615384615384],
  [5200.0, 0.05384615384615384, 0.02564102564102564],
  [13200.0, 0.02564102564102564, 0.07692307692307693],
  [48300.0, 0.07692307692307693, 0.04615384615384615],
  [4600.0, 0.04615384615384615, 0.06410256410256411],
  [2600.0, 0.06410256410256411, 0.05128205128205128],
  [15800.0, 0.05128205128205128, 0.05128205128205128],
  [56900.0, 0.05128205128205128, 0.015384615384615385],
  [2400.0, 0.015384615384615385, 0.03296703296703297],
  [16700.0, 0.03296703296703297, 0.03076923076923077],
  [9000.0, 0.03076923076923077, 0.015384615384615385],
  [26100.0, 0.015384615384615385, 0.07692307692307693],
  [83300.0, 0.07692307692307693, 0.019230769230769232],
  [43500.0, 0.019230769230769232, 0.07692307692307693],
  [5100.0, 0.07692307692307693, 0.02564102564102564],
  [8500.0, 0.02564102564102564, 0.019230769230769232],
  [30700.0, 0.019230769230769232, 0.006993006993006993],
  [53500.0, 0.006993006993006993, 0.017094017094017092],
  [41400.0, 0.017094017094017092, 0.057692307692307696],
  [600.0, 0.057692307692307696, 0.038461538461538464],
  [500.0, 0.038461538461538464, 0.01282051282051282],
  [30100.0, 0.01282051282051282, 0.038461538461538464],
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