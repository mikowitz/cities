[
  [26300.0, 0.0, 0.0],
  [200.0, 0.0, 0.25],
  [14600.0, 0.25, 0.3333333333333333],
  [6900.0, 0.3333333333333333, 0.2333333333333333],
  [200.0, 0.2333333333333333, 0.25],
  [2900.0, 0.25, 0.3333333333333333],
  [20200.0, 0.3333333333333333, 0.25],
  [34400.0, 0.25, 0.3333333333333333],
  [30700.0, 0.3333333333333333, 0.08333333333333333],
  [39400.0, 0.08333333333333333, 0.08333333333333333],
  [2300.0, 0.08333333333333333, 0.26666666666666666],
  [9500.0, 0.26666666666666666, 0.08333333333333333],
  [9100.0, 0.08333333333333333, 0.05555555555555555],
  [200.0, 0.05555555555555555, 0.125],
  [17800.0, 0.125, 0.16666666666666666],
  [8900.0, 0.16666666666666666, 0.08333333333333333],
  [8500.0, 0.08333333333333333, 0.3333333333333333],
  [200.0, 0.3333333333333333, 0.19999999999999998],
  [4400.0, 0.19999999999999998, 0.26666666666666666],
  [7600.0, 0.26666666666666666, 0.30303030303030304],
  [2800.0, 0.30303030303030304, 0.26666666666666666],
  [16700.0, 0.26666666666666666, 0.2777777777777778],
  [19900.0, 0.2777777777777778, 0.2380952380952381],
  [31700.0, 0.2380952380952381, 0.16666666666666666],
  [18600.0, 0.16666666666666666, 0.08333333333333333],
  [16400.0, 0.08333333333333333, 0.08333333333333333],
  [7700.0, 0.08333333333333333, 0.06666666666666667],
  [50600.0, 0.06666666666666667, 0.08333333333333333],
  [2200.0, 0.08333333333333333, 0.2916666666666667],
  [700.0, 0.2916666666666667, 0.09523809523809523],
  [23600.0, 0.09523809523809523, 0.2857142857142857],
  [17100.0, 0.2857142857142857, 0.26666666666666666],
  [11400.0, 0.26666666666666666, 0.26666666666666666],
  [6200.0, 0.26666666666666666, 0.2777777777777778],
  [6200.0, 0.2777777777777778, 0.25],
] @=> float fades[][];

Gain g => dac;
0.0 => g.gain;

SinOsc s => Pan2 p => g;
-0.11 => p.pan;
1200.0 => s.freq;

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
