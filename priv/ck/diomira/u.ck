[
  [19400.0, 0.0, 0.0],
  [20200.0, 0.0, 0.07142857142857142],
  [33400.0, 0.07142857142857142, 0.05102040816326531],
  [28100.0, 0.05102040816326531, 0.03571428571428571],
  [4600.0, 0.03571428571428571, 0.047619047619047616],
  [39700.0, 0.047619047619047616, 0.02040816326530612],
  [74000.0, 0.02040816326530612, 0.011904761904761904],
] @=> float fades[][];

Gain g => dac;
0.0 => g.gain;

SinOsc s => Pan2 p => g;
0.56 => p.pan;
2100.0 => s.freq;

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
