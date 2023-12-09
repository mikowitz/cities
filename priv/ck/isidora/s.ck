[
  [5300.0, 0.0, 0.0],
  [12900.0, 0.0, 0.05263157894736842],
  [1500.0, 0.05263157894736842, 0.05263157894736842],
  [1600.0, 0.05263157894736842, 0.05263157894736842],
  [9700.0, 0.05263157894736842, 0.02631578947368421],
  [1700.0, 0.02631578947368421, 0.05263157894736842],
  [12300.0, 0.05263157894736842, 0.015037593984962405],
  [1200.0, 0.015037593984962405, 0.05263157894736842],
  [3000.0, 0.05263157894736842, 0.008771929824561403],
  [3300.0, 0.008771929824561403, 0.005263157894736842],
  [400.0, 0.005263157894736842, 0.042105263157894736],
  [3200.0, 0.042105263157894736, 0.05263157894736842],
  [3000.0, 0.05263157894736842, 0.03508771929824561],
  [3000.0, 0.03508771929824561, 0.008771929824561403],
  [600.0, 0.008771929824561403, 0.005847953216374269],
  [1300.0, 0.005847953216374269, 0.023391812865497075],
  [5500.0, 0.023391812865497075, 0.05263157894736842],
  [1000.0, 0.05263157894736842, 0.02631578947368421],
  [4300.0, 0.02631578947368421, 0.05263157894736842],
  [11100.0, 0.05263157894736842, 0.05263157894736842],
  [9500.0, 0.05263157894736842, 0.015789473684210527],
  [4500.0, 0.015789473684210527, 0.05263157894736842],
  [8900.0, 0.05263157894736842, 0.05263157894736842],
  [9100.0, 0.05263157894736842, 0.05263157894736842],
  [5700.0, 0.05263157894736842, 0.05263157894736842],
  [1300.0, 0.05263157894736842, 0.05263157894736842],
  [7100.0, 0.05263157894736842, 0.05263157894736842],
  [3500.0, 0.05263157894736842, 0.042105263157894736],
  [2700.0, 0.042105263157894736, 0.05263157894736842],
  [5400.0, 0.05263157894736842, 0.022556390977443608],
  [7400.0, 0.022556390977443608, 0.015037593984962405],
  [4700.0, 0.015037593984962405, 0.05263157894736842],
  [2300.0, 0.05263157894736842, 0.05263157894736842],
  [17800.0, 0.05263157894736842, 0.05263157894736842],
  [8300.0, 0.05263157894736842, 0.05263157894736842],
  [1800.0, 0.05263157894736842, 0.05263157894736842],
  [5800.0, 0.05263157894736842, 0.015037593984962405],
  [4300.0, 0.015037593984962405, 0.05263157894736842],
  [5800.0, 0.05263157894736842, 0.008771929824561403],
  [6800.0, 0.008771929824561403, 0.05263157894736842],
  [10300.0, 0.05263157894736842, 0.017543859649122806],
  [300.0, 0.017543859649122806, 0.05263157894736842],
  [8200.0, 0.05263157894736842, 0.008771929824561403],
  [2400.0, 0.008771929824561403, 0.022556390977443608],
  [7000.0, 0.022556390977443608, 0.05263157894736842],
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