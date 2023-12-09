[
  [1200.0, 0.0, 0.0],
  [9900.0, 0.0, 0.1111111111111111],
  [1700.0, 0.1111111111111111, 0.16666666666666666],
  [7300.0, 0.16666666666666666, 0.08333333333333333],
  [51000.0, 0.08333333333333333, 0.037037037037037035],
  [2400.0, 0.037037037037037035, 0.047619047619047616],
  [5700.0, 0.047619047619047616, 0.047619047619047616],
  [31000.0, 0.047619047619047616, 0.25],
  [4600.0, 0.25, 0.26666666666666666],
  [10000.0, 0.26666666666666666, 0.14285714285714285],
  [4900.0, 0.14285714285714285, 0.08333333333333333],
  [8400.0, 0.08333333333333333, 0.26666666666666666],
  [3100.0, 0.26666666666666666, 0.19047619047619047],
  [4600.0, 0.19047619047619047, 0.08333333333333333],
  [4200.0, 0.08333333333333333, 0.08333333333333333],
  [200.0, 0.08333333333333333, 0.14285714285714285],
  [18900.0, 0.14285714285714285, 0.19047619047619047],
  [2100.0, 0.19047619047619047, 0.1111111111111111],
  [2200.0, 0.1111111111111111, 0.037037037037037035],
  [18400.0, 0.037037037037037035, 0.25925925925925924],
  [7700.0, 0.25925925925925924, 0.1111111111111111],
  [27700.0, 0.1111111111111111, 0.08333333333333333],
  [13100.0, 0.08333333333333333, 0.1111111111111111],
  [8700.0, 0.1111111111111111, 0.14285714285714285],
  [11800.0, 0.14285714285714285, 0.19047619047619047],
  [6800.0, 0.19047619047619047, 0.08333333333333333],
  [58400.0, 0.08333333333333333, 0.25],
  [33000.0, 0.25, 0.26666666666666666],
  [29600.0, 0.26666666666666666, 0.25],
  [4100.0, 0.25, 0.2962962962962963],
  [4100.0, 0.2962962962962963, 0.08333333333333333],
  [10300.0, 0.08333333333333333, 0.041666666666666664],
  [3300.0, 0.041666666666666664, 0.05555555555555555],
  [8200.0, 0.05555555555555555, 0.3333333333333333],
  [35000.0, 0.3333333333333333, 0.047619047619047616],
  [13800.0, 0.047619047619047616, 0.26666666666666666],
  [4200.0, 0.26666666666666666, 0.19047619047619047],
  [6000.0, 0.19047619047619047, 0.08333333333333333],
  [93900.0, 0.08333333333333333, 0.16666666666666666],
  [3900.0, 0.16666666666666666, 0.2222222222222222],
  [12300.0, 0.2222222222222222, 0.26666666666666666],
  [1300.0, 0.26666666666666666, 0.3],
  [7500.0, 0.3, 0.19047619047619047],
  [3400.0, 0.19047619047619047, 0.05555555555555555],
  [19000.0, 0.05555555555555555, 0.25],
  [13700.0, 0.25, 0.09999999999999999],
  [10300.0, 0.09999999999999999, 0.041666666666666664],
  [16500.0, 0.041666666666666664, 0.16666666666666666],
  [9400.0, 0.16666666666666666, 0.041666666666666664],
  [300.0, 0.041666666666666664, 0.13333333333333333],
  [10700.0, 0.13333333333333333, 0.19999999999999998],
  [19100.0, 0.19999999999999998, 0.16666666666666666],
  [1700.0, 0.16666666666666666, 0.08333333333333333],
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
