[
  [4400.0, 0.0, 0.0],
  [5100.0, 0.0, 0.03076923076923077],
  [60600.0, 0.03076923076923077, 0.03076923076923077],
  [61700.0, 0.03076923076923077, 0.015384615384615385],
  [26700.0, 0.015384615384615385, 0.038461538461538464],
  [12100.0, 0.038461538461538464, 0.07692307692307693],
  [6800.0, 0.07692307692307693, 0.02564102564102564],
  [64600.0, 0.02564102564102564, 0.019230769230769232],
  [74200.0, 0.019230769230769232, 0.02564102564102564],
  [32000.0, 0.02564102564102564, 0.07692307692307693],
  [5000.0, 0.07692307692307693, 0.07692307692307693],
  [34400.0, 0.07692307692307693, 0.03296703296703297],
  [16400.0, 0.03296703296703297, 0.01282051282051282],
  [33600.0, 0.01282051282051282, 0.07692307692307693],
  [37400.0, 0.07692307692307693, 0.07692307692307693],
  [37300.0, 0.07692307692307693, 0.019230769230769232],
  [13300.0, 0.019230769230769232, 0.03076923076923077],
  [24000.0, 0.03076923076923077, 0.013986013986013986],
  [46800.0, 0.013986013986013986, 0.054945054945054944],
  [4600.0, 0.054945054945054944, 0.019230769230769232],
  [25100.0, 0.019230769230769232, 0.015384615384615385],
  [12500.0, 0.015384615384615385, 0.038461538461538464],
  [21600.0, 0.038461538461538464, 0.04615384615384615],
  [20000.0, 0.04615384615384615, 0.02564102564102564],
  [9300.0, 0.02564102564102564, 0.02564102564102564],
  [19300.0, 0.02564102564102564, 0.038461538461538464],
  [61600.0, 0.038461538461538464, 0.03076923076923077],
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
