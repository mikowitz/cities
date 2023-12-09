[
  [37400.0, 0.0, 0.0],
  [9800.0, 0.0, 0.019230769230769232],
  [27800.0, 0.019230769230769232, 0.04615384615384615],
  [7700.0, 0.04615384615384615, 0.015384615384615385],
  [3300.0, 0.015384615384615385, 0.06410256410256411],
  [26900.0, 0.06410256410256411, 0.03076923076923077],
  [13800.0, 0.03076923076923077, 0.04395604395604395],
  [1700.0, 0.04395604395604395, 0.010989010989010988],
  [1200.0, 0.010989010989010988, 0.054945054945054944],
  [6600.0, 0.054945054945054944, 0.07692307692307693],
  [10000.0, 0.07692307692307693, 0.015384615384615385],
  [5100.0, 0.015384615384615385, 0.008547008547008546],
  [1700.0, 0.008547008547008546, 0.010989010989010988],
  [1200.0, 0.010989010989010988, 0.054945054945054944],
  [32800.0, 0.054945054945054944, 0.07692307692307693],
  [8300.0, 0.07692307692307693, 0.07692307692307693],
  [3500.0, 0.07692307692307693, 0.038461538461538464],
  [13700.0, 0.038461538461538464, 0.01282051282051282],
  [7300.0, 0.01282051282051282, 0.042735042735042736],
  [1300.0, 0.042735042735042736, 0.06153846153846154],
  [2800.0, 0.06153846153846154, 0.02564102564102564],
  [50300.0, 0.02564102564102564, 0.02564102564102564],
  [15300.0, 0.02564102564102564, 0.07692307692307693],
  [13000.0, 0.07692307692307693, 0.07692307692307693],
  [15300.0, 0.07692307692307693, 0.03496503496503496],
  [59000.0, 0.03496503496503496, 0.021978021978021976],
  [1400.0, 0.021978021978021976, 0.07692307692307693],
  [13000.0, 0.07692307692307693, 0.07692307692307693],
  [16600.0, 0.07692307692307693, 0.008547008547008546],
  [14900.0, 0.008547008547008546, 0.07692307692307693],
  [3900.0, 0.07692307692307693, 0.04615384615384615],
  [28700.0, 0.04615384615384615, 0.07692307692307693],
  [39300.0, 0.07692307692307693, 0.07692307692307693],
  [21900.0, 0.07692307692307693, 0.04395604395604395],
  [28100.0, 0.04395604395604395, 0.03496503496503496],
  [38500.0, 0.03496503496503496, 0.009615384615384616],
  [17200.0, 0.009615384615384616, 0.019230769230769232],
  [4000.0, 0.019230769230769232, 0.019230769230769232],
  [5600.0, 0.019230769230769232, 0.008547008547008546],
  [8700.0, 0.008547008547008546, 0.01282051282051282],
  [3300.0, 0.01282051282051282, 0.008547008547008546],
  [4800.0, 0.008547008547008546, 0.07692307692307693],
  [26000.0, 0.07692307692307693, 0.07692307692307693],
  [39300.0, 0.07692307692307693, 0.07692307692307693],
  [400.0, 0.07692307692307693, 0.07692307692307693],
  [5500.0, 0.07692307692307693, 0.015384615384615385],
  [14900.0, 0.015384615384615385, 0.03076923076923077],
  [500.0, 0.03076923076923077, 0.010989010989010988],
  [14700.0, 0.010989010989010988, 0.03296703296703297],
  [4100.0, 0.03296703296703297, 0.054945054945054944],
  [69100.0, 0.054945054945054944, 0.07692307692307693],
  [15100.0, 0.07692307692307693, 0.017094017094017092],
  [39600.0, 0.017094017094017092, 0.07692307692307693],
  [12200.0, 0.07692307692307693, 0.038461538461538464],
  [30500.0, 0.038461538461538464, 0.07692307692307693],
  [10100.0, 0.07692307692307693, 0.010989010989010988],
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
