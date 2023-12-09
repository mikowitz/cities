[
  [2500.0, 0.0, 0.0],
  [72500.0, 0.0, 0.2],
  [28600.0, 0.2, 0.10769230769230768],
  [54500.0, 0.10769230769230768, 0.2],
  [15500.0, 0.2, 0.2],
  [31100.0, 0.2, 0.2],
  [3100.0, 0.2, 0.2],
  [200.0, 0.2, 0.2],
  [3000.0, 0.2, 0.05],
  [24100.0, 0.05, 0.2],
  [9300.0, 0.2, 0.06666666666666667],
  [15500.0, 0.06666666666666667, 0.2],
  [29900.0, 0.2, 0.2],
  [58700.0, 0.2, 0.2],
  [26300.0, 0.2, 0.15],
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
