[
  [3700.0, 0.0, 0.0],
  [18500.0, 0.0, 0.019230769230769232],
  [4100.0, 0.019230769230769232, 0.019230769230769232],
  [52000.0, 0.019230769230769232, 0.07692307692307693],
  [26900.0, 0.07692307692307693, 0.03296703296703297],
  [21800.0, 0.03296703296703297, 0.05128205128205128],
  [500.0, 0.05128205128205128, 0.010989010989010988],
  [8200.0, 0.010989010989010988, 0.03296703296703297],
  [26300.0, 0.03296703296703297, 0.019230769230769232],
  [6800.0, 0.019230769230769232, 0.019230769230769232],
  [41900.0, 0.019230769230769232, 0.038461538461538464],
  [2700.0, 0.038461538461538464, 0.05982905982905983],
  [4300.0, 0.05982905982905983, 0.019230769230769232],
  [12000.0, 0.019230769230769232, 0.055944055944055944],
  [2200.0, 0.055944055944055944, 0.04615384615384615],
  [14500.0, 0.04615384615384615, 0.038461538461538464],
  [69000.0, 0.038461538461538464, 0.05128205128205128],
  [12100.0, 0.05128205128205128, 0.015384615384615385],
  [17500.0, 0.015384615384615385, 0.019230769230769232],
  [20000.0, 0.019230769230769232, 0.07692307692307693],
  [4400.0, 0.07692307692307693, 0.06593406593406594],
  [22900.0, 0.06593406593406594, 0.00591715976331361],
  [17300.0, 0.00591715976331361, 0.019230769230769232],
  [16000.0, 0.019230769230769232, 0.032051282051282055],
  [51800.0, 0.032051282051282055, 0.07692307692307693],
  [1400.0, 0.07692307692307693, 0.07692307692307693],
  [13500.0, 0.07692307692307693, 0.07692307692307693],
  [28700.0, 0.07692307692307693, 0.03076923076923077],
  [1900.0, 0.03076923076923077, 0.07692307692307693],
  [10800.0, 0.07692307692307693, 0.057692307692307696],
  [5800.0, 0.057692307692307696, 0.04615384615384615],
  [1800.0, 0.04615384615384615, 0.057692307692307696],
  [51800.0, 0.057692307692307696, 0.07692307692307693],
  [6900.0, 0.07692307692307693, 0.057692307692307696],
  [14900.0, 0.057692307692307696, 0.02564102564102564],
  [13500.0, 0.02564102564102564, 0.019230769230769232],
  [22400.0, 0.019230769230769232, 0.019230769230769232],
  [2100.0, 0.019230769230769232, 0.06153846153846154],
  [14200.0, 0.06153846153846154, 0.07692307692307693],
  [17800.0, 0.07692307692307693, 0.054945054945054944],
  [17700.0, 0.054945054945054944, 0.07692307692307693],
  [67000.0, 0.07692307692307693, 0.07692307692307693],
  [37000.0, 0.07692307692307693, 0.03076923076923077],
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