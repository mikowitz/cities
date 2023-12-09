[
  [2500.0, 0.0, 0.0],
  [10600.0, 0.0, 0.2],
  [600.0, 0.2, 0.2],
  [1600.0, 0.2, 0.2],
  [95400.0, 0.2, 0.2],
  [2600.0, 0.2, 0.02],
  [13900.0, 0.02, 0.18],
  [33700.0, 0.18, 0.2],
  [22100.0, 0.2, 0.06153846153846154],
  [7500.0, 0.06153846153846154, 0.2],
  [11900.0, 0.2, 0.2],
  [15400.0, 0.2, 0.06666666666666667],
  [7500.0, 0.06666666666666667, 0.2],
  [12800.0, 0.2, 0.2],
  [18400.0, 0.2, 0.06666666666666667],
  [1700.0, 0.06666666666666667, 0.2],
  [700.0, 0.2, 0.2],
  [2500.0, 0.2, 0.2],
  [18100.0, 0.2, 0.11111111111111112],
  [26000.0, 0.11111111111111112, 0.2],
  [30900.0, 0.2, 0.2],
  [2600.0, 0.2, 0.02],
  [10400.0, 0.02, 0.18],
  [24300.0, 0.18, 0.2],
  [11800.0, 0.2, 0.2],
  [15100.0, 0.2, 0.2],
  [6300.0, 0.2, 0.2],
  [1200.0, 0.2, 0.2],
  [2800.0, 0.2, 0.2],
  [12100.0, 0.2, 0.2],
  [2700.0, 0.2, 0.2],
  [2700.0, 0.2, 0.2],
  [4100.0, 0.2, 0.05],
  [87700.0, 0.05, 0.2],
  [48300.0, 0.2, 0.2],
  [58900.0, 0.2, 0.2],
  [5300.0, 0.2, 0.2],
  [12200.0, 0.2, 0.2],
  [6500.0, 0.2, 0.2],
  [2600.0, 0.2, 0.02],
  [13800.0, 0.02, 0.18],
  [2100.0, 0.18, 0.2],
  [2600.0, 0.2, 0.02222222222222222],
  [3600.0, 0.02222222222222222, 0.2],
  [1600.0, 0.2, 0.15],
  [13500.0, 0.15, 0.04],
  [12200.0, 0.04, 0.2],
  [61600.0, 0.2, 0.1],
  [11800.0, 0.1, 0.1],
  [142000.0, 0.1, 0.2],
  [1700.0, 0.2, 0.06666666666666667],
  [15900.0, 0.06666666666666667, 0.04],
  [41300.0, 0.04, 0.2],
  [3200.0, 0.2, 0.2],
  [20500.0, 0.2, 0.15555555555555556],
  [8200.0, 0.15555555555555556, 0.2],
  [12200.0, 0.2, 0.16666666666666669],
  [4000.0, 0.16666666666666669, 0.2],
  [3800.0, 0.2, 0.2],
  [29500.0, 0.2, 0.2],
  [19600.0, 0.2, 0.2],
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
