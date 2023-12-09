[
  [23300.0, 0.0, 0.0],
  [12600.0, 0.0, 0.08333333333333333],
  [200.0, 0.08333333333333333, 0.19999999999999998],
  [700.0, 0.19999999999999998, 0.26666666666666666],
  [35300.0, 0.26666666666666666, 0.08333333333333333],
  [56200.0, 0.08333333333333333, 0.2777777777777778],
  [2900.0, 0.2777777777777778, 0.2777777777777778],
  [33700.0, 0.2777777777777778, 0.26666666666666666],
  [1000.0, 0.26666666666666666, 0.2777777777777778],
  [4000.0, 0.2777777777777778, 0.19999999999999998],
  [11900.0, 0.19999999999999998, 0.2916666666666667],
  [17500.0, 0.2916666666666667, 0.19999999999999998],
  [1300.0, 0.19999999999999998, 0.3333333333333333],
  [26400.0, 0.3333333333333333, 0.06666666666666667],
  [3500.0, 0.06666666666666667, 0.16666666666666666],
  [3300.0, 0.16666666666666666, 0.08333333333333333],
  [29200.0, 0.08333333333333333, 0.3333333333333333],
  [7900.0, 0.3333333333333333, 0.2777777777777778],
  [18800.0, 0.2777777777777778, 0.13333333333333333],
  [12000.0, 0.13333333333333333, 0.05555555555555555],
  [4100.0, 0.05555555555555555, 0.125],
  [2900.0, 0.125, 0.08333333333333333],
  [6700.0, 0.08333333333333333, 0.1111111111111111],
  [200.0, 0.1111111111111111, 0.2222222222222222],
  [4200.0, 0.2222222222222222, 0.3333333333333333],
  [5200.0, 0.3333333333333333, 0.2777777777777778],
  [5300.0, 0.2777777777777778, 0.14285714285714285],
  [16000.0, 0.14285714285714285, 0.07407407407407407],
  [17500.0, 0.07407407407407407, 0.25],
  [200.0, 0.25, 0.125],
  [9300.0, 0.125, 0.16666666666666666],
  [23700.0, 0.16666666666666666, 0.24242424242424243],
  [20600.0, 0.24242424242424243, 0.25],
] @=> float fades[][];

Gain g => dac;
0.0 => g.gain;

SinOsc s => Pan2 p => g;
-0.11 => p.pan;
1200.0 => s.freq;

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