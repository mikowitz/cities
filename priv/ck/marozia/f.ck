[
  [11100.0, 0.0, 0.0],
  [8400.0, 0.0, 0.08333333333333333],
  [3900.0, 0.08333333333333333, 0.3333333333333333],
  [13900.0, 0.3333333333333333, 0.3333333333333333],
  [26100.0, 0.3333333333333333, 0.3333333333333333],
  [4800.0, 0.3333333333333333, 0.3333333333333333],
  [8900.0, 0.3333333333333333, 0.08333333333333333],
  [4600.0, 0.08333333333333333, 0.1111111111111111],
  [800.0, 0.1111111111111111, 0.08333333333333333],
  [4400.0, 0.08333333333333333, 0.08333333333333333],
  [30800.0, 0.08333333333333333, 0.3333333333333333],
  [4800.0, 0.3333333333333333, 0.3333333333333333],
  [24100.0, 0.3333333333333333, 0.1111111111111111],
  [200.0, 0.1111111111111111, 0.2222222222222222],
  [17900.0, 0.2222222222222222, 0.3333333333333333],
  [11300.0, 0.3333333333333333, 0.3333333333333333],
  [6000.0, 0.3333333333333333, 0.1111111111111111],
  [10100.0, 0.1111111111111111, 0.3333333333333333],
  [15800.0, 0.3333333333333333, 0.3333333333333333],
  [42900.0, 0.3333333333333333, 0.08333333333333333],
  [3200.0, 0.08333333333333333, 0.3333333333333333],
  [6000.0, 0.3333333333333333, 0.05555555555555555],
  [12600.0, 0.05555555555555555, 0.1111111111111111],
  [600.0, 0.1111111111111111, 0.25],
  [1800.0, 0.25, 0.06666666666666667],
  [20800.0, 0.06666666666666667, 0.3333333333333333],
  [15400.0, 0.3333333333333333, 0.3333333333333333],
  [5200.0, 0.3333333333333333, 0.13333333333333333],
  [51500.0, 0.13333333333333333, 0.1111111111111111],
  [20500.0, 0.1111111111111111, 0.1111111111111111],
  [30300.0, 0.1111111111111111, 0.3333333333333333],
  [14500.0, 0.3333333333333333, 0.05555555555555555],
  [3700.0, 0.05555555555555555, 0.3333333333333333],
  [200.0, 0.3333333333333333, 0.2222222222222222],
  [4700.0, 0.2222222222222222, 0.3333333333333333],
  [18200.0, 0.3333333333333333, 0.041666666666666664],
  [23800.0, 0.041666666666666664, 0.3333333333333333],
  [200.0, 0.3333333333333333, 0.1111111111111111],
  [47100.0, 0.1111111111111111, 0.14814814814814814],
  [33000.0, 0.14814814814814814, 0.19047619047619047],
  [8000.0, 0.19047619047619047, 0.1111111111111111],
  [7700.0, 0.1111111111111111, 0.1111111111111111],
  [5100.0, 0.1111111111111111, 0.3333333333333333],
  [12100.0, 0.3333333333333333, 0.1111111111111111],
  [25000.0, 0.1111111111111111, 0.3333333333333333],
  [19000.0, 0.3333333333333333, 0.16666666666666666],
  [12200.0, 0.16666666666666666, 0.25925925925925924],
  [33200.0, 0.25925925925925924, 0.3333333333333333],
  [42300.0, 0.3333333333333333, 0.13333333333333333],
  [38900.0, 0.13333333333333333, 0.3333333333333333],
  [40300.0, 0.3333333333333333, 0.3333333333333333],
  [3400.0, 0.3333333333333333, 0.08333333333333333],
  [200.0, 0.08333333333333333, 0.3333333333333333],
  [2800.0, 0.3333333333333333, 0.08333333333333333],
  [2900.0, 0.08333333333333333, 0.06666666666666667],
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
