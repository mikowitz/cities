[
  [2000.0, 0.0, 0.0],
  [5800.0, 0.0, 0.3333333333333333],
  [18400.0, 0.3333333333333333, 0.25],
  [14900.0, 0.25, 0.5],
  [6900.0, 0.5, 0.5],
  [8300.0, 0.5, 0.3333333333333333],
  [2800.0, 0.3333333333333333, 0.2],
  [3100.0, 0.2, 0.3333333333333333],
  [3800.0, 0.3333333333333333, 0.3333333333333333],
  [11000.0, 0.3333333333333333, 0.125],
  [3000.0, 0.125, 0.35714285714285715],
  [3500.0, 0.35714285714285715, 0.16666666666666666],
  [26500.0, 0.16666666666666666, 0.25],
  [5600.0, 0.25, 0.3333333333333333],
  [1700.0, 0.3333333333333333, 0.2],
  [5100.0, 0.2, 0.25],
  [17000.0, 0.25, 0.16666666666666666],
  [5300.0, 0.16666666666666666, 0.3333333333333333],
  [1100.0, 0.3333333333333333, 0.25],
  [22500.0, 0.25, 0.16666666666666666],
  [7500.0, 0.16666666666666666, 0.3333333333333333],
  [900.0, 0.3333333333333333, 0.5],
  [12600.0, 0.5, 0.3333333333333333],
  [8000.0, 0.3333333333333333, 0.15],
  [1800.0, 0.15, 0.14285714285714285],
  [2700.0, 0.14285714285714285, 0.3333333333333333],
  [6100.0, 0.3333333333333333, 0.25],
  [15300.0, 0.25, 0.16666666666666666],
  [7700.0, 0.16666666666666666, 0.16666666666666666],
  [4300.0, 0.16666666666666666, 0.3333333333333333],
  [2600.0, 0.3333333333333333, 0.25],
  [3000.0, 0.25, 0.125],
  [3600.0, 0.125, 0.3333333333333333],
  [4500.0, 0.3333333333333333, 0.3333333333333333],
  [7300.0, 0.3333333333333333, 0.16666666666666666],
  [4100.0, 0.16666666666666666, 0.3333333333333333],
  [600.0, 0.3333333333333333, 0.3333333333333333],
  [2000.0, 0.3333333333333333, 0.125],
  [6000.0, 0.125, 0.5],
  [7800.0, 0.5, 0.3333333333333333],
  [5500.0, 0.3333333333333333, 0.2777777777777778],
  [3000.0, 0.2777777777777778, 0.375],
  [2700.0, 0.375, 0.3333333333333333],
  [8000.0, 0.3333333333333333, 0.3333333333333333],
  [12000.0, 0.3333333333333333, 0.3333333333333333],
  [1600.0, 0.3333333333333333, 0.2],
  [8600.0, 0.2, 0.5],
  [1600.0, 0.5, 0.2],
  [4600.0, 0.2, 0.5],
  [9600.0, 0.5, 0.3333333333333333],
  [1800.0, 0.3333333333333333, 0.25],
  [6900.0, 0.25, 0.2],
  [2300.0, 0.2, 0.5],
  [7400.0, 0.5, 0.3333333333333333],
  [13400.0, 0.3333333333333333, 0.3333333333333333],
  [18100.0, 0.3333333333333333, 0.25],
  [5200.0, 0.25, 0.3333333333333333],
  [7900.0, 0.3333333333333333, 0.25],
  [6500.0, 0.25, 0.25],
  [1100.0, 0.25, 0.3333333333333333],
  [2200.0, 0.3333333333333333, 0.25],
  [22000.0, 0.25, 0.25],
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
