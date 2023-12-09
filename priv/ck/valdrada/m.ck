[
  [130900.0, 0.0, 0.0],
  [45900.0, 0.0, 0.01282051282051282],
  [23900.0, 0.01282051282051282, 0.06153846153846154],
  [37500.0, 0.06153846153846154, 0.010989010989010988],
  [5600.0, 0.010989010989010988, 0.006993006993006993],
  [14000.0, 0.006993006993006993, 0.055944055944055944],
  [12100.0, 0.055944055944055944, 0.02564102564102564],
  [1800.0, 0.02564102564102564, 0.07692307692307693],
  [2700.0, 0.07692307692307693, 0.07692307692307693],
  [7300.0, 0.07692307692307693, 0.04615384615384615],
  [500.0, 0.04615384615384615, 0.01282051282051282],
  [44800.0, 0.01282051282051282, 0.038461538461538464],
  [11600.0, 0.038461538461538464, 0.019230769230769232],
  [20900.0, 0.019230769230769232, 0.008547008547008546],
  [9400.0, 0.008547008547008546, 0.019230769230769232],
  [20000.0, 0.019230769230769232, 0.019230769230769232],
  [10500.0, 0.019230769230769232, 0.019230769230769232],
  [7400.0, 0.019230769230769232, 0.008547008547008546],
  [10000.0, 0.008547008547008546, 0.010989010989010988],
  [8100.0, 0.010989010989010988, 0.008547008547008546],
  [2700.0, 0.008547008547008546, 0.02564102564102564],
  [6100.0, 0.02564102564102564, 0.038461538461538464],
  [6600.0, 0.038461538461538464, 0.01282051282051282],
  [1800.0, 0.01282051282051282, 0.04615384615384615],
  [15500.0, 0.04615384615384615, 0.01282051282051282],
  [12300.0, 0.01282051282051282, 0.04615384615384615],
  [4600.0, 0.04615384615384615, 0.06153846153846154],
  [4700.0, 0.06153846153846154, 0.01282051282051282],
  [9500.0, 0.01282051282051282, 0.008547008547008546],
  [34400.0, 0.008547008547008546, 0.009615384615384616],
  [400.0, 0.009615384615384616, 0.020979020979020976],
  [15800.0, 0.020979020979020976, 0.027972027972027972],
  [1400.0, 0.027972027972027972, 0.07692307692307693],
  [46800.0, 0.07692307692307693, 0.01282051282051282],
  [400.0, 0.01282051282051282, 0.07692307692307693],
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
