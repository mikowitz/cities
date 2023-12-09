[
  [1600.0, 0.0, 0.0],
  [16600.0, 0.0, 0.08333333333333333],
  [13600.0, 0.08333333333333333, 0.1111111111111111],
  [900.0, 0.1111111111111111, 0.16666666666666666],
  [2600.0, 0.16666666666666666, 0.08333333333333333],
  [5600.0, 0.08333333333333333, 0.2222222222222222],
  [4600.0, 0.2222222222222222, 0.3333333333333333],
  [200.0, 0.3333333333333333, 0.25],
  [2700.0, 0.25, 0.3333333333333333],
  [200.0, 0.3333333333333333, 0.25],
  [50200.0, 0.25, 0.3333333333333333],
  [6000.0, 0.3333333333333333, 0.26666666666666666],
  [200.0, 0.26666666666666666, 0.20833333333333334],
  [7500.0, 0.20833333333333334, 0.25],
  [13600.0, 0.25, 0.13333333333333333],
  [8500.0, 0.13333333333333333, 0.08333333333333333],
  [11200.0, 0.08333333333333333, 0.3055555555555555],
  [46200.0, 0.3055555555555555, 0.2857142857142857],
  [11400.0, 0.2857142857142857, 0.1111111111111111],
  [13400.0, 0.1111111111111111, 0.2962962962962963],
  [1700.0, 0.2962962962962963, 0.1111111111111111],
  [200.0, 0.1111111111111111, 0.14285714285714285],
  [10200.0, 0.14285714285714285, 0.19047619047619047],
  [13300.0, 0.19047619047619047, 0.08333333333333333],
  [6100.0, 0.08333333333333333, 0.09523809523809523],
  [12500.0, 0.09523809523809523, 0.2962962962962963],
  [4900.0, 0.2962962962962963, 0.08333333333333333],
  [8000.0, 0.08333333333333333, 0.05555555555555555],
  [200.0, 0.05555555555555555, 0.25],
  [41400.0, 0.25, 0.2916666666666667],
  [17100.0, 0.2916666666666667, 0.06666666666666667],
  [200.0, 0.06666666666666667, 0.1111111111111111],
  [4100.0, 0.1111111111111111, 0.14814814814814814],
  [4100.0, 0.14814814814814814, 0.13333333333333333],
  [8800.0, 0.13333333333333333, 0.2962962962962963],
  [35800.0, 0.2962962962962963, 0.26666666666666666],
  [200.0, 0.26666666666666666, 0.25],
  [21900.0, 0.25, 0.3333333333333333],
  [13900.0, 0.3333333333333333, 0.09523809523809523],
  [200.0, 0.09523809523809523, 0.20833333333333334],
  [2500.0, 0.20833333333333334, 0.25],
  [17600.0, 0.25, 0.26666666666666666],
  [4400.0, 0.26666666666666666, 0.16666666666666666],
  [200.0, 0.16666666666666666, 0.26666666666666666],
  [6900.0, 0.26666666666666666, 0.3333333333333333],
  [4100.0, 0.3333333333333333, 0.14814814814814814],
  [200.0, 0.14814814814814814, 0.25],
  [4500.0, 0.25, 0.3333333333333333],
  [3200.0, 0.3333333333333333, 0.05555555555555555],
  [200.0, 0.05555555555555555, 0.25],
  [11900.0, 0.25, 0.3333333333333333],
  [18500.0, 0.3333333333333333, 0.26666666666666666],
  [4300.0, 0.26666666666666666, 0.2916666666666667],
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