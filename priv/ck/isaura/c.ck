[
  [3500.0, 0.0, 0.0],
  [40800.0, 0.0, 0.08333333333333333],
  [10200.0, 0.08333333333333333, 0.25],
  [200.0, 0.25, 0.14285714285714285],
  [12700.0, 0.14285714285714285, 0.19047619047619047],
  [37000.0, 0.19047619047619047, 0.08333333333333333],
  [800.0, 0.08333333333333333, 0.2222222222222222],
  [33800.0, 0.2222222222222222, 0.03333333333333333],
  [5600.0, 0.03333333333333333, 0.125],
  [700.0, 0.125, 0.19999999999999998],
  [600.0, 0.19999999999999998, 0.03333333333333333],
  [3500.0, 0.03333333333333333, 0.13333333333333333],
  [19700.0, 0.13333333333333333, 0.027777777777777776],
  [3400.0, 0.027777777777777776, 0.06666666666666667],
  [200.0, 0.06666666666666667, 0.07407407407407407],
  [15300.0, 0.07407407407407407, 0.1111111111111111],
  [13900.0, 0.1111111111111111, 0.26666666666666666],
  [200.0, 0.26666666666666666, 0.07407407407407407],
  [14000.0, 0.07407407407407407, 0.1111111111111111],
  [10100.0, 0.1111111111111111, 0.14285714285714285],
  [88400.0, 0.14285714285714285, 0.06666666666666667],
  [15100.0, 0.06666666666666667, 0.19047619047619047],
  [4700.0, 0.19047619047619047, 0.16666666666666666],
  [4100.0, 0.16666666666666666, 0.25925925925925924],
  [8600.0, 0.25925925925925924, 0.047619047619047616],
  [19400.0, 0.047619047619047616, 0.25],
  [300.0, 0.25, 0.2222222222222222],
  [10500.0, 0.2222222222222222, 0.2777777777777778],
  [7800.0, 0.2777777777777778, 0.05555555555555555],
  [10700.0, 0.05555555555555555, 0.08333333333333333],
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
