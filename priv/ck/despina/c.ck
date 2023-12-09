[
  [2700.0, 0.0, 0.0],
  [2900.0, 0.0, 0.1111111111111111],
  [8400.0, 0.1111111111111111, 0.19047619047619047],
  [2100.0, 0.19047619047619047, 0.06666666666666667],
  [5600.0, 0.06666666666666667, 0.08333333333333333],
  [30000.0, 0.08333333333333333, 0.25],
  [18200.0, 0.25, 0.06666666666666667],
  [3100.0, 0.06666666666666667, 0.2222222222222222],
  [3300.0, 0.2222222222222222, 0.15151515151515152],
  [19100.0, 0.15151515151515152, 0.08333333333333333],
  [5100.0, 0.08333333333333333, 0.25925925925925924],
  [3900.0, 0.25925925925925924, 0.041666666666666664],
  [14900.0, 0.041666666666666664, 0.16666666666666666],
  [28800.0, 0.16666666666666666, 0.08333333333333333],
  [57200.0, 0.08333333333333333, 0.08333333333333333],
  [4100.0, 0.08333333333333333, 0.12121212121212122],
  [6900.0, 0.12121212121212122, 0.05555555555555555],
  [6600.0, 0.05555555555555555, 0.19999999999999998],
  [30300.0, 0.19999999999999998, 0.06666666666666667],
  [4500.0, 0.06666666666666667, 0.25],
  [10200.0, 0.25, 0.047619047619047616],
  [9600.0, 0.047619047619047616, 0.03333333333333333],
  [5700.0, 0.03333333333333333, 0.16666666666666666],
  [31200.0, 0.16666666666666666, 0.05555555555555555],
  [11400.0, 0.05555555555555555, 0.2222222222222222],
  [9100.0, 0.2222222222222222, 0.08333333333333333],
  [4600.0, 0.08333333333333333, 0.06666666666666667],
  [9500.0, 0.06666666666666667, 0.25],
  [9700.0, 0.25, 0.047619047619047616],
  [200.0, 0.047619047619047616, 0.2380952380952381],
  [13300.0, 0.2380952380952381, 0.2857142857142857],
  [35100.0, 0.2857142857142857, 0.047619047619047616],
  [2700.0, 0.047619047619047616, 0.2380952380952381],
  [6900.0, 0.2380952380952381, 0.26666666666666666],
  [10500.0, 0.26666666666666666, 0.05555555555555555],
  [26100.0, 0.05555555555555555, 0.19047619047619047],
  [700.0, 0.19047619047619047, 0.25],
  [2900.0, 0.25, 0.08333333333333333],
  [15400.0, 0.08333333333333333, 0.125],
  [15800.0, 0.125, 0.06666666666666667],
  [6800.0, 0.06666666666666667, 0.08333333333333333],
] @=> float fades[][];

Gain g => dac;
0.0 => g.gain;

SinOsc s => Pan2 p => g;
-0.78 => p.pan;
300.0 => s.freq;

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
