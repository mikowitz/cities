[
  [10400.0, 0.0, 0.0],
  [1900.0, 0.0, 0.4],
  [2800.0, 0.4, 0.5],
  [16600.0, 0.5, 0.5],
  [7100.0, 0.5, 0.5],
  [14800.0, 0.5, 0.2857142857142857],
  [8400.0, 0.2857142857142857, 0.5],
  [8400.0, 0.5, 0.1],
  [20600.0, 0.1, 0.05555555555555555],
  [18800.0, 0.05555555555555555, 0.5],
  [4500.0, 0.5, 0.5],
  [8100.0, 0.5, 0.375],
  [5300.0, 0.375, 0.0625],
  [2400.0, 0.0625, 0.05555555555555555],
  [1000.0, 0.05555555555555555, 0.5],
  [7600.0, 0.5, 0.4],
  [3700.0, 0.4, 0.5],
  [11500.0, 0.5, 0.5],
  [3800.0, 0.5, 0.5],
  [4500.0, 0.5, 0.4],
  [9000.0, 0.4, 0.42857142857142855],
  [1400.0, 0.42857142857142855, 0.5],
  [900.0, 0.5, 0.25],
  [1800.0, 0.25, 0.5],
  [2000.0, 0.5, 0.5],
  [2300.0, 0.5, 0.42857142857142855],
  [1100.0, 0.42857142857142855, 0.5],
  [2500.0, 0.5, 0.5],
  [10100.0, 0.5, 0.05555555555555555],
  [4600.0, 0.05555555555555555, 0.5],
  [3400.0, 0.5, 0.25],
  [1000.0, 0.25, 0.5],
  [300.0, 0.5, 0.3],
  [2400.0, 0.3, 0.5],
  [1800.0, 0.5, 0.125],
  [25900.0, 0.125, 0.09090909090909091],
  [2000.0, 0.09090909090909091, 0.4],
  [2500.0, 0.4, 0.5],
  [2900.0, 0.5, 0.5],
  [2000.0, 0.5, 0.42857142857142855],
  [19400.0, 0.42857142857142855, 0.5],
  [14800.0, 0.5, 0.5],
  [5100.0, 0.5, 0.4],
  [2500.0, 0.4, 0.08333333333333333],
  [4600.0, 0.08333333333333333, 0.08333333333333333],
  [3100.0, 0.08333333333333333, 0.5],
  [3900.0, 0.5, 0.5],
  [2600.0, 0.5, 0.4],
  [5400.0, 0.4, 0.125],
  [200.0, 0.125, 0.5],
  [2700.0, 0.5, 0.125],
  [11800.0, 0.125, 0.5],
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
