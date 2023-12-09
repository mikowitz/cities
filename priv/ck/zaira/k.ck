[
  [8500.0, 0.0, 0.0],
  [29800.0, 0.0, 0.01515151515151515],
  [10700.0, 0.01515151515151515, 0.06818181818181818],
  [17000.0, 0.06818181818181818, 0.06818181818181818],
  [14600.0, 0.06818181818181818, 0.022727272727272728],
  [235000.0, 0.022727272727272728, 0.022727272727272728],
  [62200.0, 0.022727272727272728, 0.09090909090909091],
  [14500.0, 0.09090909090909091, 0.09090909090909091],
  [4000.0, 0.09090909090909091, 0.07272727272727274],
  [46000.0, 0.07272727272727274, 0.06818181818181818],
  [60600.0, 0.06818181818181818, 0.06818181818181818],
  [18400.0, 0.06818181818181818, 0.0606060606060606],
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