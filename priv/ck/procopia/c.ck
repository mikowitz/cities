[
  [300.0, 0.0, 0.0],
  [4900.0, 0.0, 0.25],
  [10000.0, 0.25, 0.05555555555555555],
  [21800.0, 0.05555555555555555, 0.16666666666666666],
  [12200.0, 0.16666666666666666, 0.26666666666666666],
  [5700.0, 0.26666666666666666, 0.030303030303030304],
  [9100.0, 0.030303030303030304, 0.2222222222222222],
  [9900.0, 0.2222222222222222, 0.047619047619047616],
  [11800.0, 0.047619047619047616, 0.26666666666666666],
  [5800.0, 0.26666666666666666, 0.08333333333333333],
  [3400.0, 0.08333333333333333, 0.26666666666666666],
  [4500.0, 0.26666666666666666, 0.1111111111111111],
  [1600.0, 0.1111111111111111, 0.047619047619047616],
  [11500.0, 0.047619047619047616, 0.19047619047619047],
  [4000.0, 0.19047619047619047, 0.06666666666666667],
  [43600.0, 0.06666666666666667, 0.2857142857142857],
  [2900.0, 0.2857142857142857, 0.06666666666666667],
  [6600.0, 0.06666666666666667, 0.19047619047619047],
  [7600.0, 0.19047619047619047, 0.25],
  [50700.0, 0.25, 0.08333333333333333],
  [15500.0, 0.08333333333333333, 0.25],
  [5400.0, 0.25, 0.047619047619047616],
  [4600.0, 0.047619047619047616, 0.047619047619047616],
  [4900.0, 0.047619047619047616, 0.19999999999999998],
  [10300.0, 0.19999999999999998, 0.1111111111111111],
  [12100.0, 0.1111111111111111, 0.26666666666666666],
  [15000.0, 0.26666666666666666, 0.19047619047619047],
  [1600.0, 0.19047619047619047, 0.047619047619047616],
  [14000.0, 0.047619047619047616, 0.19047619047619047],
  [4800.0, 0.19047619047619047, 0.16666666666666666],
  [12000.0, 0.16666666666666666, 0.05555555555555555],
  [19500.0, 0.05555555555555555, 0.1111111111111111],
  [500.0, 0.1111111111111111, 0.26666666666666666],
  [2200.0, 0.26666666666666666, 0.03333333333333333],
  [4700.0, 0.03333333333333333, 0.19999999999999998],
  [11900.0, 0.19999999999999998, 0.14285714285714285],
  [5800.0, 0.14285714285714285, 0.047619047619047616],
  [21100.0, 0.047619047619047616, 0.08333333333333333],
  [10600.0, 0.08333333333333333, 0.26666666666666666],
  [5900.0, 0.26666666666666666, 0.26666666666666666],
  [8000.0, 0.26666666666666666, 0.08333333333333333],
  [4200.0, 0.08333333333333333, 0.05555555555555555],
  [11800.0, 0.05555555555555555, 0.047619047619047616],
  [1500.0, 0.047619047619047616, 0.1111111111111111],
  [5300.0, 0.1111111111111111, 0.037037037037037035],
  [3900.0, 0.037037037037037035, 0.041666666666666664],
  [7300.0, 0.041666666666666664, 0.26666666666666666],
  [2900.0, 0.26666666666666666, 0.08333333333333333],
  [40600.0, 0.08333333333333333, 0.16666666666666666],
  [800.0, 0.16666666666666666, 0.16666666666666666],
  [5900.0, 0.16666666666666666, 0.047619047619047616],
  [4500.0, 0.047619047619047616, 0.19047619047619047],
  [1600.0, 0.19047619047619047, 0.19047619047619047],
  [35100.0, 0.19047619047619047, 0.06666666666666667],
  [6100.0, 0.06666666666666667, 0.1111111111111111],
  [15000.0, 0.1111111111111111, 0.26666666666666666],
  [14600.0, 0.26666666666666666, 0.047619047619047616],
  [3300.0, 0.047619047619047616, 0.19999999999999998],
  [13600.0, 0.19999999999999998, 0.05555555555555555],
  [13500.0, 0.05555555555555555, 0.25925925925925924],
  [87900.0, 0.25925925925925924, 0.19999999999999998],
  [2200.0, 0.19999999999999998, 0.037037037037037035],
  [8700.0, 0.037037037037037035, 0.1851851851851852],
  [10700.0, 0.1851851851851852, 0.26666666666666666],
  [30400.0, 0.26666666666666666, 0.06666666666666667],
  [1700.0, 0.06666666666666667, 0.14285714285714285],
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