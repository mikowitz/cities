[
  [15300.0, 0.0, 0.0],
  [40100.0, 0.0, 0.25],
  [13900.0, 0.25, 0.05],
  [15300.0, 0.05, 0.3181818181818182],
  [8400.0, 0.3181818181818182, 0.08333333333333333],
  [16900.0, 0.08333333333333333, 0.0625],
  [26600.0, 0.0625, 0.1111111111111111],
  [67300.0, 0.1111111111111111, 0.125],
  [60100.0, 0.125, 0.3181818181818182],
  [300.0, 0.3181818181818182, 0.14285714285714285],
  [19500.0, 0.14285714285714285, 0.21428571428571427],
  [41900.0, 0.21428571428571427, 0.125],
  [29300.0, 0.125, 0.08333333333333333],
  [22500.0, 0.08333333333333333, 0.05555555555555555],
  [47200.0, 0.05555555555555555, 0.3181818181818182],
] @=> float fades[][];

Gain g => dac;
0.0 => g.gain;

SinOsc s => Pan2 p => g;
0.19 => p.pan;
1600.0 => s.freq;

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
