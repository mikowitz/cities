[
  [19300.0, 0.0, 0.0],
  [49000.0, 0.0, 0.015384615384615385],
  [339400.0, 0.015384615384615385, 0.019230769230769232],
  [12600.0, 0.019230769230769232, 0.015384615384615385],
  [101000.0, 0.015384615384615385, 0.01282051282051282],
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
