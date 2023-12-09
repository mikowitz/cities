[
  [1300.0, 0.0, 0.0],
  [10000.0, 0.0, 0.05263157894736842],
  [7500.0, 0.05263157894736842, 0.05263157894736842],
  [7100.0, 0.05263157894736842, 0.05263157894736842],
  [6100.0, 0.05263157894736842, 0.023391812865497075],
  [7800.0, 0.023391812865497075, 0.039473684210526314],
  [11100.0, 0.039473684210526314, 0.03007518796992481],
  [1600.0, 0.03007518796992481, 0.010526315789473684],
  [8000.0, 0.010526315789473684, 0.05263157894736842],
  [4300.0, 0.05263157894736842, 0.05263157894736842],
  [16700.0, 0.05263157894736842, 0.05263157894736842],
  [6100.0, 0.05263157894736842, 0.05263157894736842],
  [4400.0, 0.05263157894736842, 0.05263157894736842],
  [17800.0, 0.05263157894736842, 0.05263157894736842],
  [5100.0, 0.05263157894736842, 0.05263157894736842],
  [2400.0, 0.05263157894736842, 0.05263157894736842],
  [800.0, 0.05263157894736842, 0.039473684210526314],
  [1000.0, 0.039473684210526314, 0.008771929824561403],
  [700.0, 0.008771929824561403, 0.05263157894736842],
  [6200.0, 0.05263157894736842, 0.015789473684210527],
  [3300.0, 0.015789473684210527, 0.017543859649122806],
  [5200.0, 0.017543859649122806, 0.017543859649122806],
  [25200.0, 0.017543859649122806, 0.05263157894736842],
  [6300.0, 0.05263157894736842, 0.042105263157894736],
  [1500.0, 0.042105263157894736, 0.05263157894736842],
  [16200.0, 0.05263157894736842, 0.013157894736842105],
  [1000.0, 0.013157894736842105, 0.013157894736842105],
  [3100.0, 0.013157894736842105, 0.005847953216374269],
  [600.0, 0.005847953216374269, 0.05263157894736842],
  [27700.0, 0.05263157894736842, 0.008771929824561403],
  [5500.0, 0.008771929824561403, 0.03508771929824561],
  [4200.0, 0.03508771929824561, 0.05263157894736842],
  [8000.0, 0.05263157894736842, 0.008771929824561403],
  [17500.0, 0.008771929824561403, 0.05263157894736842],
  [13300.0, 0.05263157894736842, 0.05263157894736842],
  [1600.0, 0.05263157894736842, 0.030701754385964914],
  [3800.0, 0.030701754385964914, 0.05263157894736842],
  [1300.0, 0.05263157894736842, 0.045112781954887216],
  [3200.0, 0.045112781954887216, 0.05263157894736842],
  [300.0, 0.05263157894736842, 0.02631578947368421],
  [5500.0, 0.02631578947368421, 0.031578947368421054],
  [5600.0, 0.031578947368421054, 0.05263157894736842],
  [14500.0, 0.05263157894736842, 0.02631578947368421],
  [300.0, 0.02631578947368421, 0.05263157894736842],
  [2400.0, 0.05263157894736842, 0.007518796992481203],
  [2700.0, 0.007518796992481203, 0.05263157894736842],
  [10900.0, 0.05263157894736842, 0.05263157894736842],
  [5600.0, 0.05263157894736842, 0.05263157894736842],
  [2000.0, 0.05263157894736842, 0.05263157894736842],
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
