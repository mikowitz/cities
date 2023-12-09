[
  [400.0, 0.0, 0.0],
  [10800.0, 0.0, 0.2],
  [4500.0, 0.2, 0.3333333333333333],
  [4100.0, 0.3333333333333333, 0.375],
  [24900.0, 0.375, 0.25],
  [12500.0, 0.25, 0.5],
  [3000.0, 0.5, 0.25],
  [1900.0, 0.25, 0.3333333333333333],
  [10700.0, 0.3333333333333333, 0.2],
  [1600.0, 0.2, 0.2],
  [2900.0, 0.2, 0.5],
  [17300.0, 0.5, 0.3333333333333333],
  [2000.0, 0.3333333333333333, 0.5],
  [900.0, 0.5, 0.5],
  [1800.0, 0.5, 0.2],
  [3600.0, 0.2, 0.07142857142857142],
  [4500.0, 0.07142857142857142, 0.08333333333333333],
  [3800.0, 0.08333333333333333, 0.07142857142857142],
  [12300.0, 0.07142857142857142, 0.125],
  [1500.0, 0.125, 0.25],
  [7500.0, 0.25, 0.3333333333333333],
  [8900.0, 0.3333333333333333, 0.5],
  [1600.0, 0.5, 0.4166666666666667],
  [7400.0, 0.4166666666666667, 0.3],
  [6200.0, 0.3, 0.2],
  [2500.0, 0.2, 0.25],
  [2000.0, 0.25, 0.3333333333333333],
  [1600.0, 0.3333333333333333, 0.25],
  [2600.0, 0.25, 0.5],
  [18700.0, 0.5, 0.1],
  [5100.0, 0.1, 0.2777777777777778],
  [5100.0, 0.2777777777777778, 0.25],
  [10700.0, 0.25, 0.2],
  [5200.0, 0.2, 0.35],
  [2700.0, 0.35, 0.5],
  [4300.0, 0.5, 0.3333333333333333],
  [15200.0, 0.3333333333333333, 0.3333333333333333],
  [5400.0, 0.3333333333333333, 0.3333333333333333],
  [2300.0, 0.3333333333333333, 0.3333333333333333],
  [6400.0, 0.3333333333333333, 0.2],
  [8400.0, 0.2, 0.125],
  [10000.0, 0.125, 0.5],
  [8100.0, 0.5, 0.0625],
  [5900.0, 0.0625, 0.3333333333333333],
  [3400.0, 0.3333333333333333, 0.3333333333333333],
  [2100.0, 0.3333333333333333, 0.3333333333333333],
  [3800.0, 0.3333333333333333, 0.16666666666666666],
  [7100.0, 0.16666666666666666, 0.5],
  [2900.0, 0.5, 0.4375],
  [1400.0, 0.4375, 0.3333333333333333],
  [10500.0, 0.3333333333333333, 0.2],
  [9100.0, 0.2, 0.3333333333333333],
  [16500.0, 0.3333333333333333, 0.16666666666666666],
  [4900.0, 0.16666666666666666, 0.3333333333333333],
  [2200.0, 0.3333333333333333, 0.25],
  [4400.0, 0.25, 0.16666666666666666],
  [4300.0, 0.16666666666666666, 0.3333333333333333],
  [8100.0, 0.3333333333333333, 0.3333333333333333],
  [2900.0, 0.3333333333333333, 0.3333333333333333],
  [12200.0, 0.3333333333333333, 0.25],
  [6200.0, 0.25, 0.3333333333333333],
  [11100.0, 0.3333333333333333, 0.3333333333333333],
  [2600.0, 0.3333333333333333, 0.25],
  [4500.0, 0.25, 0.5],
  [2500.0, 0.5, 0.3333333333333333],
  [6200.0, 0.3333333333333333, 0.25],
  [9100.0, 0.25, 0.25],
  [800.0, 0.25, 0.375],
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
