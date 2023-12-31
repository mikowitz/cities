[
  [14900.0, 0.0, 0.0],
  [6900.0, 0.0, 0.5],
  [8900.0, 0.5, 0.5],
  [2800.0, 0.5, 0.5],
  [7400.0, 0.5, 0.4],
  [4000.0, 0.4, 0.5],
  [19800.0, 0.5, 0.1111111111111111],
  [1800.0, 0.1111111111111111, 0.2222222222222222],
  [11100.0, 0.2222222222222222, 0.5],
  [26200.0, 0.5, 0.25],
  [4300.0, 0.25, 0.125],
  [19800.0, 0.125, 0.05],
  [2800.0, 0.05, 0.5],
  [35000.0, 0.5, 0.5],
  [6800.0, 0.5, 0.0625],
  [13100.0, 0.0625, 0.1111111111111111],
  [18800.0, 0.1111111111111111, 0.5],
  [2000.0, 0.5, 0.5],
  [32900.0, 0.5, 0.5],
  [5300.0, 0.5, 0.5],
  [2800.0, 0.5, 0.5],
  [34300.0, 0.5, 0.4],
  [1500.0, 0.4, 0.5],
  [4400.0, 0.5, 0.5],
  [7100.0, 0.5, 0.3],
  [3700.0, 0.3, 0.5],
  [4000.0, 0.5, 0.5],
  [1100.0, 0.5, 0.5],
  [10800.0, 0.5, 0.5],
  [200.0, 0.5, 0.2],
  [300.0, 0.2, 0.3],
  [39700.0, 0.3, 0.5],
  [17100.0, 0.5, 0.05555555555555555],
  [1700.0, 0.05555555555555555, 0.5],
  [7900.0, 0.5, 0.3],
  [200.0, 0.3, 0.5],
  [46600.0, 0.5, 0.1],
  [7600.0, 0.1, 0.5],
  [12700.0, 0.5, 0.5],
  [7500.0, 0.5, 0.375],
  [10100.0, 0.375, 0.5],
  [1100.0, 0.5, 0.5],
  [2700.0, 0.5, 0.5],
  [4100.0, 0.5, 0.3333333333333333],
  [28800.0, 0.3333333333333333, 0.5],
  [17700.0, 0.5, 0.5],
  [2800.0, 0.5, 0.5],
  [500.0, 0.5, 0.4],
  [1500.0, 0.4, 0.25],
  [11000.0, 0.25, 0.08333333333333333],
  [11900.0, 0.08333333333333333, 0.05555555555555555],
  [9300.0, 0.05555555555555555, 0.5],
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
