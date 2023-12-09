[
  [2200.0, 0.0, 0.0],
  [10300.0, 0.0, 0.05555555555555555],
  [6500.0, 0.05555555555555555, 0.09523809523809523],
  [8900.0, 0.09523809523809523, 0.08333333333333333],
  [2300.0, 0.08333333333333333, 0.14814814814814814],
  [9600.0, 0.14814814814814814, 0.2962962962962963],
  [10900.0, 0.2962962962962963, 0.08333333333333333],
  [7400.0, 0.08333333333333333, 0.05555555555555555],
  [3900.0, 0.05555555555555555, 0.05555555555555555],
  [10900.0, 0.05555555555555555, 0.041666666666666664],
  [12900.0, 0.041666666666666664, 0.047619047619047616],
  [2900.0, 0.047619047619047616, 0.2222222222222222],
  [29700.0, 0.2222222222222222, 0.06666666666666667],
  [10900.0, 0.06666666666666667, 0.05555555555555555],
  [4900.0, 0.05555555555555555, 0.1111111111111111],
  [12400.0, 0.1111111111111111, 0.05555555555555555],
  [4700.0, 0.05555555555555555, 0.08333333333333333],
  [32500.0, 0.08333333333333333, 0.26666666666666666],
  [5600.0, 0.26666666666666666, 0.25],
  [700.0, 0.25, 0.19999999999999998],
  [8200.0, 0.19999999999999998, 0.047619047619047616],
  [36800.0, 0.047619047619047616, 0.25],
  [5800.0, 0.25, 0.037037037037037035],
  [1000.0, 0.037037037037037035, 0.06666666666666667],
  [1800.0, 0.06666666666666667, 0.08333333333333333],
  [24200.0, 0.08333333333333333, 0.030303030303030304],
  [11400.0, 0.030303030303030304, 0.08333333333333333],
  [9200.0, 0.08333333333333333, 0.1111111111111111],
  [13200.0, 0.1111111111111111, 0.05555555555555555],
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
