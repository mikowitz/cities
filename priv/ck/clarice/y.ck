[
  [9500.0, 0.0, 0.0],
  [8200.0, 0.0, 0.2],
  [6400.0, 0.2, 0.2],
  [9600.0, 0.2, 0.14285714285714285],
  [18600.0, 0.14285714285714285, 0.16666666666666669],
  [11100.0, 0.16666666666666669, 0.2],
  [7000.0, 0.2, 0.16],
  [8100.0, 0.16, 0.2],
  [19400.0, 0.2, 0.2],
  [10300.0, 0.2, 0.2],
  [11300.0, 0.2, 0.2],
  [33300.0, 0.2, 0.2],
  [1200.0, 0.2, 0.2],
  [40100.0, 0.2, 0.2],
  [5300.0, 0.2, 0.2],
  [8200.0, 0.2, 0.2],
  [15000.0, 0.2, 0.06666666666666667],
  [4400.0, 0.06666666666666667, 0.2],
  [50700.0, 0.2, 0.1],
  [4100.0, 0.1, 0.2],
  [89100.0, 0.2, 0.2],
  [24100.0, 0.2, 0.06666666666666667],
  [36300.0, 0.06666666666666667, 0.2],
  [2900.0, 0.2, 0.15],
  [3300.0, 0.15, 0.2],
  [2400.0, 0.2, 0.2],
  [11400.0, 0.2, 0.1],
  [13500.0, 0.1, 0.1125],
  [13800.0, 0.1125, 0.05],
  [33700.0, 0.05, 0.2],
  [24900.0, 0.2, 0.2],
  [7800.0, 0.2, 0.2],
  [27300.0, 0.2, 0.2],
  [5700.0, 0.2, 0.2],
  [8300.0, 0.2, 0.13999999999999999],
  [22800.0, 0.13999999999999999, 0.2],
  [39400.0, 0.2, 0.2],
  [19300.0, 0.2, 0.2],
  [17400.0, 0.2, 0.2],
  [13000.0, 0.2, 0.2],
  [9100.0, 0.2, 0.2],
  [22700.0, 0.2, 0.075],
  [6600.0, 0.075, 0.2],
  [71400.0, 0.2, 0.075],
  [32900.0, 0.075, 0.2],
  [30200.0, 0.2, 0.2],
  [12800.0, 0.2, 0.2],
  [200.0, 0.2, 0.2],
  [119200.0, 0.2, 0.04],
  [24800.0, 0.04, 0.2],
  [8700.0, 0.2, 0.2],
  [53700.0, 0.2, 0.2],
  [11500.0, 0.2, 0.2],
  [2700.0, 0.2, 0.16666666666666669],
  [16900.0, 0.16666666666666669, 0.2],
] @=> float fades[][];

Gain g => dac;
0.0 => g.gain;

SinOsc s => Pan2 p => g;
0.85 => p.pan;
2500.0 => s.freq;

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
