[
  [36900.0, 0.0, 0.0],
  [54200.0, 0.0, 0.16],
  [9800.0, 0.16, 0.2],
  [17700.0, 0.2, 0.2],
  [17400.0, 0.2, 0.2],
  [40400.0, 0.2, 0.2],
  [16100.0, 0.2, 0.1],
  [1200.0, 0.1, 0.2],
  [13200.0, 0.2, 0.2],
  [10200.0, 0.2, 0.2],
  [10900.0, 0.2, 0.2],
  [31500.0, 0.2, 0.2],
  [9100.0, 0.2, 0.1],
  [29500.0, 0.1, 0.2],
  [18600.0, 0.2, 0.2],
  [14400.0, 0.2, 0.2],
  [21100.0, 0.2, 0.2],
  [105100.0, 0.2, 0.2],
  [7500.0, 0.2, 0.2],
  [3700.0, 0.2, 0.12],
  [4000.0, 0.12, 0.12],
  [41900.0, 0.12, 0.2],
  [5200.0, 0.2, 0.2],
  [36900.0, 0.2, 0.2],
  [21800.0, 0.2, 0.2],
  [3600.0, 0.2, 0.2],
  [33800.0, 0.2, 0.2],
  [10000.0, 0.2, 0.2],
  [73300.0, 0.2, 0.06666666666666667],
  [6200.0, 0.06666666666666667, 0.2],
  [7400.0, 0.2, 0.2],
  [48100.0, 0.2, 0.2],
  [9600.0, 0.2, 0.2],
  [12100.0, 0.2, 0.16],
  [24500.0, 0.16, 0.2],
  [50600.0, 0.2, 0.2],
  [13000.0, 0.2, 0.2],
  [4100.0, 0.2, 0.2],
  [12700.0, 0.2, 0.2],
  [3500.0, 0.2, 0.2],
  [10800.0, 0.2, 0.2],
  [6900.0, 0.2, 0.2],
  [200.0, 0.2, 0.2],
] @=> float fades[][];

Gain g => dac;
0.0 => g.gain;

SinOsc s => Pan2 p => g;
0.85 => p.pan;
2500.0 => s.freq;

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
