[
  [18000.0, 0.0, 0.0],
  [11200.0, 0.0, 0.05263157894736842],
  [8200.0, 0.05263157894736842, 0.05263157894736842],
  [5400.0, 0.05263157894736842, 0.05263157894736842],
  [14100.0, 0.05263157894736842, 0.013157894736842105],
  [3600.0, 0.013157894736842105, 0.007518796992481203],
  [18800.0, 0.007518796992481203, 0.05263157894736842],
  [3300.0, 0.05263157894736842, 0.05263157894736842],
  [6700.0, 0.05263157894736842, 0.013157894736842105],
  [3800.0, 0.013157894736842105, 0.046052631578947366],
  [2200.0, 0.046052631578947366, 0.04678362573099415],
  [400.0, 0.04678362573099415, 0.03508771929824561],
  [4500.0, 0.03508771929824561, 0.05263157894736842],
  [1000.0, 0.05263157894736842, 0.013157894736842105],
  [2500.0, 0.013157894736842105, 0.010526315789473684],
  [600.0, 0.010526315789473684, 0.05263157894736842],
  [6700.0, 0.05263157894736842, 0.010526315789473684],
  [3500.0, 0.010526315789473684, 0.013157894736842105],
  [2900.0, 0.013157894736842105, 0.05263157894736842],
  [1000.0, 0.05263157894736842, 0.013157894736842105],
  [2700.0, 0.013157894736842105, 0.007518796992481203],
  [3900.0, 0.007518796992481203, 0.05263157894736842],
  [2400.0, 0.05263157894736842, 0.007518796992481203],
  [1400.0, 0.007518796992481203, 0.05263157894736842],
  [2500.0, 0.05263157894736842, 0.017543859649122806],
  [2100.0, 0.017543859649122806, 0.05263157894736842],
  [300.0, 0.05263157894736842, 0.05263157894736842],
  [2500.0, 0.05263157894736842, 0.010526315789473684],
  [9400.0, 0.010526315789473684, 0.05263157894736842],
  [700.0, 0.05263157894736842, 0.05263157894736842],
  [3500.0, 0.05263157894736842, 0.05263157894736842],
  [31100.0, 0.05263157894736842, 0.042105263157894736],
  [5400.0, 0.042105263157894736, 0.008771929824561403],
  [5800.0, 0.008771929824561403, 0.05263157894736842],
  [1400.0, 0.05263157894736842, 0.05263157894736842],
  [2000.0, 0.05263157894736842, 0.007518796992481203],
  [10100.0, 0.007518796992481203, 0.05263157894736842],
  [12300.0, 0.05263157894736842, 0.05263157894736842],
  [2700.0, 0.05263157894736842, 0.013157894736842105],
  [1900.0, 0.013157894736842105, 0.05263157894736842],
  [1000.0, 0.05263157894736842, 0.013157894736842105],
  [4400.0, 0.013157894736842105, 0.007518796992481203],
  [6200.0, 0.007518796992481203, 0.05263157894736842],
  [1400.0, 0.05263157894736842, 0.021052631578947368],
  [11400.0, 0.021052631578947368, 0.02631578947368421],
  [13200.0, 0.02631578947368421, 0.02631578947368421],
  [17000.0, 0.02631578947368421, 0.013157894736842105],
  [3300.0, 0.013157894736842105, 0.015789473684210527],
  [9200.0, 0.015789473684210527, 0.013157894736842105],
  [2900.0, 0.013157894736842105, 0.05263157894736842],
  [6000.0, 0.05263157894736842, 0.013157894736842105],
  [5600.0, 0.013157894736842105, 0.05263157894736842],
  [13800.0, 0.05263157894736842, 0.05263157894736842],
  [300.0, 0.05263157894736842, 0.05263157894736842],
] @=> float fades[][];

Gain g => dac;
0.0 => g.gain;

SinOsc s => Pan2 p => g;
0.41 => p.pan;
1900.0 => s.freq;

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
