[
  [1100.0, 0.0, 0.0],
  [400.0, 0.0, 0.028846153846153848],
  [23300.0, 0.028846153846153848, 0.038461538461538464],
  [38100.0, 0.038461538461538464, 0.055944055944055944],
  [42600.0, 0.055944055944055944, 0.042735042735042736],
  [16300.0, 0.042735042735042736, 0.02564102564102564],
  [56700.0, 0.02564102564102564, 0.038461538461538464],
  [4800.0, 0.038461538461538464, 0.06153846153846154],
  [29300.0, 0.06153846153846154, 0.019230769230769232],
  [4900.0, 0.019230769230769232, 0.04395604395604395],
  [600.0, 0.04395604395604395, 0.034188034188034185],
  [34100.0, 0.034188034188034185, 0.05128205128205128],
  [25300.0, 0.05128205128205128, 0.055944055944055944],
  [44100.0, 0.055944055944055944, 0.057692307692307696],
  [39200.0, 0.057692307692307696, 0.015384615384615385],
  [3700.0, 0.015384615384615385, 0.02564102564102564],
  [20100.0, 0.02564102564102564, 0.04615384615384615],
  [7400.0, 0.04615384615384615, 0.07692307692307693],
  [28000.0, 0.07692307692307693, 0.028846153846153848],
  [16700.0, 0.028846153846153848, 0.055944055944055944],
  [2300.0, 0.055944055944055944, 0.019230769230769232],
  [37000.0, 0.019230769230769232, 0.04615384615384615],
  [21200.0, 0.04615384615384615, 0.019230769230769232],
  [3400.0, 0.019230769230769232, 0.009615384615384616],
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
