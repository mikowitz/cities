[
  [0.0, 0.0, 0.0],
  [33200.0, 0.0, 0.047619047619047616],
  [8100.0, 0.047619047619047616, 0.16666666666666666],
  [200.0, 0.16666666666666666, 0.2222222222222222],
  [8000.0, 0.2222222222222222, 0.3333333333333333],
  [3300.0, 0.3333333333333333, 0.08333333333333333],
  [3900.0, 0.08333333333333333, 0.3333333333333333],
  [13900.0, 0.3333333333333333, 0.16666666666666666],
  [200.0, 0.16666666666666666, 0.2222222222222222],
  [5800.0, 0.2222222222222222, 0.3333333333333333],
  [200.0, 0.3333333333333333, 0.25],
  [400.0, 0.25, 0.3333333333333333],
  [4100.0, 0.3333333333333333, 0.09523809523809523],
  [12300.0, 0.09523809523809523, 0.20833333333333334],
  [11700.0, 0.20833333333333334, 0.16666666666666666],
  [1400.0, 0.16666666666666666, 0.3333333333333333],
  [39500.0, 0.3333333333333333, 0.19047619047619047],
  [1800.0, 0.19047619047619047, 0.08333333333333333],
  [1700.0, 0.08333333333333333, 0.2222222222222222],
  [2800.0, 0.2222222222222222, 0.06666666666666667],
  [3100.0, 0.06666666666666667, 0.047619047619047616],
  [200.0, 0.047619047619047616, 0.2222222222222222],
  [8100.0, 0.2222222222222222, 0.3333333333333333],
  [200.0, 0.3333333333333333, 0.2222222222222222],
  [17300.0, 0.2222222222222222, 0.2777777777777778],
  [7400.0, 0.2777777777777778, 0.26666666666666666],
  [6500.0, 0.26666666666666666, 0.14285714285714285],
  [9200.0, 0.14285714285714285, 0.06666666666666667],
  [14900.0, 0.06666666666666667, 0.3333333333333333],
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