[
  [13200.0, 0.0, 0.0],
  [18400.0, 0.0, 0.047619047619047616],
  [25900.0, 0.047619047619047616, 0.08333333333333333],
  [1800.0, 0.08333333333333333, 0.06666666666666667],
  [12400.0, 0.06666666666666667, 0.047619047619047616],
  [28300.0, 0.047619047619047616, 0.1111111111111111],
  [10700.0, 0.1111111111111111, 0.19047619047619047],
  [9700.0, 0.19047619047619047, 0.1111111111111111],
  [24600.0, 0.1111111111111111, 0.030303030303030304],
  [18200.0, 0.030303030303030304, 0.05555555555555555],
  [2200.0, 0.05555555555555555, 0.16666666666666666],
  [4200.0, 0.16666666666666666, 0.26666666666666666],
  [11400.0, 0.26666666666666666, 0.08333333333333333],
  [11400.0, 0.08333333333333333, 0.25],
  [400.0, 0.25, 0.1111111111111111],
  [15400.0, 0.1111111111111111, 0.1851851851851852],
  [26400.0, 0.1851851851851852, 0.26666666666666666],
  [29800.0, 0.26666666666666666, 0.05555555555555555],
  [3400.0, 0.05555555555555555, 0.08333333333333333],
  [7700.0, 0.08333333333333333, 0.041666666666666664],
  [25400.0, 0.041666666666666664, 0.21212121212121213],
  [3100.0, 0.21212121212121213, 0.14814814814814814],
  [5300.0, 0.14814814814814814, 0.041666666666666664],
  [22600.0, 0.041666666666666664, 0.25],
  [700.0, 0.25, 0.26666666666666666],
  [11600.0, 0.26666666666666666, 0.1111111111111111],
  [2900.0, 0.1111111111111111, 0.25],
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