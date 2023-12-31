[
  [48100.0, 0.0, 0.0],
  [2400.0, 0.0, 0.08333333333333333],
  [22900.0, 0.08333333333333333, 0.06666666666666667],
  [63600.0, 0.06666666666666667, 0.3333333333333333],
  [9100.0, 0.3333333333333333, 0.041666666666666664],
  [2600.0, 0.041666666666666664, 0.3333333333333333],
  [9600.0, 0.3333333333333333, 0.3333333333333333],
  [93600.0, 0.3333333333333333, 0.1851851851851852],
  [4000.0, 0.1851851851851852, 0.3333333333333333],
  [16800.0, 0.3333333333333333, 0.14814814814814814],
  [37100.0, 0.14814814814814814, 0.08333333333333333],
  [132400.0, 0.08333333333333333, 0.08333333333333333],
  [21900.0, 0.08333333333333333, 0.3333333333333333],
  [7900.0, 0.3333333333333333, 0.3333333333333333],
  [6100.0, 0.3333333333333333, 0.3333333333333333],
  [17300.0, 0.3333333333333333, 0.08333333333333333],
  [3000.0, 0.08333333333333333, 0.3333333333333333],
  [3900.0, 0.3333333333333333, 0.25],
  [200.0, 0.25, 0.3333333333333333],
  [35700.0, 0.3333333333333333, 0.08333333333333333],
  [13100.0, 0.08333333333333333, 0.3333333333333333],
  [34700.0, 0.3333333333333333, 0.08333333333333333],
  [12100.0, 0.08333333333333333, 0.09999999999999999],
  [27500.0, 0.09999999999999999, 0.1111111111111111],
  [54800.0, 0.1111111111111111, 0.3333333333333333],
  [9300.0, 0.3333333333333333, 0.3333333333333333],
  [41300.0, 0.3333333333333333, 0.3333333333333333],
  [1900.0, 0.3333333333333333, 0.3333333333333333],
  [10900.0, 0.3333333333333333, 0.06666666666666667],
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
