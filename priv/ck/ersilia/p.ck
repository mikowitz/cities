[
  [15400.0, 0.0, 0.0],
  [63200.0, 0.0, 0.46153846153846156],
  [30400.0, 0.46153846153846156, 0.5],
  [31500.0, 0.5, 0.125],
  [300.0, 0.125, 0.1875],
  [14100.0, 0.1875, 0.25],
  [33100.0, 0.25, 0.2857142857142857],
  [7500.0, 0.2857142857142857, 0.1],
  [38600.0, 0.1, 0.1],
  [17500.0, 0.1, 0.07142857142857142],
  [63300.0, 0.07142857142857142, 0.2857142857142857],
  [39100.0, 0.2857142857142857, 0.25],
  [14100.0, 0.25, 0.1],
  [5500.0, 0.1, 0.46153846153846156],
] @=> float fades[][];

Gain g => dac;
0.0 => g.gain;

SinOsc s => Pan2 p => g;
0.19 => p.pan;
1600.0 => s.freq;

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
