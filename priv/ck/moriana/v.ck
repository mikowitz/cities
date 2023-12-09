[
  [3300.0, 0.0, 0.0],
  [5100.0, 0.0, 0.06818181818181818],
  [4600.0, 0.06818181818181818, 0.05454545454545454],
  [70100.0, 0.05454545454545454, 0.06818181818181818],
  [25800.0, 0.06818181818181818, 0.01515151515151515],
  [43100.0, 0.01515151515151515, 0.051948051948051945],
  [1500.0, 0.051948051948051945, 0.06818181818181818],
  [3500.0, 0.06818181818181818, 0.03896103896103896],
  [15500.0, 0.03896103896103896, 0.06818181818181818],
  [57900.0, 0.06818181818181818, 0.022727272727272728],
  [46600.0, 0.022727272727272728, 0.045454545454545456],
  [35000.0, 0.045454545454545456, 0.08264462809917356],
  [35100.0, 0.08264462809917356, 0.03896103896103896],
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