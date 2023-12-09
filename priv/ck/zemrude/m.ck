[
  [2600.0, 0.0, 0.0],
  [12300.0, 0.0, 0.019230769230769232],
  [5600.0, 0.019230769230769232, 0.03296703296703297],
  [26800.0, 0.03296703296703297, 0.07692307692307693],
  [39900.0, 0.07692307692307693, 0.07692307692307693],
  [23900.0, 0.07692307692307693, 0.06153846153846154],
  [40900.0, 0.06153846153846154, 0.010989010989010988],
  [6300.0, 0.010989010989010988, 0.03296703296703297],
  [3800.0, 0.03296703296703297, 0.07692307692307693],
  [500.0, 0.07692307692307693, 0.028846153846153848],
  [12100.0, 0.028846153846153848, 0.04807692307692308],
  [9500.0, 0.04807692307692308, 0.03296703296703297],
  [15500.0, 0.03296703296703297, 0.057692307692307696],
  [8100.0, 0.057692307692307696, 0.010989010989010988],
  [25500.0, 0.010989010989010988, 0.057692307692307696],
  [28700.0, 0.057692307692307696, 0.04615384615384615],
  [11700.0, 0.04615384615384615, 0.07692307692307693],
  [6900.0, 0.07692307692307693, 0.015384615384615385],
  [17200.0, 0.015384615384615385, 0.019230769230769232],
  [26800.0, 0.019230769230769232, 0.028846153846153848],
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
