[
  [13800.0, 0.0, 0.0],
  [60000.0, 0.0, 0.3333333333333333],
  [52500.0, 0.3333333333333333, 0.1111111111111111],
  [27100.0, 0.1111111111111111, 0.1111111111111111],
  [9800.0, 0.1111111111111111, 0.041666666666666664],
  [1200.0, 0.041666666666666664, 0.3333333333333333],
  [25700.0, 0.3333333333333333, 0.047619047619047616],
  [7000.0, 0.047619047619047616, 0.05555555555555555],
  [8700.0, 0.05555555555555555, 0.3333333333333333],
  [16800.0, 0.3333333333333333, 0.3333333333333333],
  [34100.0, 0.3333333333333333, 0.3333333333333333],
  [13600.0, 0.3333333333333333, 0.3333333333333333],
  [7000.0, 0.3333333333333333, 0.08333333333333333],
  [10000.0, 0.08333333333333333, 0.1111111111111111],
  [2500.0, 0.1111111111111111, 0.025641025641025644],
  [59500.0, 0.025641025641025644, 0.1794871794871795],
  [6700.0, 0.1794871794871795, 0.26666666666666666],
  [66800.0, 0.26666666666666666, 0.3333333333333333],
  [62700.0, 0.3333333333333333, 0.3333333333333333],
  [43100.0, 0.3333333333333333, 0.06666666666666667],
  [9300.0, 0.06666666666666667, 0.08333333333333333],
  [8200.0, 0.08333333333333333, 0.08333333333333333],
  [19800.0, 0.08333333333333333, 0.08333333333333333],
  [22000.0, 0.08333333333333333, 0.1111111111111111],
] @=> float fades[][];

Gain g => dac;
0.0 => g.gain;

SinOsc s => Pan2 p => g;
-0.56 => p.pan;
600.0 => s.freq;

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
