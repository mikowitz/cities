[
  [32700.0, 0.0, 0.0],
  [52000.0, 0.0, 0.019230769230769232],
  [5500.0, 0.019230769230769232, 0.057692307692307696],
  [75900.0, 0.057692307692307696, 0.03076923076923077],
  [9900.0, 0.03076923076923077, 0.019230769230769232],
  [11400.0, 0.019230769230769232, 0.07692307692307693],
  [17300.0, 0.07692307692307693, 0.019230769230769232],
  [500.0, 0.019230769230769232, 0.07692307692307693],
  [42000.0, 0.07692307692307693, 0.03076923076923077],
  [8500.0, 0.03076923076923077, 0.057692307692307696],
  [16700.0, 0.057692307692307696, 0.057692307692307696],
  [400.0, 0.057692307692307696, 0.07692307692307693],
  [1200.0, 0.07692307692307693, 0.019230769230769232],
  [900.0, 0.019230769230769232, 0.019230769230769232],
  [16500.0, 0.019230769230769232, 0.03076923076923077],
  [4200.0, 0.03076923076923077, 0.06593406593406594],
  [4000.0, 0.06593406593406594, 0.019230769230769232],
  [6600.0, 0.019230769230769232, 0.03296703296703297],
  [39200.0, 0.03296703296703297, 0.07692307692307693],
  [11500.0, 0.07692307692307693, 0.07692307692307693],
  [16000.0, 0.07692307692307693, 0.038461538461538464],
  [6300.0, 0.038461538461538464, 0.009615384615384616],
  [11100.0, 0.009615384615384616, 0.04895104895104895],
  [700.0, 0.04895104895104895, 0.0673076923076923],
  [42300.0, 0.0673076923076923, 0.02564102564102564],
  [14800.0, 0.02564102564102564, 0.03076923076923077],
  [14900.0, 0.03076923076923077, 0.057692307692307696],
  [9600.0, 0.057692307692307696, 0.057692307692307696],
  [10500.0, 0.057692307692307696, 0.028846153846153848],
  [11000.0, 0.028846153846153848, 0.01282051282051282],
  [7600.0, 0.01282051282051282, 0.03076923076923077],
  [7900.0, 0.03076923076923077, 0.02564102564102564],
  [5300.0, 0.02564102564102564, 0.03296703296703297],
  [500.0, 0.03296703296703297, 0.057692307692307696],
  [9200.0, 0.057692307692307696, 0.010989010989010988],
  [10600.0, 0.010989010989010988, 0.07692307692307693],
  [4200.0, 0.07692307692307693, 0.017094017094017092],
  [3100.0, 0.017094017094017092, 0.010989010989010988],
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