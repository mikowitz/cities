[
  [5700.0, 0.0, 0.0],
  [7200.0, 0.0, 0.2],
  [27700.0, 0.2, 0.10769230769230768],
  [1700.0, 0.10769230769230768, 0.15],
  [3400.0, 0.15, 0.05714285714285714],
  [1800.0, 0.05714285714285714, 0.1],
  [3700.0, 0.1, 0.06666666666666667],
  [2300.0, 0.06666666666666667, 0.1],
  [3300.0, 0.1, 0.1],
  [6100.0, 0.1, 0.1],
  [4000.0, 0.1, 0.08888888888888888],
  [9200.0, 0.08888888888888888, 0.2],
  [2800.0, 0.2, 0.11666666666666667],
  [800.0, 0.11666666666666667, 0.1],
  [100.0, 0.1, 0.12],
  [300.0, 0.12, 0.16],
  [4200.0, 0.16, 0.1],
  [12100.0, 0.1, 0.11111111111111112],
  [900.0, 0.11111111111111112, 0.13333333333333333],
  [3200.0, 0.13333333333333333, 0.2],
  [2900.0, 0.2, 0.15],
  [2700.0, 0.15, 0.13333333333333333],
  [300.0, 0.13333333333333333, 0.2],
  [4300.0, 0.2, 0.06666666666666667],
  [11500.0, 0.06666666666666667, 0.12],
  [6600.0, 0.12, 0.06666666666666667],
  [12300.0, 0.06666666666666667, 0.05],
  [6600.0, 0.05, 0.125],
  [1100.0, 0.125, 0.15],
  [14100.0, 0.15, 0.03333333333333333],
  [1800.0, 0.03333333333333333, 0.04444444444444444],
  [1100.0, 0.04444444444444444, 0.15555555555555556],
  [100.0, 0.15555555555555556, 0.08],
  [8100.0, 0.08, 0.12],
  [100.0, 0.12, 0.1],
  [6400.0, 0.1, 0.15],
  [7800.0, 0.15, 0.1],
  [14900.0, 0.1, 0.08],
  [10400.0, 0.08, 0.1],
  [23700.0, 0.1, 0.05714285714285714],
  [8300.0, 0.05714285714285714, 0.1],
  [3100.0, 0.1, 0.08],
  [900.0, 0.08, 0.2],
  [1500.0, 0.2, 0.1],
  [7200.0, 0.1, 0.05714285714285714],
  [8200.0, 0.05714285714285714, 0.1],
  [6700.0, 0.1, 0.04],
  [11200.0, 0.04, 0.17142857142857143],
  [22400.0, 0.17142857142857143, 0.06666666666666667],
  [1400.0, 0.06666666666666667, 0.15555555555555556],
  [4200.0, 0.15555555555555556, 0.1],
  [1100.0, 0.1, 0.13333333333333333],
  [1700.0, 0.13333333333333333, 0.1],
  [5600.0, 0.1, 0.15],
  [2900.0, 0.15, 0.1],
  [5900.0, 0.1, 0.13333333333333333],
  [5900.0, 0.13333333333333333, 0.14285714285714285],
  [800.0, 0.14285714285714285, 0.2],
  [3600.0, 0.2, 0.13333333333333333],
  [2600.0, 0.13333333333333333, 0.14285714285714285],
  [1200.0, 0.14285714285714285, 0.08],
  [8400.0, 0.08, 0.1],
  [5400.0, 0.1, 0.08],
  [8100.0, 0.08, 0.1],
  [6400.0, 0.1, 0.10769230769230768],
  [1600.0, 0.10769230769230768, 0.1],
] @=> float fades[][];

Gain g => dac;
0.0 => g.gain;

SinOsc s => Pan2 p => g;
0.11 => p.pan;
1500.0 => s.freq;

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