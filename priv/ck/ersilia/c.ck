[
  [22100.0, 0.0, 0.0],
  [12200.0, 0.0, 0.06666666666666667],
  [7800.0, 0.06666666666666667, 0.2857142857142857],
  [11000.0, 0.2857142857142857, 0.047619047619047616],
  [5600.0, 0.047619047619047616, 0.26666666666666666],
  [3800.0, 0.26666666666666666, 0.10256410256410257],
  [200.0, 0.10256410256410257, 0.07407407407407407],
  [25900.0, 0.07407407407407407, 0.1111111111111111],
  [7600.0, 0.1111111111111111, 0.2777777777777778],
  [8100.0, 0.2777777777777778, 0.16666666666666666],
  [49800.0, 0.16666666666666666, 0.1111111111111111],
  [47400.0, 0.1111111111111111, 0.047619047619047616],
  [42000.0, 0.047619047619047616, 0.08333333333333333],
  [7400.0, 0.08333333333333333, 0.26666666666666666],
  [62400.0, 0.26666666666666666, 0.047619047619047616],
  [11500.0, 0.047619047619047616, 0.08333333333333333],
  [9800.0, 0.08333333333333333, 0.05555555555555555],
  [12700.0, 0.05555555555555555, 0.26666666666666666],
  [14500.0, 0.26666666666666666, 0.26666666666666666],
  [11800.0, 0.26666666666666666, 0.2222222222222222],
] @=> float fades[][];

Gain g => dac;
0.0 => g.gain;

SinOsc s => Pan2 p => g;
-0.78 => p.pan;
300.0 => s.freq;

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