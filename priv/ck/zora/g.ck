[
  [16100.0, 0.0, 0.0],
  [12800.0, 0.0, 0.09523809523809523],
  [5600.0, 0.09523809523809523, 0.14285714285714285],
  [23600.0, 0.14285714285714285, 0.09523809523809523],
  [20900.0, 0.09523809523809523, 0.1142857142857143],
  [25700.0, 0.1142857142857143, 0.14285714285714285],
  [17700.0, 0.14285714285714285, 0.14285714285714285],
  [4400.0, 0.14285714285714285, 0.11904761904761905],
  [26200.0, 0.11904761904761905, 0.14285714285714285],
  [11500.0, 0.14285714285714285, 0.03571428571428571],
  [44800.0, 0.03571428571428571, 0.14285714285714285],
  [4100.0, 0.14285714285714285, 0.08571428571428572],
  [6500.0, 0.08571428571428572, 0.08163265306122448],
  [1800.0, 0.08163265306122448, 0.14285714285714285],
  [32000.0, 0.14285714285714285, 0.14285714285714285],
  [19700.0, 0.14285714285714285, 0.14285714285714285],
  [55500.0, 0.14285714285714285, 0.028571428571428574],
  [28300.0, 0.028571428571428574, 0.10714285714285714],
  [20200.0, 0.10714285714285714, 0.11904761904761905],
  [58200.0, 0.11904761904761905, 0.047619047619047616],
  [71600.0, 0.047619047619047616, 0.14285714285714285],
  [6900.0, 0.14285714285714285, 0.05714285714285715],
  [12200.0, 0.05714285714285715, 0.08791208791208792],
  [4000.0, 0.08791208791208792, 0.06349206349206349],
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
