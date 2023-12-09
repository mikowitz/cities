[
  [7800.0, 0.0, 0.0],
  [6300.0, 0.0, 0.15],
  [11700.0, 0.15, 0.06666666666666667],
  [21500.0, 0.06666666666666667, 0.2],
  [27200.0, 0.2, 0.2],
  [21700.0, 0.2, 0.2],
  [18900.0, 0.2, 0.2],
  [11500.0, 0.2, 0.2],
  [18500.0, 0.2, 0.2],
  [9600.0, 0.2, 0.2],
  [1200.0, 0.2, 0.2],
  [8100.0, 0.2, 0.2],
  [7200.0, 0.2, 0.2],
  [6700.0, 0.2, 0.2],
  [10100.0, 0.2, 0.2],
  [25600.0, 0.2, 0.1],
  [11200.0, 0.1, 0.2],
  [12100.0, 0.2, 0.2],
  [20100.0, 0.2, 0.2],
  [5400.0, 0.2, 0.2],
  [33900.0, 0.2, 0.2],
  [10400.0, 0.2, 0.16],
  [5100.0, 0.16, 0.2],
  [600.0, 0.2, 0.2],
  [5900.0, 0.2, 0.2],
  [49700.0, 0.2, 0.2],
  [3400.0, 0.2, 0.2],
  [19300.0, 0.2, 0.2],
  [14700.0, 0.2, 0.2],
  [6400.0, 0.2, 0.17777777777777776],
  [58300.0, 0.17777777777777776, 0.2],
  [1700.0, 0.2, 0.2],
  [4300.0, 0.2, 0.2],
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
