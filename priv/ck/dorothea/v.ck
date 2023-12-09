[
  [40700.0, 0.0, 0.0],
  [40000.0, 0.0, 0.05454545454545454],
  [25800.0, 0.05454545454545454, 0.03409090909090909],
  [96500.0, 0.03409090909090909, 0.05454545454545454],
  [33200.0, 0.05454545454545454, 0.018181818181818184],
  [9800.0, 0.018181818181818184, 0.0606060606060606],
  [107700.0, 0.0606060606060606, 0.06493506493506494],
  [29400.0, 0.06493506493506494, 0.06493506493506494],
  [34500.0, 0.06493506493506494, 0.06493506493506494],
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
