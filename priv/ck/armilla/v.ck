[
  [92500.0, 0.0, 0.0],
  [42900.0, 0.0, 0.009090909090909092],
  [7900.0, 0.009090909090909092, 0.0202020202020202],
  [68900.0, 0.0202020202020202, 0.03896103896103896],
  [21300.0, 0.03896103896103896, 0.06493506493506494],
  [1000.0, 0.06493506493506494, 0.045454545454545456],
  [120900.0, 0.045454545454545456, 0.06818181818181818],
  [17900.0, 0.06818181818181818, 0.022727272727272728],
  [59500.0, 0.022727272727272728, 0.07272727272727274],
  [25300.0, 0.07272727272727274, 0.06818181818181818],
  [22300.0, 0.06818181818181818, 0.06818181818181818],
  [10800.0, 0.06818181818181818, 0.0404040404040404],
  [56700.0, 0.0404040404040404, 0.018181818181818184],
  [3800.0, 0.018181818181818184, 0.03409090909090909],
  [2400.0, 0.03409090909090909, 0.06818181818181818],
  [14600.0, 0.06818181818181818, 0.0606060606060606],
  [8100.0, 0.0606060606060606, 0.06818181818181818],
  [1500.0, 0.06818181818181818, 0.01515151515151515],
  [7800.0, 0.01515151515151515, 0.07575757575757576],
  [44400.0, 0.07575757575757576, 0.05454545454545454],
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
