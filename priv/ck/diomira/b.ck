[
  [35800.0, 0.0, 0.0],
  [36600.0, 0.0, 0.041666666666666664],
  [6800.0, 0.041666666666666664, 0.03125],
  [21600.0, 0.03125, 0.125],
  [24800.0, 0.125, 0.08333333333333333],
  [62800.0, 0.08333333333333333, 0.19444444444444445],
  [5000.0, 0.19444444444444445, 0.03571428571428571],
  [26000.0, 0.03571428571428571, 0.041666666666666664],
] @=> float fades[][];

Gain g => dac;
0.0 => g.gain;

SinOsc s => Pan2 p => g;
-0.85 => p.pan;
200.0 => s.freq;

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
