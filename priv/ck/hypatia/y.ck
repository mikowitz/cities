[
  [35900.0, 0.0, 0.0],
  [1000.0, 0.0, 0.2],
  [23200.0, 0.2, 0.05714285714285714],
  [37000.0, 0.05714285714285714, 0.05714285714285714],
  [29500.0, 0.05714285714285714, 0.04],
  [51400.0, 0.04, 0.1],
  [1300.0, 0.1, 0.15],
  [20500.0, 0.15, 0.2],
  [17300.0, 0.2, 0.12],
  [36000.0, 0.12, 0.2],
  [13000.0, 0.2, 0.2],
  [20200.0, 0.2, 0.2],
  [54600.0, 0.2, 0.2],
  [11900.0, 0.2, 0.11428571428571428],
  [9300.0, 0.11428571428571428, 0.1],
  [76100.0, 0.1, 0.2],
  [3800.0, 0.2, 0.06666666666666667],
  [10400.0, 0.06666666666666667, 0.06666666666666667],
  [27000.0, 0.06666666666666667, 0.06666666666666667],
  [19900.0, 0.06666666666666667, 0.2],
  [6000.0, 0.2, 0.05714285714285714],
  [36800.0, 0.05714285714285714, 0.2],
  [2200.0, 0.2, 0.05714285714285714],
  [43900.0, 0.05714285714285714, 0.06666666666666667],
  [11600.0, 0.06666666666666667, 0.04],
  [9200.0, 0.04, 0.2],
  [23500.0, 0.2, 0.2],
  [75000.0, 0.2, 0.2],
  [3600.0, 0.2, 0.05714285714285714],
  [4400.0, 0.05714285714285714, 0.2],
  [1200.0, 0.2, 0.2],
  [41300.0, 0.2, 0.2],
  [10200.0, 0.2, 0.2],
  [13000.0, 0.2, 0.2],
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
