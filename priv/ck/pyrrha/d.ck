[
  [14200.0, 0.0, 0.0],
  [12500.0, 0.0, 0.5],
  [1700.0, 0.5, 0.2857142857142857],
  [4100.0, 0.2857142857142857, 0.5],
  [11300.0, 0.5, 0.5],
  [12400.0, 0.5, 0.125],
  [16900.0, 0.125, 0.5],
  [5800.0, 0.5, 0.5],
  [6000.0, 0.5, 0.5],
  [12800.0, 0.5, 0.5],
  [12700.0, 0.5, 0.2],
  [6200.0, 0.2, 0.5],
  [9300.0, 0.5, 0.05555555555555555],
  [12500.0, 0.05555555555555555, 0.5],
  [1900.0, 0.5, 0.4],
  [24400.0, 0.4, 0.16666666666666666],
  [4000.0, 0.16666666666666666, 0.5],
  [8700.0, 0.5, 0.5],
  [8200.0, 0.5, 0.5],
  [6000.0, 0.5, 0.5],
  [18000.0, 0.5, 0.5],
  [200.0, 0.5, 0.25],
  [3500.0, 0.25, 0.3333333333333333],
  [400.0, 0.3333333333333333, 0.5],
  [17700.0, 0.5, 0.125],
  [12600.0, 0.125, 0.5],
  [9400.0, 0.5, 0.5],
  [5500.0, 0.5, 0.5],
  [10600.0, 0.5, 0.5],
  [9200.0, 0.5, 0.5],
  [30900.0, 0.5, 0.5],
  [25200.0, 0.5, 0.5],
  [13500.0, 0.5, 0.125],
  [1500.0, 0.125, 0.5],
  [11700.0, 0.5, 0.5],
  [22600.0, 0.5, 0.5],
  [31500.0, 0.5, 0.5],
  [7400.0, 0.5, 0.5],
  [54500.0, 0.5, 0.2],
  [18700.0, 0.2, 0.5],
  [3900.0, 0.5, 0.05555555555555555],
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
