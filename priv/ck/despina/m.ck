[
  [14400.0, 0.0, 0.0],
  [28700.0, 0.0, 0.04615384615384615],
  [9000.0, 0.04615384615384615, 0.07692307692307693],
  [24500.0, 0.07692307692307693, 0.04615384615384615],
  [25500.0, 0.04615384615384615, 0.057692307692307696],
  [5500.0, 0.057692307692307696, 0.038461538461538464],
  [27200.0, 0.038461538461538464, 0.03076923076923077],
  [2600.0, 0.03076923076923077, 0.07692307692307693],
  [6400.0, 0.07692307692307693, 0.07692307692307693],
  [400.0, 0.07692307692307693, 0.05384615384615384],
  [27100.0, 0.05384615384615384, 0.06153846153846154],
  [32400.0, 0.06153846153846154, 0.042735042735042736],
  [52700.0, 0.042735042735042736, 0.006993006993006993],
  [1600.0, 0.006993006993006993, 0.04615384615384615],
  [24300.0, 0.04615384615384615, 0.03296703296703297],
  [1300.0, 0.03296703296703297, 0.07692307692307693],
  [5500.0, 0.07692307692307693, 0.038461538461538464],
  [22900.0, 0.038461538461538464, 0.013986013986013986],
  [23300.0, 0.013986013986013986, 0.04615384615384615],
  [2100.0, 0.04615384615384615, 0.04615384615384615],
  [28900.0, 0.04615384615384615, 0.07692307692307693],
  [13000.0, 0.07692307692307693, 0.03296703296703297],
  [2600.0, 0.03296703296703297, 0.07692307692307693],
  [16500.0, 0.07692307692307693, 0.07692307692307693],
  [33900.0, 0.07692307692307693, 0.07692307692307693],
  [7100.0, 0.07692307692307693, 0.01282051282051282],
  [22400.0, 0.01282051282051282, 0.057692307692307696],
  [1800.0, 0.057692307692307696, 0.07692307692307693],
  [9300.0, 0.07692307692307693, 0.07692307692307693],
  [22200.0, 0.07692307692307693, 0.04615384615384615],
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
