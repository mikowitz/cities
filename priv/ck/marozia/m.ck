[
  [7700.0, 0.0, 0.0],
  [33800.0, 0.0, 0.009615384615384616],
  [28100.0, 0.009615384615384616, 0.010989010989010988],
  [14300.0, 0.010989010989010988, 0.07692307692307693],
  [4200.0, 0.07692307692307693, 0.07692307692307693],
  [29800.0, 0.07692307692307693, 0.019230769230769232],
  [12000.0, 0.019230769230769232, 0.010989010989010988],
  [400.0, 0.010989010989010988, 0.038461538461538464],
  [12400.0, 0.038461538461538464, 0.05128205128205128],
  [22200.0, 0.05128205128205128, 0.057692307692307696],
  [10600.0, 0.057692307692307696, 0.008547008547008546],
  [23300.0, 0.008547008547008546, 0.057692307692307696],
  [3600.0, 0.057692307692307696, 0.019230769230769232],
  [14600.0, 0.019230769230769232, 0.04615384615384615],
  [7000.0, 0.04615384615384615, 0.07692307692307693],
  [8000.0, 0.07692307692307693, 0.028846153846153848],
  [74000.0, 0.028846153846153848, 0.03076923076923077],
  [1900.0, 0.03076923076923077, 0.057692307692307696],
  [5100.0, 0.057692307692307696, 0.010989010989010988],
  [5200.0, 0.010989010989010988, 0.019230769230769232],
  [1800.0, 0.019230769230769232, 0.057692307692307696],
  [13300.0, 0.057692307692307696, 0.057692307692307696],
  [21000.0, 0.057692307692307696, 0.057692307692307696],
  [26600.0, 0.057692307692307696, 0.05128205128205128],
  [13400.0, 0.05128205128205128, 0.01282051282051282],
  [36400.0, 0.01282051282051282, 0.017094017094017092],
  [30600.0, 0.017094017094017092, 0.055944055944055944],
  [2500.0, 0.055944055944055944, 0.019230769230769232],
  [3700.0, 0.019230769230769232, 0.009615384615384616],
  [65000.0, 0.009615384615384616, 0.03296703296703297],
  [10800.0, 0.03296703296703297, 0.07692307692307693],
  [2700.0, 0.07692307692307693, 0.07692307692307693],
  [19900.0, 0.07692307692307693, 0.028846153846153848],
  [2600.0, 0.028846153846153848, 0.03296703296703297],
  [23800.0, 0.03296703296703297, 0.02564102564102564],
  [9500.0, 0.02564102564102564, 0.06410256410256411],
  [500.0, 0.06410256410256411, 0.01282051282051282],
  [24300.0, 0.01282051282051282, 0.038461538461538464],
  [21200.0, 0.038461538461538464, 0.054945054945054944],
  [16000.0, 0.054945054945054944, 0.019230769230769232],
  [2800.0, 0.019230769230769232, 0.019230769230769232],
  [21200.0, 0.019230769230769232, 0.015384615384615385],
  [10700.0, 0.015384615384615385, 0.05384615384615384],
  [500.0, 0.05384615384615384, 0.020979020979020976],
  [8900.0, 0.020979020979020976, 0.03496503496503496],
  [500.0, 0.03496503496503496, 0.01282051282051282],
  [3100.0, 0.01282051282051282, 0.038461538461538464],
  [21600.0, 0.038461538461538464, 0.010989010989010988],
  [7800.0, 0.010989010989010988, 0.019230769230769232],
  [20300.0, 0.019230769230769232, 0.009615384615384616],
  [23800.0, 0.009615384615384616, 0.010989010989010988],
  [27900.0, 0.010989010989010988, 0.057692307692307696],
  [4300.0, 0.057692307692307696, 0.07692307692307693],
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