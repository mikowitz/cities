[
  [41400.0, 0.0, 0.0],
  [150200.0, 0.0, 0.06818181818181818],
  [26500.0, 0.06818181818181818, 0.018181818181818184],
  [23700.0, 0.018181818181818184, 0.051948051948051945],
  [40200.0, 0.051948051948051945, 0.09090909090909091],
  [1500.0, 0.09090909090909091, 0.018181818181818184],
  [15400.0, 0.018181818181818184, 0.09090909090909091],
  [38200.0, 0.09090909090909091, 0.051948051948051945],
  [193200.0, 0.051948051948051945, 0.06818181818181818],
] @=> float fades[][];

Gain g => dac;
0.0 => g.gain;

SinOsc s => Pan2 p => g;
-0.19 => p.pan;
1100.0 => s.freq;

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
