[
  [119300.0, 0.0, 0.0],
  [5700.0, 0.0, 0.08333333333333333],
  [245100.0, 0.08333333333333333, 0.09523809523809523],
  [22000.0, 0.09523809523809523, 0.06060606060606061],
  [312600.0, 0.06060606060606061, 0.05555555555555555],
  [688800.0, 0.05555555555555555, 0.09523809523809523],
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
