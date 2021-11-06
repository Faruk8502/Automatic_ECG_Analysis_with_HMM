global ecg Fs tmax
[filename,filepath]=uigetfile('sel100.dat');
fid=fopen(filename,'r');
Fs=200;
tmax=20;
f=fread(fid,2*Fs*tmax,'ubit12');
ecg=f(1:2:length(f));