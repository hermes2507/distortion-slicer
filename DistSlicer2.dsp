import ("music.lib");
import ("filter.lib");
import ("oscillator.lib");

drive = hslider("Drive",0,0,2,0.01) : smooth(tau2pole(0.1)); 
offset = hslider("Offset",0,-1,1,0.01) : smooth(0.999);
masterGain = hslider(" [1]MasterGain",0,0,0.999,0.01);
gain = pow(10.0,2*drive); 
clip(lo,hi) = min(hi) : max(lo);



cubic = _ <: _ - _*_*_/3;


freq=hslider("Frecuencia",0,0,10,0.11):smooth(0.999);
freqs=hslider("Frecuencia 2",0,0,10,0.11):smooth(0.999);
depth=hslider("Depth",0,0,100,0.01):smooth(0.999);

f = hslider("Duracion Slicer",50000,50000,500000,10);
fs = hslider("Duracion Slicer 2",50000,50000,500000,10);

impulso = osc(freq) <: _,_@f : - : >(0); 

impulso2 = osc(freqs) <: _,_@fs : - : >(0); 

impulsoA = abs((-1)*impulso+impulso2):smooth(0.999);

impulso3 = abs(osc(freq)):smooth(0.999);



//ringMod=*(1-(depth*osc(freq)/2+0.5));



process = _:*(gain) : +(offset) : clip(-1,1) : cubic : dcblocker *(impulsoA)<:_*masterGain,_*masterGain;




