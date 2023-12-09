[
  [1700.0, 0.0, 0.0],
  [93800.0, 0.0, 0.0404040404040404],
  [112200.0, 0.0404040404040404, 0.03636363636363637],
  [49900.0, 0.03636363636363637, 0.05454545454545454],
  [23800.0, 0.05454545454545454, 0.0404040404040404],
  [85000.0, 0.0404040404040404, 0.03409090909090909],
] @=> float fades[][];

Gain g => dac;
0.0 => g.gain;

SinOsc s => Pan2 p => g;
0.63 => p.pan;
2200.0 => s.freq;

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
