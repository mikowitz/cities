[
  [23800.0, 0.0, 0.0],
  [10500.0, 0.0, 0.3333333333333333],
  [28300.0, 0.3333333333333333, 0.3333333333333333],
  [16300.0, 0.3333333333333333, 0.3333333333333333],
  [26100.0, 0.3333333333333333, 0.05555555555555555],
  [24500.0, 0.05555555555555555, 0.3333333333333333],
  [5400.0, 0.3333333333333333, 0.3333333333333333],
  [39300.0, 0.3333333333333333, 0.1111111111111111],
  [7000.0, 0.1111111111111111, 0.3333333333333333],
  [33300.0, 0.3333333333333333, 0.08333333333333333],
  [9900.0, 0.08333333333333333, 0.08333333333333333],
  [12000.0, 0.08333333333333333, 0.3333333333333333],
  [2800.0, 0.3333333333333333, 0.08333333333333333],
  [1800.0, 0.08333333333333333, 0.06666666666666667],
  [200.0, 0.06666666666666667, 0.09523809523809523],
  [38900.0, 0.09523809523809523, 0.14285714285714285],
  [26000.0, 0.14285714285714285, 0.06666666666666667],
  [14300.0, 0.06666666666666667, 0.3333333333333333],
  [25600.0, 0.3333333333333333, 0.3333333333333333],
  [28900.0, 0.3333333333333333, 0.3333333333333333],
  [42200.0, 0.3333333333333333, 0.3333333333333333],
  [7400.0, 0.3333333333333333, 0.3333333333333333],
  [6800.0, 0.3333333333333333, 0.3333333333333333],
  [200.0, 0.3333333333333333, 0.1111111111111111],
  [20800.0, 0.1111111111111111, 0.14814814814814814],
  [26500.0, 0.14814814814814814, 0.08333333333333333],
] @=> float fades[][];

Gain g => dac;
0.0 => g.gain;

SinOsc s => Pan2 p => g;
-0.56 => p.pan;
600.0 => s.freq;

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