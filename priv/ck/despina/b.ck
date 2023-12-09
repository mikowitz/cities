[
  [3800.0, 0.0, 0.0],
  [6000.0, 0.0, 0.25],
  [3700.0, 0.25, 0.25],
  [34600.0, 0.25, 0.25],
  [16100.0, 0.25, 0.25],
  [39600.0, 0.25, 0.16666666666666666],
  [17200.0, 0.16666666666666666, 0.0625],
  [25000.0, 0.0625, 0.16666666666666666],
  [6700.0, 0.16666666666666666, 0.2],
  [19000.0, 0.2, 0.08333333333333333],
  [4600.0, 0.08333333333333333, 0.3333333333333333],
  [3700.0, 0.3333333333333333, 0.08333333333333333],
  [50500.0, 0.08333333333333333, 0.16666666666666666],
  [1900.0, 0.16666666666666666, 0.1],
  [26000.0, 0.1, 0.07142857142857142],
  [31100.0, 0.07142857142857142, 0.2857142857142857],
  [16800.0, 0.2857142857142857, 0.13636363636363635],
  [21200.0, 0.13636363636363635, 0.07142857142857142],
  [19800.0, 0.07142857142857142, 0.16666666666666666],
  [10900.0, 0.16666666666666666, 0.125],
  [71600.0, 0.125, 0.21428571428571427],
  [14000.0, 0.21428571428571427, 0.0625],
  [41600.0, 0.0625, 0.25],
  [4600.0, 0.25, 0.08333333333333333],
  [5100.0, 0.08333333333333333, 0.07142857142857142],
] @=> float fades[][];

Gain g => dac;
0.0 => g.gain;

SinOsc s => Pan2 p => g;
-0.85 => p.pan;
200.0 => s.freq;

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