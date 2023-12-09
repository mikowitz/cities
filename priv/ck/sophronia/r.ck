[
  [4200.0, 0.0, 0.0],
  [14600.0, 0.0, 0.1851851851851852],
  [4000.0, 0.1851851851851852, 0.26666666666666666],
  [1800.0, 0.26666666666666666, 0.13333333333333333],
  [1700.0, 0.13333333333333333, 0.05555555555555555],
  [2400.0, 0.05555555555555555, 0.3333333333333333],
  [9600.0, 0.3333333333333333, 0.3333333333333333],
  [11300.0, 0.3333333333333333, 0.125],
  [1100.0, 0.125, 0.16666666666666666],
  [12600.0, 0.16666666666666666, 0.2222222222222222],
  [4500.0, 0.2222222222222222, 0.2222222222222222],
  [5900.0, 0.2222222222222222, 0.07407407407407407],
  [13000.0, 0.07407407407407407, 0.12820512820512822],
  [13200.0, 0.12820512820512822, 0.08333333333333333],
  [8700.0, 0.08333333333333333, 0.3333333333333333],
  [11200.0, 0.3333333333333333, 0.16666666666666666],
  [9000.0, 0.16666666666666666, 0.2222222222222222],
  [8000.0, 0.2222222222222222, 0.2142857142857143],
  [9600.0, 0.2142857142857143, 0.08333333333333333],
  [5700.0, 0.08333333333333333, 0.1111111111111111],
  [3600.0, 0.1111111111111111, 0.3333333333333333],
  [1300.0, 0.3333333333333333, 0.2222222222222222],
  [5300.0, 0.2222222222222222, 0.2962962962962963],
  [5900.0, 0.2962962962962963, 0.16666666666666666],
  [3300.0, 0.16666666666666666, 0.2857142857142857],
  [3400.0, 0.2857142857142857, 0.3333333333333333],
  [11900.0, 0.3333333333333333, 0.16666666666666666],
  [14200.0, 0.16666666666666666, 0.05128205128205129],
  [5700.0, 0.05128205128205129, 0.3333333333333333],
  [1800.0, 0.3333333333333333, 0.26666666666666666],
  [6600.0, 0.26666666666666666, 0.3333333333333333],
  [2500.0, 0.3333333333333333, 0.14285714285714285],
  [3500.0, 0.14285714285714285, 0.05555555555555555],
  [6000.0, 0.05555555555555555, 0.14285714285714285],
  [16200.0, 0.14285714285714285, 0.3333333333333333],
  [9700.0, 0.3333333333333333, 0.2916666666666667],
  [2700.0, 0.2916666666666667, 0.14814814814814814],
  [3100.0, 0.14814814814814814, 0.041666666666666664],
  [8500.0, 0.041666666666666664, 0.2916666666666667],
  [2500.0, 0.2916666666666667, 0.08333333333333333],
  [3100.0, 0.08333333333333333, 0.2916666666666667],
  [7600.0, 0.2916666666666667, 0.16666666666666666],
  [6900.0, 0.16666666666666666, 0.3333333333333333],
  [1300.0, 0.3333333333333333, 0.2222222222222222],
  [1900.0, 0.2222222222222222, 0.2962962962962963],
  [1200.0, 0.2962962962962963, 0.25],
  [7000.0, 0.25, 0.047619047619047616],
  [9200.0, 0.047619047619047616, 0.23076923076923075],
  [4900.0, 0.23076923076923075, 0.2745098039215686],
  [9200.0, 0.2745098039215686, 0.1111111111111111],
  [3000.0, 0.1111111111111111, 0.16666666666666666],
  [5400.0, 0.16666666666666666, 0.25],
  [1700.0, 0.25, 0.05555555555555555],
  [2400.0, 0.05555555555555555, 0.3333333333333333],
  [20000.0, 0.3333333333333333, 0.3333333333333333],
  [2600.0, 0.3333333333333333, 0.2777777777777778],
  [2300.0, 0.2777777777777778, 0.14285714285714285],
  [2400.0, 0.14285714285714285, 0.047619047619047616],
  [12900.0, 0.047619047619047616, 0.2380952380952381],
] @=> float fades[][];

Gain g => dac;
0.0 => g.gain;

SinOsc s => Pan2 p => g;
0.33 => p.pan;
1800.0 => s.freq;

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