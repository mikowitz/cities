[
  [40700.0, 0.0, 0.0],
  [30400.0, 0.0, 0.07692307692307693],
  [25400.0, 0.07692307692307693, 0.019230769230769232],
  [2400.0, 0.019230769230769232, 0.06410256410256411],
  [11400.0, 0.06410256410256411, 0.028846153846153848],
  [2800.0, 0.028846153846153848, 0.03076923076923077],
  [13500.0, 0.03076923076923077, 0.07692307692307693],
  [17600.0, 0.07692307692307693, 0.03076923076923077],
  [3600.0, 0.03076923076923077, 0.038461538461538464],
  [600.0, 0.038461538461538464, 0.07692307692307693],
  [6100.0, 0.07692307692307693, 0.00641025641025641],
  [76800.0, 0.00641025641025641, 0.03296703296703297],
  [17900.0, 0.03296703296703297, 0.03296703296703297],
  [2000.0, 0.03296703296703297, 0.019230769230769232],
  [4400.0, 0.019230769230769232, 0.03296703296703297],
  [1800.0, 0.03296703296703297, 0.057692307692307696],
  [500.0, 0.057692307692307696, 0.057692307692307696],
  [20400.0, 0.057692307692307696, 0.019230769230769232],
  [35300.0, 0.019230769230769232, 0.03076923076923077],
  [59600.0, 0.03076923076923077, 0.057692307692307696],
  [400.0, 0.057692307692307696, 0.07692307692307693],
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
