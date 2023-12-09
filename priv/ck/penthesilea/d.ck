[
  [10900.0, 0.0, 0.0],
  [3300.0, 0.0, 0.5],
  [14900.0, 0.5, 0.05],
  [11100.0, 0.05, 0.1],
  [9200.0, 0.1, 0.3333333333333333],
  [14900.0, 0.3333333333333333, 0.1],
  [300.0, 0.1, 0.35714285714285715],
  [8400.0, 0.35714285714285715, 0.5],
  [13200.0, 0.5, 0.42857142857142855],
  [8000.0, 0.42857142857142855, 0.2857142857142857],
  [6500.0, 0.2857142857142857, 0.5],
  [10500.0, 0.5, 0.42857142857142855],
  [3100.0, 0.42857142857142855, 0.5],
  [21400.0, 0.5, 0.5],
  [3300.0, 0.5, 0.4444444444444444],
  [17100.0, 0.4444444444444444, 0.5],
  [8500.0, 0.5, 0.5],
  [22200.0, 0.5, 0.5],
  [5200.0, 0.5, 0.05555555555555555],
  [6600.0, 0.05555555555555555, 0.14285714285714285],
  [14500.0, 0.14285714285714285, 0.5],
  [6300.0, 0.5, 0.42857142857142855],
  [6600.0, 0.42857142857142855, 0.3],
  [19300.0, 0.3, 0.42857142857142855],
  [6700.0, 0.42857142857142855, 0.42857142857142855],
  [3800.0, 0.42857142857142855, 0.5],
  [2600.0, 0.5, 0.07142857142857142],
  [8100.0, 0.07142857142857142, 0.5],
  [10100.0, 0.5, 0.2777777777777778],
  [6600.0, 0.2777777777777778, 0.4166666666666667],
  [4800.0, 0.4166666666666667, 0.5],
  [3900.0, 0.5, 0.35714285714285715],
  [4000.0, 0.35714285714285715, 0.4],
  [3600.0, 0.4, 0.5],
  [19200.0, 0.5, 0.2],
  [12200.0, 0.2, 0.35714285714285715],
  [4500.0, 0.35714285714285715, 0.5],
  [25500.0, 0.5, 0.1875],
  [3100.0, 0.1875, 0.5],
  [2800.0, 0.5, 0.5],
  [18200.0, 0.5, 0.5],
  [23300.0, 0.5, 0.5],
  [11200.0, 0.5, 0.125],
  [2100.0, 0.125, 0.3],
  [10100.0, 0.3, 0.5],
  [18400.0, 0.5, 0.45454545454545453],
  [20900.0, 0.45454545454545453, 0.5],
  [8600.0, 0.5, 0.5],
  [65300.0, 0.5, 0.05555555555555555],
  [13700.0, 0.05555555555555555, 0.5],
  [10000.0, 0.5, 0.5],
  [13800.0, 0.5, 0.3181818181818182],
  [4500.0, 0.3181818181818182, 0.1875],
  [38200.0, 0.1875, 0.5],
  [1100.0, 0.5, 0.5],
  [21100.0, 0.5, 0.5],
  [14700.0, 0.5, 0.5],
  [17400.0, 0.5, 0.5],
  [7800.0, 0.5, 0.5],
  [11900.0, 0.5, 0.5],
  [12100.0, 0.5, 0.2857142857142857],
  [17200.0, 0.2857142857142857, 0.5],
  [3000.0, 0.5, 0.15],
  [4500.0, 0.15, 0.5],
  [200.0, 0.5, 0.25],
  [10500.0, 0.25, 0.3333333333333333],
  [2700.0, 0.3333333333333333, 0.045454545454545456],
  [900.0, 0.045454545454545456, 0.3181818181818182],
  [5100.0, 0.3181818181818182, 0.5],
  [21900.0, 0.5, 0.3333333333333333],
  [38900.0, 0.3333333333333333, 0.5],
  [7200.0, 0.5, 0.5],
  [2700.0, 0.5, 0.5],
  [4100.0, 0.5, 0.42857142857142855],
  [4100.0, 0.42857142857142855, 0.125],
  [37400.0, 0.125, 0.42857142857142855],
] @=> float fades[][];

Gain g => dac;
0.0 => g.gain;

SinOsc s => Pan2 p => g;
-0.7 => p.pan;
400.0 => s.freq;

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