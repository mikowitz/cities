[
  [900.0, 0.0, 0.0],
  [4100.0, 0.0, 0.3333333333333333],
  [2700.0, 0.3333333333333333, 0.19999999999999998],
  [6400.0, 0.19999999999999998, 0.14285714285714285],
  [1800.0, 0.14285714285714285, 0.08333333333333333],
  [2200.0, 0.08333333333333333, 0.3333333333333333],
  [3000.0, 0.3333333333333333, 0.125],
  [13100.0, 0.125, 0.2777777777777778],
  [1100.0, 0.2777777777777778, 0.09523809523809523],
  [5000.0, 0.09523809523809523, 0.14285714285714285],
  [5100.0, 0.14285714285714285, 0.3333333333333333],
  [2600.0, 0.3333333333333333, 0.08333333333333333],
  [3200.0, 0.08333333333333333, 0.16666666666666666],
  [4300.0, 0.16666666666666666, 0.1111111111111111],
  [5000.0, 0.1111111111111111, 0.13333333333333333],
  [4500.0, 0.13333333333333333, 0.16666666666666666],
  [2400.0, 0.16666666666666666, 0.3333333333333333],
  [8200.0, 0.3333333333333333, 0.2222222222222222],
  [11600.0, 0.2222222222222222, 0.2857142857142857],
  [3800.0, 0.2857142857142857, 0.2857142857142857],
  [9400.0, 0.2857142857142857, 0.1111111111111111],
  [1300.0, 0.1111111111111111, 0.05555555555555555],
  [8600.0, 0.05555555555555555, 0.16666666666666666],
  [2100.0, 0.16666666666666666, 0.14285714285714285],
  [8800.0, 0.14285714285714285, 0.13333333333333333],
  [2700.0, 0.13333333333333333, 0.26666666666666666],
  [1500.0, 0.26666666666666666, 0.1111111111111111],
  [15400.0, 0.1111111111111111, 0.3333333333333333],
  [15200.0, 0.3333333333333333, 0.19999999999999998],
  [6900.0, 0.19999999999999998, 0.06666666666666667],
  [5400.0, 0.06666666666666667, 0.2222222222222222],
  [4300.0, 0.2222222222222222, 0.19047619047619047],
  [10300.0, 0.19047619047619047, 0.3333333333333333],
  [1400.0, 0.3333333333333333, 0.26666666666666666],
  [2100.0, 0.26666666666666666, 0.2222222222222222],
  [20600.0, 0.2222222222222222, 0.19999999999999998],
  [4700.0, 0.19999999999999998, 0.19999999999999998],
  [19300.0, 0.19999999999999998, 0.047619047619047616],
  [17100.0, 0.047619047619047616, 0.2777777777777778],
  [3500.0, 0.2777777777777778, 0.2916666666666667],
  [2400.0, 0.2916666666666667, 0.3333333333333333],
  [30100.0, 0.3333333333333333, 0.25],
  [4000.0, 0.25, 0.3333333333333333],
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