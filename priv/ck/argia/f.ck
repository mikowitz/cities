[
  [6600.0, 0.0, 0.0],
  [200.0, 0.0, 0.1111111111111111],
  [2600.0, 0.1111111111111111, 0.14814814814814814],
  [17000.0, 0.14814814814814814, 0.08333333333333333],
  [9700.0, 0.08333333333333333, 0.3333333333333333],
  [38800.0, 0.3333333333333333, 0.05555555555555555],
  [600.0, 0.05555555555555555, 0.26666666666666666],
  [7500.0, 0.26666666666666666, 0.3333333333333333],
  [17400.0, 0.3333333333333333, 0.3333333333333333],
  [59400.0, 0.3333333333333333, 0.3333333333333333],
  [200.0, 0.3333333333333333, 0.2222222222222222],
  [16000.0, 0.2222222222222222, 0.3333333333333333],
  [8700.0, 0.3333333333333333, 0.08333333333333333],
  [52300.0, 0.08333333333333333, 0.3333333333333333],
] @=> float fades[][];

Gain g => dac;
0.0 => g.gain;

SinOsc s => Pan2 p => g;
-0.56 => p.pan;
600.0 => s.freq;

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