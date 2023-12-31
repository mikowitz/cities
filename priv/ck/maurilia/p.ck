[
  [30900.0, 0.0, 0.0],
  [25700.0, 0.0, 0.125],
  [12700.0, 0.125, 0.1],
  [3700.0, 0.1, 0.1],
  [10200.0, 0.1, 0.3125],
  [5300.0, 0.3125, 0.0625],
  [21200.0, 0.0625, 0.1],
  [300.0, 0.1, 0.25],
  [11400.0, 0.25, 0.3],
  [3900.0, 0.3, 0.08333333333333333],
  [5600.0, 0.08333333333333333, 0.0625],
  [5700.0, 0.0625, 0.08333333333333333],
  [49200.0, 0.08333333333333333, 0.07142857142857142],
  [1800.0, 0.07142857142857142, 0.05],
  [6400.0, 0.05, 0.25],
  [8700.0, 0.25, 0.3],
  [3900.0, 0.3, 0.25],
  [12400.0, 0.25, 0.05],
  [16700.0, 0.05, 0.2],
  [300.0, 0.2, 0.09090909090909091],
  [8800.0, 0.09090909090909091, 0.13636363636363635],
  [10500.0, 0.13636363636363635, 0.125],
  [55000.0, 0.125, 0.05],
  [146500.0, 0.05, 0.3],
  [21800.0, 0.3, 0.08333333333333333],
  [3500.0, 0.08333333333333333, 0.1],
  [38400.0, 0.1, 0.05555555555555555],
  [4900.0, 0.05555555555555555, 0.125],
  [31900.0, 0.125, 0.25],
] @=> float fades[][];

Gain g => dac;
0.0 => g.gain;

SinOsc s => Pan2 p => g;
0.19 => p.pan;
1600.0 => s.freq;

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
