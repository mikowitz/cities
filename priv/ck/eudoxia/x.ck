[
  [2800.0, 0.0, 0.0],
  [62700.0, 0.0, 0.2380952380952381],
  [87400.0, 0.2380952380952381, 0.2380952380952381],
  [100400.0, 0.2380952380952381, 0.09523809523809523],
  [104400.0, 0.09523809523809523, 0.20833333333333334],
  [85900.0, 0.20833333333333334, 0.2380952380952381],
  [139000.0, 0.2380952380952381, 0.2380952380952381],
  [108500.0, 0.2380952380952381, 0.1818181818181818],
  [52700.0, 0.1818181818181818, 0.2380952380952381],
] @=> float fades[][];

Gain g => dac;
0.0 => g.gain;

SinOsc s => Pan2 p => g;
0.78 => p.pan;
2400.0 => s.freq;

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
