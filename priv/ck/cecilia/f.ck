[
  [8300.0, 0.0, 0.0],
  [15300.0, 0.0, 0.3333333333333333],
  [10800.0, 0.3333333333333333, 0.3333333333333333],
  [25900.0, 0.3333333333333333, 0.3333333333333333],
  [2000.0, 0.3333333333333333, 0.05555555555555555],
  [3800.0, 0.05555555555555555, 0.3333333333333333],
  [20000.0, 0.3333333333333333, 0.047619047619047616],
  [27100.0, 0.047619047619047616, 0.3333333333333333],
  [21600.0, 0.3333333333333333, 0.06666666666666667],
  [21500.0, 0.06666666666666667, 0.3333333333333333],
  [14800.0, 0.3333333333333333, 0.08333333333333333],
  [57100.0, 0.08333333333333333, 0.3333333333333333],
  [17600.0, 0.3333333333333333, 0.3333333333333333],
  [200.0, 0.3333333333333333, 0.2222222222222222],
  [16300.0, 0.2222222222222222, 0.2777777777777778],
  [19000.0, 0.2777777777777778, 0.1111111111111111],
  [12000.0, 0.1111111111111111, 0.08333333333333333],
  [23900.0, 0.08333333333333333, 0.03333333333333333],
  [9300.0, 0.03333333333333333, 0.06666666666666667],
  [44600.0, 0.06666666666666667, 0.3333333333333333],
  [58700.0, 0.3333333333333333, 0.3333333333333333],
  [61000.0, 0.3333333333333333, 0.3333333333333333],
  [6900.0, 0.3333333333333333, 0.1111111111111111],
  [30000.0, 0.1111111111111111, 0.08333333333333333],
  [2200.0, 0.08333333333333333, 0.3333333333333333],
  [2800.0, 0.3333333333333333, 0.16666666666666666],
  [2000.0, 0.16666666666666666, 0.041666666666666664],
  [105300.0, 0.041666666666666664, 0.1111111111111111],
  [1500.0, 0.1111111111111111, 0.1111111111111111],
  [2300.0, 0.1111111111111111, 0.1111111111111111],
  [9600.0, 0.1111111111111111, 0.08333333333333333],
  [36800.0, 0.08333333333333333, 0.25],
  [16100.0, 0.25, 0.3333333333333333],
  [200.0, 0.3333333333333333, 0.19047619047619047],
  [3800.0, 0.19047619047619047, 0.2380952380952381],
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
