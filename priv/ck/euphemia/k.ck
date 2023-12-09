[
  [104400.0, 0.0, 0.0],
  [99500.0, 0.0, 0.07272727272727274],
  [85200.0, 0.07272727272727274, 0.018181818181818184],
  [3500.0, 0.018181818181818184, 0.0606060606060606],
  [70700.0, 0.0606060606060606, 0.07272727272727274],
  [14900.0, 0.07272727272727274, 0.022727272727272728],
  [1300.0, 0.022727272727272728, 0.022727272727272728],
  [13200.0, 0.022727272727272728, 0.07272727272727274],
  [1900.0, 0.07272727272727274, 0.07272727272727274],
  [84200.0, 0.07272727272727274, 0.051948051948051945],
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