[
  [36400.0, 0.0, 0.0],
  [293400.0, 0.0, 0.06153846153846154],
  [72900.0, 0.06153846153846154, 0.01282051282051282],
  [168900.0, 0.01282051282051282, 0.06837606837606837],
  [142600.0, 0.06837606837606837, 0.057692307692307696],
  [38600.0, 0.057692307692307696, 0.054945054945054944],
  [17600.0, 0.054945054945054944, 0.055944055944055944],
] @=> float fades[][];

Gain g => dac;
0.0 => g.gain;

SinOsc s => Pan2 p => g;
0.93 => p.pan;
2600.0 => s.freq;

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
