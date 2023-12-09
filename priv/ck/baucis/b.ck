[
  [22400.0, 0.0, 0.0],
  [48000.0, 0.0, 0.08333333333333333],
  [12200.0, 0.08333333333333333, 0.2],
  [14600.0, 0.2, 0.5],
  [93500.0, 0.5, 0.22727272727272727],
  [4900.0, 0.22727272727272727, 0.2],
  [3500.0, 0.2, 0.22727272727272727],
  [31200.0, 0.22727272727272727, 0.08333333333333333],
  [31900.0, 0.08333333333333333, 0.08333333333333333],
  [2800.0, 0.08333333333333333, 0.25],
  [3400.0, 0.25, 0.25],
  [18000.0, 0.25, 0.25],
  [1700.0, 0.25, 0.14285714285714285],
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
