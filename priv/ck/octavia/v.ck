[
  [5600.0, 0.0, 0.0],
  [7700.0, 0.0, 0.07792207792207792],
  [29500.0, 0.07792207792207792, 0.06493506493506494],
  [2300.0, 0.06493506493506494, 0.045454545454545456],
  [108400.0, 0.045454545454545456, 0.022727272727272728],
  [108000.0, 0.022727272727272728, 0.0606060606060606],
  [7200.0, 0.0606060606060606, 0.045454545454545456],
  [33000.0, 0.045454545454545456, 0.056818181818181816],
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
