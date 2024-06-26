[
  [10400.0, 0.0, 0.0],
  [30500.0, 0.0, 0.05555555555555555],
  [38700.0, 0.05555555555555555, 0.16666666666666666],
  [28900.0, 0.16666666666666666, 0.020833333333333332],
  [4000.0, 0.020833333333333332, 0.16666666666666666],
  [48700.0, 0.16666666666666666, 0.05555555555555555],
  [1200.0, 0.05555555555555555, 0.16666666666666666],
  [3300.0, 0.16666666666666666, 0.041666666666666664],
  [15300.0, 0.041666666666666664, 0.041666666666666664],
  [12800.0, 0.041666666666666664, 0.03333333333333333],
  [25600.0, 0.03333333333333333, 0.08333333333333333],
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
