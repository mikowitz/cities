[
  [89900.0, 0.0, 0.0],
  [43100.0, 0.0, 0.007352941176470588],
  [11700.0, 0.007352941176470588, 0.008403361344537815],
  [272900.0, 0.008403361344537815, 0.007352941176470588],
] @=> float fades[][];

Gain g => dac;
0.0 => g.gain;

SinOsc s => Pan2 p => g;
0.26 => p.pan;
1700.0 => s.freq;

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
