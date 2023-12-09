[
  [22200.0, 0.0, 0.0],
  [31000.0, 0.0, 0.16666666666666666],
  [22100.0, 0.16666666666666666, 0.3333333333333333],
  [18900.0, 0.3333333333333333, 0.19047619047619047],
  [200.0, 0.19047619047619047, 0.3333333333333333],
  [7600.0, 0.3333333333333333, 0.041666666666666664],
  [23600.0, 0.041666666666666664, 0.047619047619047616],
  [25000.0, 0.047619047619047616, 0.3333333333333333],
  [21800.0, 0.3333333333333333, 0.08333333333333333],
  [25700.0, 0.08333333333333333, 0.3333333333333333],
  [20900.0, 0.3333333333333333, 0.16666666666666666],
  [5800.0, 0.16666666666666666, 0.3333333333333333],
  [13400.0, 0.3333333333333333, 0.3333333333333333],
  [8800.0, 0.3333333333333333, 0.3333333333333333],
  [2900.0, 0.3333333333333333, 0.3333333333333333],
  [11500.0, 0.3333333333333333, 0.3333333333333333],
  [200.0, 0.3333333333333333, 0.16666666666666666],
  [4200.0, 0.16666666666666666, 0.2222222222222222],
  [13400.0, 0.2222222222222222, 0.3333333333333333],
  [23600.0, 0.3333333333333333, 0.3333333333333333],
  [10800.0, 0.3333333333333333, 0.3333333333333333],
  [12600.0, 0.3333333333333333, 0.3333333333333333],
  [5700.0, 0.3333333333333333, 0.3333333333333333],
  [8200.0, 0.3333333333333333, 0.3333333333333333],
  [4100.0, 0.3333333333333333, 0.1111111111111111],
  [1500.0, 0.1111111111111111, 0.26666666666666666],
  [18700.0, 0.26666666666666666, 0.3333333333333333],
  [2600.0, 0.3333333333333333, 0.08333333333333333],
  [2800.0, 0.08333333333333333, 0.25],
  [12300.0, 0.25, 0.14285714285714285],
  [21500.0, 0.14285714285714285, 0.3333333333333333],
  [39700.0, 0.3333333333333333, 0.3333333333333333],
  [30700.0, 0.3333333333333333, 0.3333333333333333],
  [800.0, 0.3333333333333333, 0.08333333333333333],
  [16900.0, 0.08333333333333333, 0.3333333333333333],
  [8500.0, 0.3333333333333333, 0.3333333333333333],
  [200.0, 0.3333333333333333, 0.1111111111111111],
  [5400.0, 0.1111111111111111, 0.14814814814814814],
  [9300.0, 0.14814814814814814, 0.3333333333333333],
  [9200.0, 0.3333333333333333, 0.3333333333333333],
  [23800.0, 0.3333333333333333, 0.3333333333333333],
  [14600.0, 0.3333333333333333, 0.037037037037037035],
  [7000.0, 0.037037037037037035, 0.08333333333333333],
  [6200.0, 0.08333333333333333, 0.3333333333333333],
  [9600.0, 0.3333333333333333, 0.3333333333333333],
  [16200.0, 0.3333333333333333, 0.037037037037037035],
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
