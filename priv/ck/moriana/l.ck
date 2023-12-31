[
  [25200.0, 0.0, 0.0],
  [13800.0, 0.0, 0.2916666666666667],
  [14300.0, 0.2916666666666667, 0.07407407407407407],
  [5800.0, 0.07407407407407407, 0.16666666666666666],
  [500.0, 0.16666666666666666, 0.3333333333333333],
  [24500.0, 0.3333333333333333, 0.14285714285714285],
  [200.0, 0.14285714285714285, 0.16666666666666666],
  [900.0, 0.16666666666666666, 0.2222222222222222],
  [200.0, 0.2222222222222222, 0.2222222222222222],
  [1100.0, 0.2222222222222222, 0.3333333333333333],
  [1000.0, 0.3333333333333333, 0.13333333333333333],
  [17500.0, 0.13333333333333333, 0.08333333333333333],
  [3700.0, 0.08333333333333333, 0.26666666666666666],
  [2400.0, 0.26666666666666666, 0.14285714285714285],
  [11200.0, 0.14285714285714285, 0.2222222222222222],
  [18000.0, 0.2222222222222222, 0.21212121212121213],
  [7500.0, 0.21212121212121213, 0.09523809523809523],
  [10200.0, 0.09523809523809523, 0.08333333333333333],
  [1300.0, 0.08333333333333333, 0.25],
  [6300.0, 0.25, 0.25],
  [3600.0, 0.25, 0.3],
  [200.0, 0.3, 0.25],
  [22300.0, 0.25, 0.3333333333333333],
  [1300.0, 0.3333333333333333, 0.3333333333333333],
  [1500.0, 0.3333333333333333, 0.2222222222222222],
  [4600.0, 0.2222222222222222, 0.1111111111111111],
  [8700.0, 0.1111111111111111, 0.2222222222222222],
  [4000.0, 0.2222222222222222, 0.13333333333333333],
  [4400.0, 0.13333333333333333, 0.13333333333333333],
  [2400.0, 0.13333333333333333, 0.13333333333333333],
  [200.0, 0.13333333333333333, 0.19999999999999998],
  [22700.0, 0.19999999999999998, 0.26666666666666666],
  [7300.0, 0.26666666666666666, 0.25],
  [29600.0, 0.25, 0.2857142857142857],
  [1800.0, 0.2857142857142857, 0.0909090909090909],
  [27800.0, 0.0909090909090909, 0.21212121212121213],
  [5700.0, 0.21212121212121213, 0.25],
  [29000.0, 0.25, 0.08333333333333333],
  [4400.0, 0.08333333333333333, 0.08333333333333333],
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
