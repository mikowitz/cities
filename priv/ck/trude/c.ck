[
  [16300.0, 0.0, 0.0],
  [35000.0, 0.0, 0.06666666666666667],
  [80800.0, 0.06666666666666667, 0.26666666666666666],
  [8000.0, 0.26666666666666666, 0.125],
  [14000.0, 0.125, 0.047619047619047616],
  [55000.0, 0.047619047619047616, 0.08333333333333333],
  [20000.0, 0.08333333333333333, 0.21212121212121213],
  [15500.0, 0.21212121212121213, 0.08333333333333333],
  [45300.0, 0.08333333333333333, 0.1111111111111111],
  [7500.0, 0.1111111111111111, 0.047619047619047616],
  [18200.0, 0.047619047619047616, 0.26666666666666666],
  [2600.0, 0.26666666666666666, 0.047619047619047616],
] @=> float fades[][];

Gain g => dac;
0.0 => g.gain;

SinOsc s => Pan2 p => g;
-0.78 => p.pan;
300.0 => s.freq;

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