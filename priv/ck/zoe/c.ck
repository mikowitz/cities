[
  [14500.0, 0.0, 0.0],
  [19500.0, 0.0, 0.08333333333333333],
  [7500.0, 0.08333333333333333, 0.2777777777777778],
  [13600.0, 0.2777777777777778, 0.25],
  [45400.0, 0.25, 0.08333333333333333],
  [11600.0, 0.08333333333333333, 0.08333333333333333],
  [15700.0, 0.08333333333333333, 0.08333333333333333],
  [2200.0, 0.08333333333333333, 0.1111111111111111],
  [23700.0, 0.1111111111111111, 0.05555555555555555],
  [6100.0, 0.05555555555555555, 0.26666666666666666],
  [1500.0, 0.26666666666666666, 0.2380952380952381],
  [25300.0, 0.2380952380952381, 0.2380952380952381],
  [10300.0, 0.2380952380952381, 0.041666666666666664],
  [9700.0, 0.041666666666666664, 0.25],
  [7600.0, 0.25, 0.08333333333333333],
  [800.0, 0.08333333333333333, 0.27272727272727276],
  [22400.0, 0.27272727272727276, 0.08333333333333333],
  [22300.0, 0.08333333333333333, 0.05555555555555555],
  [2800.0, 0.05555555555555555, 0.08333333333333333],
  [8700.0, 0.08333333333333333, 0.1111111111111111],
  [800.0, 0.1111111111111111, 0.08333333333333333],
  [200.0, 0.08333333333333333, 0.06666666666666667],
  [16300.0, 0.06666666666666667, 0.09999999999999999],
  [9800.0, 0.09999999999999999, 0.19047619047619047],
  [1500.0, 0.19047619047619047, 0.06666666666666667],
  [51200.0, 0.06666666666666667, 0.06666666666666667],
  [10900.0, 0.06666666666666667, 0.08333333333333333],
  [19600.0, 0.08333333333333333, 0.2916666666666667],
  [14000.0, 0.2916666666666667, 0.2962962962962963],
  [8800.0, 0.2962962962962963, 0.26666666666666666],
  [6100.0, 0.26666666666666666, 0.2962962962962963],
  [30500.0, 0.2962962962962963, 0.08333333333333333],
] @=> float fades[][];

Gain g => dac;
0.0 => g.gain;

SinOsc s => Pan2 p => g;
-0.78 => p.pan;
300.0 => s.freq;

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
