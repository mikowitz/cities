[
  [3700.0, 0.0, 0.0],
  [52200.0, 0.0, 0.3333333333333333],
  [43100.0, 0.3333333333333333, 0.3333333333333333],
  [2200.0, 0.3333333333333333, 0.3333333333333333],
  [28900.0, 0.3333333333333333, 0.3333333333333333],
  [20000.0, 0.3333333333333333, 0.3333333333333333],
  [13400.0, 0.3333333333333333, 0.3333333333333333],
  [21100.0, 0.3333333333333333, 0.3333333333333333],
  [33800.0, 0.3333333333333333, 0.1111111111111111],
  [2200.0, 0.1111111111111111, 0.06666666666666667],
  [37300.0, 0.06666666666666667, 0.3333333333333333],
  [30200.0, 0.3333333333333333, 0.3333333333333333],
  [25600.0, 0.3333333333333333, 0.08333333333333333],
  [1500.0, 0.08333333333333333, 0.3333333333333333],
  [39200.0, 0.3333333333333333, 0.26666666666666666],
  [21000.0, 0.26666666666666666, 0.08333333333333333],
  [31000.0, 0.08333333333333333, 0.08333333333333333],
  [13800.0, 0.08333333333333333, 0.08333333333333333],
  [5000.0, 0.08333333333333333, 0.3333333333333333],
  [25900.0, 0.3333333333333333, 0.08333333333333333],
  [2800.0, 0.08333333333333333, 0.06666666666666667],
  [16200.0, 0.06666666666666667, 0.08333333333333333],
  [19300.0, 0.08333333333333333, 0.06666666666666667],
  [6900.0, 0.06666666666666667, 0.2857142857142857],
  [5500.0, 0.2857142857142857, 0.3333333333333333],
  [23400.0, 0.3333333333333333, 0.3333333333333333],
  [2100.0, 0.3333333333333333, 0.3333333333333333],
  [7200.0, 0.3333333333333333, 0.3333333333333333],
  [24800.0, 0.3333333333333333, 0.125],
  [12900.0, 0.125, 0.14285714285714285],
  [54900.0, 0.14285714285714285, 0.3333333333333333],
  [12100.0, 0.3333333333333333, 0.030303030303030304],
  [5000.0, 0.030303030303030304, 0.047619047619047616],
  [7100.0, 0.047619047619047616, 0.05555555555555555],
  [21100.0, 0.05555555555555555, 0.08333333333333333],
  [1700.0, 0.08333333333333333, 0.3333333333333333],
  [6800.0, 0.3333333333333333, 0.13333333333333333],
  [14400.0, 0.13333333333333333, 0.1111111111111111],
  [5100.0, 0.1111111111111111, 0.08333333333333333],
  [2100.0, 0.08333333333333333, 0.3333333333333333],
  [12800.0, 0.3333333333333333, 0.3333333333333333],
  [15400.0, 0.3333333333333333, 0.3333333333333333],
  [3700.0, 0.3333333333333333, 0.08333333333333333],
  [13200.0, 0.08333333333333333, 0.3333333333333333],
  [35100.0, 0.3333333333333333, 0.3333333333333333],
  [1400.0, 0.3333333333333333, 0.3333333333333333],
  [200.0, 0.3333333333333333, 0.2857142857142857],
  [5900.0, 0.2857142857142857, 0.3333333333333333],
  [29000.0, 0.3333333333333333, 0.08333333333333333],
  [37900.0, 0.08333333333333333, 0.018518518518518517],
  [9600.0, 0.018518518518518517, 0.1111111111111111],
  [4000.0, 0.1111111111111111, 0.08333333333333333],
  [6700.0, 0.08333333333333333, 0.08333333333333333],
  [5000.0, 0.08333333333333333, 0.3333333333333333],
  [26300.0, 0.3333333333333333, 0.3333333333333333],
] @=> float fades[][];

Gain g => dac;
0.0 => g.gain;

SinOsc s => Pan2 p => g;
-0.56 => p.pan;
600.0 => s.freq;

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