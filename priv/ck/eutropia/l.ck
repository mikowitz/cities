[
  [22100.0, 0.0, 0.0],
  [3100.0, 0.0, 0.3333333333333333],
  [10600.0, 0.3333333333333333, 0.25],
  [5500.0, 0.25, 0.3333333333333333],
  [12200.0, 0.3333333333333333, 0.16666666666666666],
  [200.0, 0.16666666666666666, 0.14285714285714285],
  [2700.0, 0.14285714285714285, 0.19047619047619047],
  [10800.0, 0.19047619047619047, 0.09523809523809523],
  [200.0, 0.09523809523809523, 0.2222222222222222],
  [8500.0, 0.2222222222222222, 0.3333333333333333],
  [35900.0, 0.3333333333333333, 0.25],
  [200.0, 0.25, 0.26666666666666666],
  [700.0, 0.26666666666666666, 0.3333333333333333],
  [200.0, 0.3333333333333333, 0.25],
  [16100.0, 0.25, 0.3333333333333333],
  [15000.0, 0.3333333333333333, 0.3333333333333333],
  [8200.0, 0.3333333333333333, 0.05555555555555555],
  [8500.0, 0.05555555555555555, 0.1111111111111111],
  [4500.0, 0.1111111111111111, 0.08333333333333333],
  [14700.0, 0.08333333333333333, 0.2777777777777778],
  [34500.0, 0.2777777777777778, 0.26666666666666666],
  [200.0, 0.26666666666666666, 0.25],
  [10800.0, 0.25, 0.3333333333333333],
  [200.0, 0.3333333333333333, 0.25],
  [3800.0, 0.25, 0.3333333333333333],
  [12800.0, 0.3333333333333333, 0.037037037037037035],
  [200.0, 0.037037037037037035, 0.25],
  [23500.0, 0.25, 0.3333333333333333],
  [19500.0, 0.3333333333333333, 0.08333333333333333],
  [48700.0, 0.08333333333333333, 0.14814814814814814],
  [21700.0, 0.14814814814814814, 0.2222222222222222],
  [900.0, 0.2222222222222222, 0.13333333333333333],
  [5200.0, 0.13333333333333333, 0.1111111111111111],
  [12200.0, 0.1111111111111111, 0.19999999999999998],
  [1800.0, 0.19999999999999998, 0.125],
  [11700.0, 0.125, 0.2916666666666667],
  [7200.0, 0.2916666666666667, 0.041666666666666664],
  [9200.0, 0.041666666666666664, 0.2777777777777778],
  [13700.0, 0.2777777777777778, 0.09523809523809523],
  [5000.0, 0.09523809523809523, 0.08333333333333333],
  [49200.0, 0.08333333333333333, 0.3333333333333333],
  [8000.0, 0.3333333333333333, 0.2962962962962963],
  [10900.0, 0.2962962962962963, 0.07407407407407407],
  [2000.0, 0.07407407407407407, 0.3333333333333333],
  [3300.0, 0.3333333333333333, 0.13333333333333333],
  [200.0, 0.13333333333333333, 0.2222222222222222],
  [16000.0, 0.2222222222222222, 0.3333333333333333],
  [10700.0, 0.3333333333333333, 0.1111111111111111],
  [19200.0, 0.1111111111111111, 0.2777777777777778],
  [300.0, 0.2777777777777778, 0.2857142857142857],
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
