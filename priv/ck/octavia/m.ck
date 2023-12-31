[
  [5800.0, 0.0, 0.0],
  [16100.0, 0.0, 0.038461538461538464],
  [12400.0, 0.038461538461538464, 0.019230769230769232],
  [59100.0, 0.019230769230769232, 0.008547008547008546],
  [38700.0, 0.008547008547008546, 0.038461538461538464],
  [3300.0, 0.038461538461538464, 0.04395604395604395],
  [47500.0, 0.04395604395604395, 0.06410256410256411],
  [400.0, 0.06410256410256411, 0.028846153846153848],
  [3300.0, 0.028846153846153848, 0.038461538461538464],
  [33200.0, 0.038461538461538464, 0.019230769230769232],
  [20300.0, 0.019230769230769232, 0.020979020979020976],
  [61600.0, 0.020979020979020976, 0.04615384615384615],
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
