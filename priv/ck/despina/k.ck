[
  [72300.0, 0.0, 0.0],
  [23300.0, 0.0, 0.01652892561983471],
  [12500.0, 0.01652892561983471, 0.0808080808080808],
  [3400.0, 0.0808080808080808, 0.07272727272727274],
  [3600.0, 0.07272727272727274, 0.07575757575757576],
  [10500.0, 0.07575757575757576, 0.018181818181818184],
  [7500.0, 0.018181818181818184, 0.07575757575757576],
  [56500.0, 0.07575757575757576, 0.06818181818181818],
  [4800.0, 0.06818181818181818, 0.022727272727272728],
  [22100.0, 0.022727272727272728, 0.07575757575757576],
  [15700.0, 0.07575757575757576, 0.07272727272727274],
  [89400.0, 0.07272727272727274, 0.09090909090909091],
  [10500.0, 0.09090909090909091, 0.018181818181818184],
  [7600.0, 0.018181818181818184, 0.07575757575757576],
  [4400.0, 0.07575757575757576, 0.09090909090909091],
  [31400.0, 0.09090909090909091, 0.0606060606060606],
  [34700.0, 0.0606060606060606, 0.045454545454545456],
  [84900.0, 0.045454545454545456, 0.09090909090909091],
] @=> float fades[][];

Gain g => dac;
0.0 => g.gain;

SinOsc s => Pan2 p => g;
-0.19 => p.pan;
1100.0 => s.freq;

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
