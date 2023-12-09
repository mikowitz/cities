[
  [4400.0, 0.0, 0.0],
  [44800.0, 0.0, 0.015384615384615385],
  [12500.0, 0.015384615384615385, 0.07692307692307693],
  [20500.0, 0.07692307692307693, 0.07692307692307693],
  [1700.0, 0.07692307692307693, 0.06153846153846154],
  [21500.0, 0.06153846153846154, 0.07692307692307693],
  [23100.0, 0.07692307692307693, 0.03076923076923077],
  [19200.0, 0.03076923076923077, 0.057692307692307696],
  [68200.0, 0.057692307692307696, 0.038461538461538464],
  [29900.0, 0.038461538461538464, 0.019230769230769232],
  [10200.0, 0.019230769230769232, 0.04615384615384615],
  [15700.0, 0.04615384615384615, 0.034188034188034185],
  [16400.0, 0.034188034188034185, 0.03550295857988166],
] @=> float fades[][];

Gain g => dac;
0.0 => g.gain;

SinOsc s => Pan2 p => g;
-0.04 => p.pan;
1300.0 => s.freq;

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