[
  [19200.0, 0.0, 0.0],
  [24100.0, 0.0, 0.057692307692307696],
  [6000.0, 0.057692307692307696, 0.057692307692307696],
  [14300.0, 0.057692307692307696, 0.07692307692307693],
  [12100.0, 0.07692307692307693, 0.038461538461538464],
  [7400.0, 0.038461538461538464, 0.07692307692307693],
  [17600.0, 0.07692307692307693, 0.057692307692307696],
  [10800.0, 0.057692307692307696, 0.057692307692307696],
  [6400.0, 0.057692307692307696, 0.057692307692307696],
  [33900.0, 0.057692307692307696, 0.057692307692307696],
  [2600.0, 0.057692307692307696, 0.057692307692307696],
  [28200.0, 0.057692307692307696, 0.057692307692307696],
  [35800.0, 0.057692307692307696, 0.038461538461538464],
  [4600.0, 0.038461538461538464, 0.057692307692307696],
  [6400.0, 0.057692307692307696, 0.057692307692307696],
  [5500.0, 0.057692307692307696, 0.057692307692307696],
  [13100.0, 0.057692307692307696, 0.01282051282051282],
  [14200.0, 0.01282051282051282, 0.06410256410256411],
  [18700.0, 0.06410256410256411, 0.038461538461538464],
  [28800.0, 0.038461538461538464, 0.057692307692307696],
  [8500.0, 0.057692307692307696, 0.057692307692307696],
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
