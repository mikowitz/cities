[
  [29500.0, 0.0, 0.0],
  [9500.0, 0.0, 0.06818181818181818],
  [2900.0, 0.06818181818181818, 0.03636363636363637],
  [7400.0, 0.03636363636363637, 0.012987012987012986],
  [31000.0, 0.012987012987012986, 0.03636363636363637],
  [90400.0, 0.03636363636363637, 0.0606060606060606],
  [35800.0, 0.0606060606060606, 0.012987012987012986],
  [7600.0, 0.012987012987012986, 0.012987012987012986],
  [11900.0, 0.012987012987012986, 0.06818181818181818],
  [75800.0, 0.06818181818181818, 0.012987012987012986],
  [5200.0, 0.012987012987012986, 0.045454545454545456],
  [77000.0, 0.045454545454545456, 0.06818181818181818],
  [98700.0, 0.06818181818181818, 0.06818181818181818],
  [6100.0, 0.06818181818181818, 0.018181818181818184],
  [44000.0, 0.018181818181818184, 0.03636363636363637],
  [2500.0, 0.03636363636363637, 0.07792207792207792],
  [40300.0, 0.07792207792207792, 0.06818181818181818],
  [48000.0, 0.06818181818181818, 0.045454545454545456],
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