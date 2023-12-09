[
  [40300.0, 0.0, 0.0],
  [6200.0, 0.0, 0.08333333333333333],
  [4400.0, 0.08333333333333333, 0.2962962962962963],
  [5500.0, 0.2962962962962963, 0.05555555555555555],
  [7700.0, 0.05555555555555555, 0.3333333333333333],
  [200.0, 0.3333333333333333, 0.12820512820512822],
  [7700.0, 0.12820512820512822, 0.15384615384615385],
  [31700.0, 0.15384615384615385, 0.19047619047619047],
  [31000.0, 0.19047619047619047, 0.13333333333333333],
  [11400.0, 0.13333333333333333, 0.3333333333333333],
  [16100.0, 0.3333333333333333, 0.08333333333333333],
  [200.0, 0.08333333333333333, 0.1111111111111111],
  [11800.0, 0.1111111111111111, 0.14814814814814814],
  [8400.0, 0.14814814814814814, 0.3333333333333333],
  [5000.0, 0.3333333333333333, 0.09523809523809523],
  [17700.0, 0.09523809523809523, 0.1851851851851852],
  [1100.0, 0.1851851851851852, 0.2777777777777778],
  [11500.0, 0.2777777777777778, 0.13333333333333333],
  [2800.0, 0.13333333333333333, 0.14285714285714285],
  [20600.0, 0.14285714285714285, 0.13333333333333333],
  [1000.0, 0.13333333333333333, 0.13333333333333333],
  [200.0, 0.13333333333333333, 0.14285714285714285],
  [31500.0, 0.14285714285714285, 0.19047619047619047],
  [4400.0, 0.19047619047619047, 0.13333333333333333],
  [15300.0, 0.13333333333333333, 0.19999999999999998],
  [16300.0, 0.19999999999999998, 0.08333333333333333],
  [200.0, 0.08333333333333333, 0.13333333333333333],
  [2000.0, 0.13333333333333333, 0.19999999999999998],
  [23800.0, 0.19999999999999998, 0.06666666666666667],
  [12500.0, 0.06666666666666667, 0.08333333333333333],
  [200.0, 0.08333333333333333, 0.19999999999999998],
  [4300.0, 0.19999999999999998, 0.26666666666666666],
  [26000.0, 0.26666666666666666, 0.13333333333333333],
  [4800.0, 0.13333333333333333, 0.2962962962962963],
  [400.0, 0.2962962962962963, 0.3333333333333333],
  [8600.0, 0.3333333333333333, 0.044444444444444446],
  [2400.0, 0.044444444444444446, 0.2380952380952381],
  [200.0, 0.2380952380952381, 0.16666666666666666],
  [34800.0, 0.16666666666666666, 0.19047619047619047],
  [17900.0, 0.19047619047619047, 0.1818181818181818],
  [1900.0, 0.1818181818181818, 0.2222222222222222],
  [35600.0, 0.2222222222222222, 0.047619047619047616],
  [2200.0, 0.047619047619047616, 0.2333333333333333],
  [11400.0, 0.2333333333333333, 0.1111111111111111],
  [6900.0, 0.1111111111111111, 0.2777777777777778],
  [24200.0, 0.2777777777777778, 0.03333333333333333],
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