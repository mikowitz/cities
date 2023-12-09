[
  [29300.0, 0.0, 0.0],
  [6900.0, 0.0, 0.010989010989010988],
  [6800.0, 0.010989010989010988, 0.00641025641025641],
  [4300.0, 0.00641025641025641, 0.009615384615384616],
  [29500.0, 0.009615384615384616, 0.02564102564102564],
  [14200.0, 0.02564102564102564, 0.04195804195804195],
  [2600.0, 0.04195804195804195, 0.019230769230769232],
  [36300.0, 0.019230769230769232, 0.015384615384615385],
  [3200.0, 0.015384615384615385, 0.008547008547008546],
  [9400.0, 0.008547008547008546, 0.008547008547008546],
  [51200.0, 0.008547008547008546, 0.06153846153846154],
  [4900.0, 0.06153846153846154, 0.038461538461538464],
  [11700.0, 0.038461538461538464, 0.03076923076923077],
  [20900.0, 0.03076923076923077, 0.07692307692307693],
  [3300.0, 0.07692307692307693, 0.008547008547008546],
  [22700.0, 0.008547008547008546, 0.07692307692307693],
  [91500.0, 0.07692307692307693, 0.057692307692307696],
  [33800.0, 0.057692307692307696, 0.019230769230769232],
  [400.0, 0.019230769230769232, 0.038461538461538464],
  [7500.0, 0.038461538461538464, 0.05128205128205128],
  [9500.0, 0.05128205128205128, 0.07692307692307693],
  [14100.0, 0.07692307692307693, 0.038461538461538464],
  [7200.0, 0.038461538461538464, 0.020979020979020976],
  [2500.0, 0.020979020979020976, 0.015384615384615385],
  [40900.0, 0.015384615384615385, 0.07692307692307693],
  [11600.0, 0.07692307692307693, 0.07692307692307693],
  [36200.0, 0.07692307692307693, 0.03076923076923077],
  [13600.0, 0.03076923076923077, 0.04195804195804195],
  [9200.0, 0.04195804195804195, 0.019230769230769232],
  [4400.0, 0.019230769230769232, 0.019230769230769232],
  [14900.0, 0.019230769230769232, 0.038461538461538464],
  [37700.0, 0.038461538461538464, 0.008547008547008546],
  [5400.0, 0.008547008547008546, 0.019230769230769232],
  [6600.0, 0.019230769230769232, 0.019230769230769232],
  [1500.0, 0.019230769230769232, 0.03076923076923077],
  [12500.0, 0.03076923076923077, 0.019230769230769232],
  [14600.0, 0.019230769230769232, 0.038461538461538464],
  [53500.0, 0.038461538461538464, 0.05384615384615384],
  [54500.0, 0.05384615384615384, 0.07692307692307693],
  [2600.0, 0.07692307692307693, 0.03076923076923077],
  [30400.0, 0.03076923076923077, 0.019230769230769232],
  [62200.0, 0.019230769230769232, 0.027972027972027972],
  [7000.0, 0.027972027972027972, 0.04487179487179487],
  [11300.0, 0.04487179487179487, 0.019230769230769232],
  [21800.0, 0.019230769230769232, 0.06410256410256411],
  [22500.0, 0.06410256410256411, 0.07692307692307693],
  [8600.0, 0.07692307692307693, 0.009615384615384616],
  [25500.0, 0.009615384615384616, 0.02564102564102564],
  [2500.0, 0.02564102564102564, 0.07692307692307693],
  [400.0, 0.07692307692307693, 0.021978021978021976],
  [1600.0, 0.021978021978021976, 0.03296703296703297],
  [5300.0, 0.03296703296703297, 0.007692307692307693],
  [400.0, 0.007692307692307693, 0.07692307692307693],
  [23100.0, 0.07692307692307693, 0.038461538461538464],
  [36100.0, 0.038461538461538464, 0.028846153846153848],
  [41700.0, 0.028846153846153848, 0.02564102564102564],
  [400.0, 0.02564102564102564, 0.04395604395604395],
  [6000.0, 0.04395604395604395, 0.054945054945054944],
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
