[
  [1000.0, 0.0, 0.0],
  [7500.0, 0.0, 0.05],
  [49600.0, 0.05, 0.2],
  [44100.0, 0.2, 0.2],
  [2700.0, 0.2, 0.05],
  [14500.0, 0.05, 0.03333333333333333],
  [25200.0, 0.03333333333333333, 0.2],
  [4400.0, 0.2, 0.2],
  [30500.0, 0.2, 0.05],
  [15900.0, 0.05, 0.05],
  [33200.0, 0.05, 0.2],
  [42500.0, 0.2, 0.05],
  [17200.0, 0.05, 0.12],
  [13000.0, 0.12, 0.1],
  [3400.0, 0.1, 0.2],
  [4100.0, 0.2, 0.2],
  [9700.0, 0.2, 0.2],
  [8700.0, 0.2, 0.2],
  [30400.0, 0.2, 0.2],
  [9100.0, 0.2, 0.2],
  [10800.0, 0.2, 0.2],
  [7700.0, 0.2, 0.2],
  [2900.0, 0.2, 0.05],
  [19900.0, 0.05, 0.05],
  [18700.0, 0.05, 0.2],
  [6300.0, 0.2, 0.06666666666666667],
  [23900.0, 0.06666666666666667, 0.2],
  [2700.0, 0.2, 0.2],
  [16500.0, 0.2, 0.2],
  [5500.0, 0.2, 0.2],
  [4700.0, 0.2, 0.2],
  [56100.0, 0.2, 0.2],
  [13200.0, 0.2, 0.2],
  [4000.0, 0.2, 0.05],
  [16100.0, 0.05, 0.2],
  [32500.0, 0.2, 0.2],
  [21100.0, 0.2, 0.2],
  [19700.0, 0.2, 0.2],
  [19800.0, 0.2, 0.2],
  [8700.0, 0.2, 0.2],
  [6400.0, 0.2, 0.13333333333333333],
  [5100.0, 0.13333333333333333, 0.2],
  [20300.0, 0.2, 0.2],
  [600.0, 0.2, 0.2],
  [35500.0, 0.2, 0.2],
  [5800.0, 0.2, 0.2],
  [200.0, 0.2, 0.2],
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