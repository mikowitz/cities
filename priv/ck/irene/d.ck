[
  [17600.0, 0.0, 0.0],
  [16400.0, 0.0, 0.25],
  [5500.0, 0.25, 0.5],
  [11400.0, 0.5, 0.5],
  [3600.0, 0.5, 0.05555555555555555],
  [2200.0, 0.05555555555555555, 0.5],
  [4100.0, 0.5, 0.5],
  [8700.0, 0.5, 0.0625],
  [8100.0, 0.0625, 0.2857142857142857],
  [9200.0, 0.2857142857142857, 0.5],
  [4600.0, 0.5, 0.1],
  [8400.0, 0.1, 0.5],
  [3000.0, 0.5, 0.2857142857142857],
  [18100.0, 0.2857142857142857, 0.2857142857142857],
  [34800.0, 0.2857142857142857, 0.5],
  [11500.0, 0.5, 0.4444444444444444],
  [23500.0, 0.4444444444444444, 0.18181818181818182],
  [2100.0, 0.18181818181818182, 0.125],
  [10000.0, 0.125, 0.5],
  [8300.0, 0.5, 0.5],
  [3700.0, 0.5, 0.1],
  [18000.0, 0.1, 0.5],
  [19800.0, 0.5, 0.25],
  [21500.0, 0.25, 0.3333333333333333],
  [26500.0, 0.3333333333333333, 0.125],
  [5100.0, 0.125, 0.3333333333333333],
  [40300.0, 0.3333333333333333, 0.5],
  [2300.0, 0.5, 0.4],
  [2400.0, 0.4, 0.2857142857142857],
  [5600.0, 0.2857142857142857, 0.125],
  [12400.0, 0.125, 0.5],
  [42400.0, 0.5, 0.5],
  [6900.0, 0.5, 0.25],
  [300.0, 0.25, 0.3888888888888889],
  [1800.0, 0.3888888888888889, 0.5],
  [40700.0, 0.5, 0.0625],
  [6900.0, 0.0625, 0.3125],
  [3500.0, 0.3125, 0.3],
  [800.0, 0.3, 0.5],
  [17200.0, 0.5, 0.05555555555555555],
  [3900.0, 0.05555555555555555, 0.0625],
  [44400.0, 0.0625, 0.5],
  [2900.0, 0.5, 0.5],
  [23700.0, 0.5, 0.5],
  [20300.0, 0.5, 0.5],
  [2500.0, 0.5, 0.0625],
  [11700.0, 0.0625, 0.05555555555555555],
  [6800.0, 0.05555555555555555, 0.42857142857142855],
  [16000.0, 0.42857142857142855, 0.3],
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