[
  [6600.0, 0.0, 0.0],
  [4500.0, 0.0, 0.2],
  [77400.0, 0.2, 0.06666666666666667],
  [3800.0, 0.06666666666666667, 0.2],
  [37300.0, 0.2, 0.16666666666666669],
  [1300.0, 0.16666666666666669, 0.2],
  [5900.0, 0.2, 0.2],
  [7900.0, 0.2, 0.2],
  [90200.0, 0.2, 0.17142857142857143],
  [25500.0, 0.17142857142857143, 0.2],
  [200.0, 0.2, 0.2],
  [37600.0, 0.2, 0.03333333333333333],
  [1200.0, 0.03333333333333333, 0.2],
  [28200.0, 0.2, 0.2],
  [2000.0, 0.2, 0.2],
  [13000.0, 0.2, 0.2],
  [11600.0, 0.2, 0.2],
  [13000.0, 0.2, 0.2],
  [8700.0, 0.2, 0.1],
  [53200.0, 0.1, 0.2],
  [27000.0, 0.2, 0.2],
  [21300.0, 0.2, 0.06666666666666667],
  [9000.0, 0.06666666666666667, 0.2],
  [8000.0, 0.2, 0.2],
  [24300.0, 0.2, 0.06666666666666667],
  [19300.0, 0.06666666666666667, 0.2],
  [11300.0, 0.2, 0.2],
  [2200.0, 0.2, 0.2],
  [20800.0, 0.2, 0.06666666666666667],
  [2500.0, 0.06666666666666667, 0.2],
  [24000.0, 0.2, 0.06666666666666667],
  [19200.0, 0.06666666666666667, 0.2],
  [3400.0, 0.2, 0.2],
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
