[
  [22200.0, 0.0, 0.0],
  [36700.0, 0.0, 0.028571428571428574],
  [1000.0, 0.028571428571428574, 0.14285714285714285],
  [12200.0, 0.14285714285714285, 0.08571428571428572],
  [7600.0, 0.08571428571428572, 0.14285714285714285],
  [10700.0, 0.14285714285714285, 0.14285714285714285],
  [2200.0, 0.14285714285714285, 0.08163265306122448],
  [34600.0, 0.08163265306122448, 0.14285714285714285],
  [65300.0, 0.14285714285714285, 0.05102040816326531],
  [113600.0, 0.05102040816326531, 0.14285714285714285],
  [600.0, 0.14285714285714285, 0.06722689075630252],
  [23200.0, 0.06722689075630252, 0.07563025210084033],
  [8600.0, 0.07563025210084033, 0.14285714285714285],
  [31500.0, 0.14285714285714285, 0.07142857142857142],
  [2400.0, 0.07142857142857142, 0.08571428571428572],
  [2400.0, 0.08571428571428572, 0.05714285714285715],
] @=> float fades[][];

Gain g => dac;
0.0 => g.gain;

SinOsc s => Pan2 p => g;
-0.48 => p.pan;
700.0 => s.freq;

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