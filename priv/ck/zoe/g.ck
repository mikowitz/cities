[
  [8000.0, 0.0, 0.0],
  [11700.0, 0.0, 0.14285714285714285],
  [3600.0, 0.14285714285714285, 0.14285714285714285],
  [43300.0, 0.14285714285714285, 0.14285714285714285],
  [23300.0, 0.14285714285714285, 0.14285714285714285],
  [24100.0, 0.14285714285714285, 0.10714285714285714],
  [2500.0, 0.10714285714285714, 0.061224489795918366],
  [9400.0, 0.061224489795918366, 0.02040816326530612],
  [5900.0, 0.02040816326530612, 0.14285714285714285],
  [16800.0, 0.14285714285714285, 0.02040816326530612],
  [15700.0, 0.02040816326530612, 0.07692307692307691],
  [56800.0, 0.07692307692307691, 0.10714285714285714],
  [54200.0, 0.10714285714285714, 0.061224489795918366],
  [6200.0, 0.061224489795918366, 0.03571428571428571],
  [48700.0, 0.03571428571428571, 0.1142857142857143],
  [12200.0, 0.1142857142857143, 0.14285714285714285],
  [28400.0, 0.14285714285714285, 0.09090909090909091],
  [70100.0, 0.09090909090909091, 0.09523809523809523],
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