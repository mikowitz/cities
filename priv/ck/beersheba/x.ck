[
  [24200.0, 0.0, 0.0],
  [103100.0, 0.0, 0.1111111111111111],
  [24600.0, 0.1111111111111111, 0.14285714285714285],
  [62700.0, 0.14285714285714285, 0.14285714285714285],
  [30800.0, 0.14285714285714285, 0.08333333333333333],
  [356200.0, 0.08333333333333333, 0.1111111111111111],
  [137600.0, 0.1111111111111111, 0.07407407407407407],
  [169500.0, 0.07407407407407407, 0.09523809523809523],
] @=> float fades[][];

Gain g => dac;
0.0 => g.gain;

SinOsc s => Pan2 p => g;
0.78 => p.pan;
2400.0 => s.freq;

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
