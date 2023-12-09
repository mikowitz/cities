[
  [11400.0, 0.0, 0.0],
  [5600.0, 0.0, 0.07692307692307693],
  [6600.0, 0.07692307692307693, 0.06153846153846154],
  [500.0, 0.06153846153846154, 0.009615384615384616],
  [6500.0, 0.009615384615384616, 0.028846153846153848],
  [35900.0, 0.028846153846153848, 0.02564102564102564],
  [5300.0, 0.02564102564102564, 0.057692307692307696],
  [5100.0, 0.057692307692307696, 0.019230769230769232],
  [10400.0, 0.019230769230769232, 0.02564102564102564],
  [17500.0, 0.02564102564102564, 0.05128205128205128],
  [4300.0, 0.05128205128205128, 0.03296703296703297],
  [19200.0, 0.03296703296703297, 0.02564102564102564],
  [2500.0, 0.02564102564102564, 0.057692307692307696],
  [10100.0, 0.057692307692307696, 0.057692307692307696],
  [16900.0, 0.057692307692307696, 0.07692307692307693],
  [9700.0, 0.07692307692307693, 0.02564102564102564],
  [3900.0, 0.02564102564102564, 0.019230769230769232],
  [8200.0, 0.019230769230769232, 0.07692307692307693],
  [2600.0, 0.07692307692307693, 0.07692307692307693],
  [600.0, 0.07692307692307693, 0.06153846153846154],
  [600.0, 0.06153846153846154, 0.038461538461538464],
  [500.0, 0.038461538461538464, 0.01282051282051282],
  [53900.0, 0.01282051282051282, 0.038461538461538464],
  [400.0, 0.038461538461538464, 0.04395604395604395],
  [3900.0, 0.04395604395604395, 0.054945054945054944],
  [7500.0, 0.054945054945054944, 0.04615384615384615],
  [2700.0, 0.04615384615384615, 0.07692307692307693],
  [3000.0, 0.07692307692307693, 0.028846153846153848],
  [5200.0, 0.028846153846153848, 0.038461538461538464],
  [24600.0, 0.038461538461538464, 0.023076923076923075],
  [40800.0, 0.023076923076923075, 0.03076923076923077],
  [14900.0, 0.03076923076923077, 0.04615384615384615],
  [400.0, 0.04615384615384615, 0.07692307692307693],
  [500.0, 0.07692307692307693, 0.01282051282051282],
  [24700.0, 0.01282051282051282, 0.038461538461538464],
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
