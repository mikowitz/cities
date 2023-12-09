[
  [7500.0, 0.0, 0.0],
  [2000.0, 0.0, 0.2777777777777778],
  [1900.0, 0.2777777777777778, 0.05555555555555555],
  [6200.0, 0.05555555555555555, 0.2777777777777778],
  [5000.0, 0.2777777777777778, 0.13333333333333333],
  [6200.0, 0.13333333333333333, 0.2222222222222222],
  [5000.0, 0.2222222222222222, 0.19444444444444445],
  [8400.0, 0.19444444444444445, 0.3333333333333333],
  [18000.0, 0.3333333333333333, 0.25],
  [5600.0, 0.25, 0.047619047619047616],
  [6800.0, 0.047619047619047616, 0.25],
  [11600.0, 0.25, 0.2380952380952381],
  [19400.0, 0.2380952380952381, 0.08333333333333333],
  [3900.0, 0.08333333333333333, 0.041666666666666664],
  [8100.0, 0.041666666666666664, 0.05555555555555555],
  [40000.0, 0.05555555555555555, 0.08333333333333333],
  [15800.0, 0.08333333333333333, 0.19444444444444445],
  [1800.0, 0.19444444444444445, 0.2857142857142857],
  [200.0, 0.2857142857142857, 0.25],
  [6700.0, 0.25, 0.3333333333333333],
  [7600.0, 0.3333333333333333, 0.2857142857142857],
  [32300.0, 0.2857142857142857, 0.25],
  [200.0, 0.25, 0.14285714285714285],
  [9500.0, 0.14285714285714285, 0.19047619047619047],
  [10200.0, 0.19047619047619047, 0.19444444444444445],
  [45800.0, 0.19444444444444445, 0.19444444444444445],
  [9800.0, 0.19444444444444445, 0.16666666666666666],
  [3900.0, 0.16666666666666666, 0.16666666666666666],
  [200.0, 0.16666666666666666, 0.1111111111111111],
  [4000.0, 0.1111111111111111, 0.14814814814814814],
  [5900.0, 0.14814814814814814, 0.07407407407407407],
  [200.0, 0.07407407407407407, 0.25],
  [40900.0, 0.25, 0.3333333333333333],
  [200.0, 0.3333333333333333, 0.19999999999999998],
  [4900.0, 0.19999999999999998, 0.26666666666666666],
  [8300.0, 0.26666666666666666, 0.16666666666666666],
  [200.0, 0.16666666666666666, 0.16666666666666666],
  [9500.0, 0.16666666666666666, 0.2222222222222222],
  [6400.0, 0.2222222222222222, 0.07407407407407407],
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
