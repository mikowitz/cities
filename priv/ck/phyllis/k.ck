[
  [72900.0, 0.0, 0.0],
  [35900.0, 0.0, 0.07272727272727274],
  [209700.0, 0.07272727272727274, 0.018181818181818184],
  [68300.0, 0.018181818181818184, 0.06818181818181818],
  [184000.0, 0.06818181818181818, 0.0606060606060606],
  [18500.0, 0.0606060606060606, 0.06818181818181818],
  [21600.0, 0.06818181818181818, 0.09090909090909091],
  [9200.0, 0.09090909090909091, 0.09090909090909091],
  [22700.0, 0.09090909090909091, 0.06818181818181818],
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
