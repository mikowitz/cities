[
  [42400.0, 0.0, 0.0],
  [173000.0, 0.0, 0.07575757575757576],
  [80800.0, 0.07575757575757576, 0.06818181818181818],
  [58700.0, 0.06818181818181818, 0.06818181818181818],
  [167900.0, 0.06818181818181818, 0.05454545454545454],
  [9600.0, 0.05454545454545454, 0.0606060606060606],
  [10100.0, 0.0606060606060606, 0.0606060606060606],
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
