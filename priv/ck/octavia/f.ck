[
  [900.0, 0.0, 0.0],
  [73600.0, 0.0, 0.3333333333333333],
  [5900.0, 0.3333333333333333, 0.2380952380952381],
  [25900.0, 0.2380952380952381, 0.08333333333333333],
  [10400.0, 0.08333333333333333, 0.1111111111111111],
  [200.0, 0.1111111111111111, 0.3333333333333333],
  [1000.0, 0.3333333333333333, 0.08333333333333333],
  [5500.0, 0.08333333333333333, 0.1111111111111111],
  [17600.0, 0.1111111111111111, 0.047619047619047616],
  [4400.0, 0.047619047619047616, 0.03333333333333333],
  [22400.0, 0.03333333333333333, 0.3333333333333333],
  [37400.0, 0.3333333333333333, 0.3333333333333333],
  [28500.0, 0.3333333333333333, 0.3333333333333333],
  [33500.0, 0.3333333333333333, 0.1111111111111111],
  [400.0, 0.1111111111111111, 0.25],
  [34100.0, 0.25, 0.3333333333333333],
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
