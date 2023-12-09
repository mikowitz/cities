[
  [2700.0, 0.0, 0.0],
  [4400.0, 0.0, 0.13333333333333333],
  [2500.0, 0.13333333333333333, 0.2222222222222222],
  [2700.0, 0.2222222222222222, 0.16666666666666666],
  [9200.0, 0.16666666666666666, 0.3333333333333333],
  [6200.0, 0.3333333333333333, 0.19999999999999998],
  [2800.0, 0.19999999999999998, 0.3333333333333333],
  [2200.0, 0.3333333333333333, 0.14285714285714285],
  [8300.0, 0.14285714285714285, 0.2222222222222222],
  [4500.0, 0.2222222222222222, 0.25],
  [8200.0, 0.25, 0.06666666666666667],
  [3100.0, 0.06666666666666667, 0.26666666666666666],
  [3100.0, 0.26666666666666666, 0.3333333333333333],
  [2900.0, 0.3333333333333333, 0.3333333333333333],
  [8700.0, 0.3333333333333333, 0.20833333333333334],
  [2100.0, 0.20833333333333334, 0.3333333333333333],
  [7900.0, 0.3333333333333333, 0.06666666666666667],
  [1700.0, 0.06666666666666667, 0.2777777777777778],
  [2300.0, 0.2777777777777778, 0.06666666666666667],
  [1100.0, 0.06666666666666667, 0.14285714285714285],
  [32400.0, 0.14285714285714285, 0.19047619047619047],
  [7000.0, 0.19047619047619047, 0.25],
  [3600.0, 0.25, 0.08333333333333333],
  [1200.0, 0.08333333333333333, 0.26666666666666666],
  [8700.0, 0.26666666666666666, 0.06666666666666667],
  [10700.0, 0.06666666666666667, 0.20833333333333334],
  [3700.0, 0.20833333333333334, 0.125],
  [4700.0, 0.125, 0.16666666666666666],
  [1600.0, 0.16666666666666666, 0.3333333333333333],
  [7900.0, 0.3333333333333333, 0.037037037037037035],
  [6600.0, 0.037037037037037035, 0.13333333333333333],
  [1500.0, 0.13333333333333333, 0.25],
  [3300.0, 0.25, 0.16666666666666666],
  [5600.0, 0.16666666666666666, 0.25],
  [11800.0, 0.25, 0.13333333333333333],
  [12000.0, 0.13333333333333333, 0.26666666666666666],
  [10700.0, 0.26666666666666666, 0.20833333333333334],
  [1400.0, 0.20833333333333334, 0.3333333333333333],
  [3200.0, 0.3333333333333333, 0.3333333333333333],
  [8900.0, 0.3333333333333333, 0.1111111111111111],
  [1700.0, 0.1111111111111111, 0.3333333333333333],
  [2200.0, 0.3333333333333333, 0.3333333333333333],
] @=> float fades[][];

Gain g => dac;
0.0 => g.gain;

SinOsc s => Pan2 p => g;
0.33 => p.pan;
1800.0 => s.freq;

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