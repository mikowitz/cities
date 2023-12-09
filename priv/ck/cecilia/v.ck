[
  [56100.0, 0.0, 0.0],
  [50000.0, 0.0, 0.03896103896103896],
  [16000.0, 0.03896103896103896, 0.051948051948051945],
  [79600.0, 0.051948051948051945, 0.0606060606060606],
  [58200.0, 0.0606060606060606, 0.06818181818181818],
  [12000.0, 0.06818181818181818, 0.06818181818181818],
  [110100.0, 0.06818181818181818, 0.0606060606060606],
  [12400.0, 0.0606060606060606, 0.03636363636363637],
  [7700.0, 0.03636363636363637, 0.06818181818181818],
  [10800.0, 0.06818181818181818, 0.06818181818181818],
  [59300.0, 0.06818181818181818, 0.06818181818181818],
  [71600.0, 0.06818181818181818, 0.06818181818181818],
  [58600.0, 0.06818181818181818, 0.045454545454545456],
  [16800.0, 0.045454545454545456, 0.06818181818181818],
  [7300.0, 0.06818181818181818, 0.06818181818181818],
  [24500.0, 0.06818181818181818, 0.07575757575757576],
  [7300.0, 0.07575757575757576, 0.06818181818181818],
  [13100.0, 0.06818181818181818, 0.06818181818181818],
  [15100.0, 0.06818181818181818, 0.018181818181818184],
  [23800.0, 0.018181818181818184, 0.06818181818181818],
] @=> float fades[][];

Gain g => dac;
0.0 => g.gain;

SinOsc s => Pan2 p => g;
0.63 => p.pan;
2200.0 => s.freq;

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