[
  [5500.0, 0.0, 0.0],
  [8300.0, 0.0, 0.05],
  [37600.0, 0.05, 0.0625],
  [200.0, 0.0625, 0.5],
  [4000.0, 0.5, 0.045454545454545456],
  [9900.0, 0.045454545454545456, 0.36363636363636365],
  [14100.0, 0.36363636363636365, 0.4],
  [2100.0, 0.4, 0.0625],
  [19600.0, 0.0625, 0.3125],
  [1400.0, 0.3125, 0.2857142857142857],
  [3200.0, 0.2857142857142857, 0.5],
  [3500.0, 0.5, 0.5],
  [1400.0, 0.5, 0.2857142857142857],
  [4400.0, 0.2857142857142857, 0.5],
  [7700.0, 0.5, 0.5],
  [26900.0, 0.5, 0.5],
  [10700.0, 0.5, 0.5],
  [5600.0, 0.5, 0.5],
  [56000.0, 0.5, 0.4],
  [11900.0, 0.4, 0.5],
  [12200.0, 0.5, 0.08333333333333333],
  [32000.0, 0.08333333333333333, 0.5],
  [6800.0, 0.5, 0.5],
  [4500.0, 0.5, 0.5],
  [900.0, 0.5, 0.5],
  [11500.0, 0.5, 0.5],
  [7500.0, 0.5, 0.25],
  [5600.0, 0.25, 0.5],
  [3700.0, 0.5, 0.5],
  [4700.0, 0.5, 0.5],
  [1100.0, 0.5, 0.5],
  [2000.0, 0.5, 0.5],
  [6900.0, 0.5, 0.5],
  [4600.0, 0.5, 0.5],
  [5400.0, 0.5, 0.5],
  [4300.0, 0.5, 0.5],
  [3100.0, 0.5, 0.08333333333333333],
  [13800.0, 0.08333333333333333, 0.5],
  [5800.0, 0.5, 0.5],
  [4800.0, 0.5, 0.5],
  [5000.0, 0.5, 0.08333333333333333],
  [23700.0, 0.08333333333333333, 0.5],
  [11000.0, 0.5, 0.5],
  [2700.0, 0.5, 0.0625],
] @=> float fades[][];

Gain g => dac;
0.0 => g.gain;

SinOsc s => Pan2 p => g;
-0.7 => p.pan;
400.0 => s.freq;

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