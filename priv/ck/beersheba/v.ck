[
  [20700.0, 0.0, 0.0],
  [18300.0, 0.0, 0.051948051948051945],
  [1000.0, 0.051948051948051945, 0.045454545454545456],
  [68200.0, 0.045454545454545456, 0.012987012987012986],
  [66900.0, 0.012987012987012986, 0.0606060606060606],
  [42500.0, 0.0606060606060606, 0.018181818181818184],
  [13000.0, 0.018181818181818184, 0.03896103896103896],
  [27600.0, 0.03896103896103896, 0.07792207792207792],
  [32700.0, 0.07792207792207792, 0.018181818181818184],
  [5900.0, 0.018181818181818184, 0.012987012987012986],
  [35600.0, 0.012987012987012986, 0.03636363636363637],
  [47500.0, 0.03636363636363637, 0.018181818181818184],
  [210300.0, 0.018181818181818184, 0.045454545454545456],
  [13900.0, 0.045454545454545456, 0.08391608391608392],
  [10300.0, 0.08391608391608392, 0.0808080808080808],
  [1800.0, 0.0808080808080808, 0.03636363636363637],
  [41800.0, 0.03636363636363637, 0.045454545454545456],
  [24300.0, 0.045454545454545456, 0.045454545454545456],
  [16900.0, 0.045454545454545456, 0.01515151515151515],
  [55700.0, 0.01515151515151515, 0.01515151515151515],
  [57300.0, 0.01515151515151515, 0.03636363636363637],
  [38600.0, 0.03636363636363637, 0.05454545454545454],
  [57900.0, 0.05454545454545454, 0.051948051948051945],
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
