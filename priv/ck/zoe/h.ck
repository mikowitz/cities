[
  [400.0, 0.0, 0.0],
  [2100.0, 0.0, 0.3333333333333333],
  [11400.0, 0.3333333333333333, 0.3333333333333333],
  [6400.0, 0.3333333333333333, 0.3333333333333333],
  [3600.0, 0.3333333333333333, 0.16666666666666666],
  [7100.0, 0.16666666666666666, 0.16666666666666666],
  [1500.0, 0.16666666666666666, 0.25],
  [5500.0, 0.25, 0.3333333333333333],
  [4600.0, 0.3333333333333333, 0.3333333333333333],
  [2700.0, 0.3333333333333333, 0.3333333333333333],
  [1000.0, 0.3333333333333333, 0.3333333333333333],
  [2800.0, 0.3333333333333333, 0.14285714285714285],
  [8400.0, 0.14285714285714285, 0.3333333333333333],
  [29100.0, 0.3333333333333333, 0.3333333333333333],
  [9900.0, 0.3333333333333333, 0.3333333333333333],
  [6800.0, 0.3333333333333333, 0.3333333333333333],
  [6200.0, 0.3333333333333333, 0.16666666666666666],
  [11900.0, 0.16666666666666666, 0.3333333333333333],
  [5500.0, 0.3333333333333333, 0.07142857142857142],
  [11800.0, 0.07142857142857142, 0.3333333333333333],
  [500.0, 0.3333333333333333, 0.5],
  [1400.0, 0.5, 0.1],
  [10600.0, 0.1, 0.25],
  [1100.0, 0.25, 0.4230769230769231],
  [1600.0, 0.4230769230769231, 0.2],
  [2300.0, 0.2, 0.5],
  [6100.0, 0.5, 0.3333333333333333],
  [600.0, 0.3333333333333333, 0.3333333333333333],
  [2000.0, 0.3333333333333333, 0.125],
  [6100.0, 0.125, 0.5],
  [3600.0, 0.5, 0.3333333333333333],
  [4400.0, 0.3333333333333333, 0.3333333333333333],
  [2700.0, 0.3333333333333333, 0.3333333333333333],
  [9200.0, 0.3333333333333333, 0.25],
  [600.0, 0.25, 0.3333333333333333],
  [1500.0, 0.3333333333333333, 0.05],
  [2500.0, 0.05, 0.3],
  [1600.0, 0.3, 0.25],
  [5400.0, 0.25, 0.5],
  [15700.0, 0.5, 0.16666666666666666],
  [8400.0, 0.16666666666666666, 0.2857142857142857],
  [5100.0, 0.2857142857142857, 0.2857142857142857],
  [12800.0, 0.2857142857142857, 0.3333333333333333],
  [13500.0, 0.3333333333333333, 0.25],
  [43800.0, 0.25, 0.25],
  [7300.0, 0.25, 0.3333333333333333],
  [4800.0, 0.3333333333333333, 0.3333333333333333],
  [1200.0, 0.3333333333333333, 0.4],
  [10800.0, 0.4, 0.3333333333333333],
  [2200.0, 0.3333333333333333, 0.16666666666666666],
  [6300.0, 0.16666666666666666, 0.2857142857142857],
  [10600.0, 0.2857142857142857, 0.25],
  [900.0, 0.25, 0.5],
  [4500.0, 0.5, 0.3333333333333333],
  [2700.0, 0.3333333333333333, 0.3333333333333333],
  [3800.0, 0.3333333333333333, 0.3333333333333333],
  [7200.0, 0.3333333333333333, 0.25],
  [7600.0, 0.25, 0.16666666666666666],
  [4300.0, 0.16666666666666666, 0.25],
  [18200.0, 0.25, 0.25],
  [12100.0, 0.25, 0.3333333333333333],
  [1100.0, 0.3333333333333333, 0.3333333333333333],
  [2400.0, 0.3333333333333333, 0.25],
  [4400.0, 0.25, 0.3333333333333333],
  [6700.0, 0.3333333333333333, 0.25],
  [5900.0, 0.25, 0.3333333333333333],
  [3800.0, 0.3333333333333333, 0.3333333333333333],
  [4000.0, 0.3333333333333333, 0.3333333333333333],
  [3400.0, 0.3333333333333333, 0.16666666666666666],
  [600.0, 0.16666666666666666, 0.3333333333333333],
  [2300.0, 0.3333333333333333, 0.125],
] @=> float fades[][];

Gain g => dac;
0.0 => g.gain;

SinOsc s => Pan2 p => g;
-0.41 => p.pan;
800.0 => s.freq;

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