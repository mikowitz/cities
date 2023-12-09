[
  [0.0, 0.0, 0.0],
  [81500.0, 0.0, 0.03571428571428571],
  [18400.0, 0.03571428571428571, 0.07792207792207792],
  [23900.0, 0.07792207792207792, 0.14285714285714285],
  [15800.0, 0.14285714285714285, 0.14285714285714285],
  [31500.0, 0.14285714285714285, 0.03571428571428571],
  [25200.0, 0.03571428571428571, 0.14285714285714285],
  [41800.0, 0.14285714285714285, 0.10714285714285714],
  [26500.0, 0.10714285714285714, 0.09090909090909091],
  [36000.0, 0.09090909090909091, 0.028571428571428574],
  [42500.0, 0.028571428571428574, 0.05357142857142857],
  [2300.0, 0.05357142857142857, 0.047619047619047616],
  [9300.0, 0.047619047619047616, 0.14285714285714285],
  [29900.0, 0.14285714285714285, 0.14285714285714285],
  [10100.0, 0.14285714285714285, 0.08163265306122448],
  [19800.0, 0.08163265306122448, 0.12244897959183673],
  [16000.0, 0.12244897959183673, 0.14285714285714285],
  [83300.0, 0.14285714285714285, 0.14285714285714285],
  [15900.0, 0.14285714285714285, 0.07142857142857142],
  [25300.0, 0.07142857142857142, 0.023809523809523808],
  [39700.0, 0.023809523809523808, 0.028571428571428574],
  [41100.0, 0.028571428571428574, 0.03571428571428571],
  [5500.0, 0.03571428571428571, 0.14285714285714285],
  [2400.0, 0.14285714285714285, 0.008403361344537815],
  [6900.0, 0.008403361344537815, 0.05042016806722689],
  [63200.0, 0.05042016806722689, 0.014285714285714287],
  [18000.0, 0.014285714285714287, 0.03571428571428571],
  [4800.0, 0.03571428571428571, 0.047619047619047616],
  [11100.0, 0.047619047619047616, 0.08571428571428572],
  [15800.0, 0.08571428571428572, 0.03571428571428571],
  [20900.0, 0.03571428571428571, 0.08571428571428572],
  [10500.0, 0.08571428571428572, 0.14285714285714285],
  [7900.0, 0.14285714285714285, 0.14285714285714285],
  [5000.0, 0.14285714285714285, 0.14285714285714285],
  [9700.0, 0.14285714285714285, 0.14285714285714285],
  [2700.0, 0.14285714285714285, 0.07142857142857142],
] @=> float fades[][];

Gain g => dac;
0.0 => g.gain;

SinOsc s => Pan2 p => g;
-0.48 => p.pan;
700.0 => s.freq;

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
