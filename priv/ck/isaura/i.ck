[
  [0.0, 0.0, 0.0],
  [3700.0, 0.0, 0.05555555555555555],
  [7000.0, 0.05555555555555555, 0.16666666666666666],
  [1700.0, 0.16666666666666666, 0.16666666666666666],
  [2700.0, 0.16666666666666666, 0.25],
  [12000.0, 0.25, 0.16666666666666666],
  [5800.0, 0.16666666666666666, 0.13333333333333333],
  [2600.0, 0.13333333333333333, 0.030303030303030304],
  [3100.0, 0.030303030303030304, 0.1818181818181818],
  [4800.0, 0.1818181818181818, 0.2222222222222222],
  [2700.0, 0.2222222222222222, 0.20833333333333334],
  [9200.0, 0.20833333333333334, 0.16666666666666666],
  [3300.0, 0.16666666666666666, 0.16666666666666666],
  [9000.0, 0.16666666666666666, 0.2380952380952381],
  [9000.0, 0.2380952380952381, 0.16666666666666666],
  [13800.0, 0.16666666666666666, 0.1111111111111111],
  [5200.0, 0.1111111111111111, 0.2380952380952381],
  [2800.0, 0.2380952380952381, 0.2222222222222222],
  [1700.0, 0.2222222222222222, 0.037037037037037035],
  [1200.0, 0.037037037037037035, 0.14814814814814814],
  [5100.0, 0.14814814814814814, 0.2222222222222222],
  [1300.0, 0.2222222222222222, 0.16666666666666666],
  [3100.0, 0.16666666666666666, 0.2333333333333333],
  [1200.0, 0.2333333333333333, 0.09523809523809523],
  [4900.0, 0.09523809523809523, 0.19047619047619047],
  [4700.0, 0.19047619047619047, 0.26666666666666666],
  [4600.0, 0.26666666666666666, 0.16666666666666666],
  [2400.0, 0.16666666666666666, 0.20833333333333334],
  [2500.0, 0.20833333333333334, 0.16666666666666666],
  [4300.0, 0.16666666666666666, 0.16666666666666666],
  [22500.0, 0.16666666666666666, 0.2380952380952381],
  [1500.0, 0.2380952380952381, 0.16666666666666666],
  [2000.0, 0.16666666666666666, 0.25],
  [1600.0, 0.25, 0.19999999999999998],
  [1600.0, 0.19999999999999998, 0.16666666666666666],
  [4700.0, 0.16666666666666666, 0.05555555555555555],
  [5000.0, 0.05555555555555555, 0.13333333333333333],
  [4900.0, 0.13333333333333333, 0.25925925925925924],
  [1100.0, 0.25925925925925924, 0.16666666666666666],
  [4400.0, 0.16666666666666666, 0.16666666666666666],
  [19000.0, 0.16666666666666666, 0.16666666666666666],
  [7600.0, 0.16666666666666666, 0.25925925925925924],
  [1100.0, 0.25925925925925924, 0.16666666666666666],
  [7500.0, 0.16666666666666666, 0.16666666666666666],
  [17300.0, 0.16666666666666666, 0.16666666666666666],
  [4300.0, 0.16666666666666666, 0.16666666666666666],
  [4300.0, 0.16666666666666666, 0.25925925925925924],
  [2800.0, 0.25925925925925924, 0.16666666666666666],
  [6400.0, 0.16666666666666666, 0.06666666666666667],
  [1400.0, 0.06666666666666667, 0.2222222222222222],
  [6600.0, 0.2222222222222222, 0.16666666666666666],
  [5400.0, 0.16666666666666666, 0.16666666666666666],
  [2200.0, 0.16666666666666666, 0.07407407407407407],
  [13000.0, 0.07407407407407407, 0.2222222222222222],
  [1300.0, 0.2222222222222222, 0.1111111111111111],
  [2500.0, 0.1111111111111111, 0.2222222222222222],
  [11900.0, 0.2222222222222222, 0.16666666666666666],
  [1600.0, 0.16666666666666666, 0.125],
  [4400.0, 0.125, 0.25],
  [5500.0, 0.25, 0.16666666666666666],
  [6300.0, 0.16666666666666666, 0.26666666666666666],
  [6000.0, 0.26666666666666666, 0.16666666666666666],
  [12200.0, 0.16666666666666666, 0.16666666666666666],
  [10900.0, 0.16666666666666666, 0.16666666666666666],
  [1800.0, 0.16666666666666666, 0.20833333333333334],
  [9200.0, 0.20833333333333334, 0.13333333333333333],
  [17600.0, 0.13333333333333333, 0.2222222222222222],
  [3800.0, 0.2222222222222222, 0.16666666666666666],
  [2800.0, 0.16666666666666666, 0.25],
  [3900.0, 0.25, 0.05555555555555555],
  [5200.0, 0.05555555555555555, 0.16666666666666666],
  [5300.0, 0.16666666666666666, 0.16666666666666666],
] @=> float fades[][];

Gain g => dac;
0.0 => g.gain;

SinOsc s => Pan2 p => g;
-0.33 => p.pan;
900.0 => s.freq;

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