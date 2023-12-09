[
  [2900.0, 0.0, 0.0],
  [200.0, 0.0, 0.26666666666666666],
  [700.0, 0.26666666666666666, 0.3333333333333333],
  [200.0, 0.3333333333333333, 0.25],
  [12900.0, 0.25, 0.3333333333333333],
  [25200.0, 0.3333333333333333, 0.3333333333333333],
  [16900.0, 0.3333333333333333, 0.14285714285714285],
  [4500.0, 0.14285714285714285, 0.07407407407407407],
  [2800.0, 0.07407407407407407, 0.1111111111111111],
  [3300.0, 0.1111111111111111, 0.1111111111111111],
  [16500.0, 0.1111111111111111, 0.2222222222222222],
  [2800.0, 0.2222222222222222, 0.05555555555555555],
  [9500.0, 0.05555555555555555, 0.047619047619047616],
  [9400.0, 0.047619047619047616, 0.25925925925925924],
  [5000.0, 0.25925925925925924, 0.09999999999999999],
  [15900.0, 0.09999999999999999, 0.2857142857142857],
  [200.0, 0.2857142857142857, 0.14285714285714285],
  [4200.0, 0.14285714285714285, 0.19047619047619047],
  [44500.0, 0.19047619047619047, 0.19999999999999998],
  [200.0, 0.19999999999999998, 0.14285714285714285],
  [53800.0, 0.14285714285714285, 0.19047619047619047],
  [600.0, 0.19047619047619047, 0.30952380952380953],
  [33600.0, 0.30952380952380953, 0.16666666666666666],
  [4100.0, 0.16666666666666666, 0.08333333333333333],
  [3000.0, 0.08333333333333333, 0.1111111111111111],
  [14900.0, 0.1111111111111111, 0.08333333333333333],
  [24400.0, 0.08333333333333333, 0.14285714285714285],
  [14900.0, 0.14285714285714285, 0.125],
  [9200.0, 0.125, 0.1111111111111111],
  [7700.0, 0.1111111111111111, 0.08333333333333333],
  [8800.0, 0.08333333333333333, 0.3333333333333333],
  [14700.0, 0.3333333333333333, 0.2222222222222222],
  [97100.0, 0.2222222222222222, 0.06666666666666667],
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