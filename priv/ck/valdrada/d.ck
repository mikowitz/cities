[
  [7600.0, 0.0, 0.0],
  [1500.0, 0.0, 0.25],
  [12700.0, 0.25, 0.4375],
  [6500.0, 0.4375, 0.375],
  [9100.0, 0.375, 0.5],
  [31800.0, 0.5, 0.5],
  [5800.0, 0.5, 0.5],
  [2500.0, 0.5, 0.5],
  [300.0, 0.5, 0.4166666666666667],
  [14900.0, 0.4166666666666667, 0.125],
  [1500.0, 0.125, 0.25],
  [5600.0, 0.25, 0.4375],
  [1500.0, 0.4375, 0.25],
  [400.0, 0.25, 0.4375],
  [14200.0, 0.4375, 0.125],
  [8600.0, 0.125, 0.5],
  [3000.0, 0.5, 0.5],
  [9000.0, 0.5, 0.5],
  [1700.0, 0.5, 0.5],
  [1500.0, 0.5, 0.25],
  [400.0, 0.25, 0.4375],
  [18300.0, 0.4375, 0.125],
  [6800.0, 0.125, 0.5],
  [24700.0, 0.5, 0.35714285714285715],
  [18600.0, 0.35714285714285715, 0.5],
  [2600.0, 0.5, 0.2222222222222222],
  [1500.0, 0.2222222222222222, 0.2222222222222222],
  [23800.0, 0.2222222222222222, 0.3888888888888889],
  [16300.0, 0.3888888888888889, 0.5],
  [7600.0, 0.5, 0.07142857142857142],
  [26800.0, 0.07142857142857142, 0.5],
  [16100.0, 0.5, 0.5],
  [600.0, 0.5, 0.5],
  [37100.0, 0.5, 0.25],
  [18400.0, 0.25, 0.2222222222222222],
  [3300.0, 0.2222222222222222, 0.5],
  [900.0, 0.5, 0.5],
  [12100.0, 0.5, 0.4166666666666667],
  [7900.0, 0.4166666666666667, 0.4],
  [18200.0, 0.4, 0.2857142857142857],
  [17400.0, 0.2857142857142857, 0.2222222222222222],
  [10100.0, 0.2222222222222222, 0.2222222222222222],
  [1100.0, 0.2222222222222222, 0.5],
  [28100.0, 0.5, 0.5],
  [35100.0, 0.5, 0.08333333333333333],
  [25600.0, 0.08333333333333333, 0.5],
  [1500.0, 0.5, 0.25],
  [9600.0, 0.25, 0.4375],
  [7500.0, 0.4375, 0.5],
  [10000.0, 0.5, 0.5],
  [7000.0, 0.5, 0.5],
  [7700.0, 0.5, 0.5],
  [1500.0, 0.5, 0.2222222222222222],
  [14300.0, 0.2222222222222222, 0.3888888888888889],
  [9700.0, 0.3888888888888889, 0.5],
] @=> float fades[][];

Gain g => dac;
0.0 => g.gain;

SinOsc s => Pan2 p => g;
-0.7 => p.pan;
400.0 => s.freq;

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
