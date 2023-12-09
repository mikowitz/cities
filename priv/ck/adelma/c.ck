[
  [28200.0, 0.0, 0.0],
  [5000.0, 0.0, 0.25],
  [51100.0, 0.25, 0.05555555555555555],
  [3600.0, 0.05555555555555555, 0.14285714285714285],
  [8200.0, 0.14285714285714285, 0.08333333333333333],
  [40100.0, 0.08333333333333333, 0.09999999999999999],
  [2000.0, 0.09999999999999999, 0.06666666666666667],
  [22700.0, 0.06666666666666667, 0.06666666666666667],
  [59200.0, 0.06666666666666667, 0.16666666666666666],
  [8300.0, 0.16666666666666666, 0.25],
  [13600.0, 0.25, 0.08333333333333333],
  [20000.0, 0.08333333333333333, 0.1111111111111111],
  [14100.0, 0.1111111111111111, 0.08333333333333333],
  [14200.0, 0.08333333333333333, 0.041666666666666664],
  [6800.0, 0.041666666666666664, 0.2777777777777778],
  [16900.0, 0.2777777777777778, 0.19999999999999998],
  [28500.0, 0.19999999999999998, 0.08333333333333333],
  [3200.0, 0.08333333333333333, 0.047619047619047616],
  [25000.0, 0.047619047619047616, 0.1111111111111111],
  [8900.0, 0.1111111111111111, 0.19047619047619047],
  [28100.0, 0.19047619047619047, 0.25925925925925924],
  [14600.0, 0.25925925925925924, 0.25],
  [34200.0, 0.25, 0.26666666666666666],
  [200.0, 0.26666666666666666, 0.1111111111111111],
  [3100.0, 0.1111111111111111, 0.16666666666666666],
  [10500.0, 0.16666666666666666, 0.19999999999999998],
  [2200.0, 0.19999999999999998, 0.25],
  [13700.0, 0.25, 0.1111111111111111],
  [15500.0, 0.1111111111111111, 0.25],
  [23600.0, 0.25, 0.047619047619047616],
  [5700.0, 0.047619047619047616, 0.19999999999999998],
  [400.0, 0.19999999999999998, 0.1111111111111111],
  [17300.0, 0.1111111111111111, 0.1851851851851852],
  [14300.0, 0.1851851851851852, 0.1111111111111111],
  [5400.0, 0.1111111111111111, 0.3],
  [21300.0, 0.3, 0.06666666666666667],
  [3300.0, 0.06666666666666667, 0.06666666666666667],
  [16800.0, 0.06666666666666667, 0.047619047619047616],
  [1300.0, 0.047619047619047616, 0.2333333333333333],
  [22400.0, 0.2333333333333333, 0.19999999999999998],
  [7900.0, 0.19999999999999998, 0.0909090909090909],
  [10400.0, 0.0909090909090909, 0.1111111111111111],
  [8000.0, 0.1111111111111111, 0.09999999999999999],
  [45500.0, 0.09999999999999999, 0.25],
  [8600.0, 0.25, 0.25],
  [11100.0, 0.25, 0.25],
  [13200.0, 0.25, 0.08333333333333333],
  [33200.0, 0.08333333333333333, 0.25],
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
