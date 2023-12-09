[
  [110300.0, 0.0, 0.0],
  [10300.0, 0.0, 0.2],
  [31000.0, 0.2, 0.2],
  [104800.0, 0.2, 0.2],
  [115200.0, 0.2, 0.2],
  [93000.0, 0.2, 0.2],
  [58300.0, 0.2, 0.1],
  [5500.0, 0.1, 0.03636363636363636],
  [17300.0, 0.03636363636363636, 0.2],
  [11900.0, 0.2, 0.2],
  [16000.0, 0.2, 0.2],
  [14300.0, 0.2, 0.1],
] @=> float fades[][];

Gain g => dac;
0.0 => g.gain;

SinOsc s => Pan2 p => g;
0.85 => p.pan;
2500.0 => s.freq;

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
