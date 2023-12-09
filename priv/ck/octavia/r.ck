[
  [17300.0, 0.0, 0.0],
  [6500.0, 0.0, 0.2222222222222222],
  [2900.0, 0.2222222222222222, 0.26666666666666666],
  [16300.0, 0.26666666666666666, 0.07407407407407407],
  [7900.0, 0.07407407407407407, 0.3333333333333333],
  [4200.0, 0.3333333333333333, 0.1111111111111111],
  [18200.0, 0.1111111111111111, 0.06666666666666667],
  [6000.0, 0.06666666666666667, 0.14285714285714285],
  [7200.0, 0.14285714285714285, 0.3333333333333333],
  [9100.0, 0.3333333333333333, 0.3333333333333333],
  [4400.0, 0.3333333333333333, 0.14285714285714285],
  [6600.0, 0.14285714285714285, 0.26666666666666666],
  [3300.0, 0.26666666666666666, 0.3333333333333333],
  [5000.0, 0.3333333333333333, 0.20833333333333334],
  [8900.0, 0.20833333333333334, 0.20833333333333334],
  [2100.0, 0.20833333333333334, 0.14285714285714285],
  [26500.0, 0.14285714285714285, 0.3333333333333333],
  [7500.0, 0.3333333333333333, 0.16666666666666666],
  [3100.0, 0.16666666666666666, 0.2857142857142857],
  [5000.0, 0.2857142857142857, 0.08333333333333333],
  [10300.0, 0.08333333333333333, 0.05555555555555555],
  [2500.0, 0.05555555555555555, 0.08333333333333333],
  [13200.0, 0.08333333333333333, 0.2857142857142857],
  [1900.0, 0.2857142857142857, 0.2857142857142857],
  [1100.0, 0.2857142857142857, 0.125],
  [9300.0, 0.125, 0.16666666666666666],
  [8900.0, 0.16666666666666666, 0.3333333333333333],
  [7100.0, 0.3333333333333333, 0.14285714285714285],
  [2600.0, 0.14285714285714285, 0.30303030303030304],
  [1800.0, 0.30303030303030304, 0.2857142857142857],
  [3400.0, 0.2857142857142857, 0.08333333333333333],
  [3900.0, 0.08333333333333333, 0.06666666666666667],
  [3100.0, 0.06666666666666667, 0.3333333333333333],
  [5200.0, 0.3333333333333333, 0.2222222222222222],
  [4500.0, 0.2222222222222222, 0.25],
  [4900.0, 0.25, 0.30303030303030304],
  [10000.0, 0.30303030303030304, 0.08333333333333333],
  [17900.0, 0.08333333333333333, 0.3333333333333333],
  [7800.0, 0.3333333333333333, 0.1851851851851852],
  [14300.0, 0.1851851851851852, 0.3333333333333333],
] @=> float fades[][];

Gain g => dac;
0.0 => g.gain;

SinOsc s => Pan2 p => g;
0.33 => p.pan;
1800.0 => s.freq;

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