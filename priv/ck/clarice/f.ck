[
  [38100.0, 0.0, 0.0],
  [12600.0, 0.0, 0.06666666666666667],
  [28000.0, 0.06666666666666667, 0.3333333333333333],
  [2900.0, 0.3333333333333333, 0.05555555555555555],
  [11400.0, 0.05555555555555555, 0.3333333333333333],
  [28400.0, 0.3333333333333333, 0.3333333333333333],
  [1000.0, 0.3333333333333333, 0.2222222222222222],
  [21900.0, 0.2222222222222222, 0.3333333333333333],
  [25300.0, 0.3333333333333333, 0.3333333333333333],
  [27700.0, 0.3333333333333333, 0.08333333333333333],
  [38000.0, 0.08333333333333333, 0.08333333333333333],
  [18900.0, 0.08333333333333333, 0.08333333333333333],
  [200.0, 0.08333333333333333, 0.1111111111111111],
  [19100.0, 0.1111111111111111, 0.14814814814814814],
  [26100.0, 0.14814814814814814, 0.041666666666666664],
  [10600.0, 0.041666666666666664, 0.08333333333333333],
  [8400.0, 0.08333333333333333, 0.1111111111111111],
  [2700.0, 0.1111111111111111, 0.06666666666666667],
  [13200.0, 0.06666666666666667, 0.3333333333333333],
  [24200.0, 0.3333333333333333, 0.3333333333333333],
  [20200.0, 0.3333333333333333, 0.037037037037037035],
  [3400.0, 0.037037037037037035, 0.3333333333333333],
  [20000.0, 0.3333333333333333, 0.05555555555555555],
  [200.0, 0.05555555555555555, 0.1111111111111111],
  [25900.0, 0.1111111111111111, 0.14814814814814814],
  [3500.0, 0.14814814814814814, 0.16666666666666666],
  [4000.0, 0.16666666666666666, 0.3333333333333333],
  [15000.0, 0.3333333333333333, 0.041666666666666664],
  [6100.0, 0.041666666666666664, 0.14583333333333334],
  [23200.0, 0.14583333333333334, 0.08333333333333333],
  [16300.0, 0.08333333333333333, 0.20833333333333334],
  [2800.0, 0.20833333333333334, 0.047619047619047616],
  [20300.0, 0.047619047619047616, 0.08333333333333333],
  [33300.0, 0.08333333333333333, 0.05555555555555555],
  [1200.0, 0.05555555555555555, 0.3333333333333333],
  [18400.0, 0.3333333333333333, 0.06666666666666667],
  [39700.0, 0.06666666666666667, 0.08333333333333333],
  [2800.0, 0.08333333333333333, 0.08333333333333333],
  [19800.0, 0.08333333333333333, 0.3333333333333333],
  [31100.0, 0.3333333333333333, 0.3333333333333333],
  [39100.0, 0.3333333333333333, 0.19047619047619047],
  [25300.0, 0.19047619047619047, 0.1111111111111111],
  [23400.0, 0.1111111111111111, 0.3333333333333333],
  [66400.0, 0.3333333333333333, 0.041666666666666664],
  [200.0, 0.041666666666666664, 0.2222222222222222],
  [8000.0, 0.2222222222222222, 0.3333333333333333],
  [7600.0, 0.3333333333333333, 0.3333333333333333],
  [28300.0, 0.3333333333333333, 0.030303030303030304],
  [8100.0, 0.030303030303030304, 0.3333333333333333],
  [8900.0, 0.3333333333333333, 0.3333333333333333],
  [31200.0, 0.3333333333333333, 0.1111111111111111],
  [11300.0, 0.1111111111111111, 0.08333333333333333],
  [13500.0, 0.08333333333333333, 0.3333333333333333],
  [8000.0, 0.3333333333333333, 0.3333333333333333],
  [11700.0, 0.3333333333333333, 0.3333333333333333],
  [14600.0, 0.3333333333333333, 0.06666666666666667],
  [7700.0, 0.06666666666666667, 0.3333333333333333],
  [21600.0, 0.3333333333333333, 0.2777777777777778],
  [24800.0, 0.2777777777777778, 0.16666666666666666],
  [4200.0, 0.16666666666666666, 0.16666666666666666],
  [12400.0, 0.16666666666666666, 0.05555555555555555],
  [9800.0, 0.05555555555555555, 0.1111111111111111],
  [4900.0, 0.1111111111111111, 0.3333333333333333],
  [25500.0, 0.3333333333333333, 0.19047619047619047],
  [200.0, 0.19047619047619047, 0.19047619047619047],
  [23500.0, 0.19047619047619047, 0.2380952380952381],
  [3100.0, 0.2380952380952381, 0.14814814814814814],
  [12400.0, 0.14814814814814814, 0.3333333333333333],
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