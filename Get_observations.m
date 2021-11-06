global ecg Fs tmax T y NItterations
T=1/Fs;
N=Fs*tmax;
t=0:T:tmax-T;
ecg=ecg-mean(ecg);
ecg=ecg/max(abs(ecg));
subplot(3,1,1)
plot(t,ecg(1:N));
xlim([0,20]);
grid on;
grid minor;
xlabel('Время(секунды)')
ylabel('Амплитуда');
title('ЭКГ');

for i=3:N
   ecg_dif(i)=ecg(i)-ecg(i-2); 
end
subplot(3,1,2)
plot(t,ecg_dif);
title('дифференцированный сигнал ЭКГ');
for i=1:N
   ecg_dif_m(i)=abs(ecg_dif(i)); 
end
subplot(3,1,3)
plot(t,ecg_dif_m);
title('взятый по модулю дифференцированный сигнал ЭКГ');

limit1=0.05;
limit2=0.1;
limit3=0.3;
k=1;
for i=1:N
    if ecg_dif(i)>limit3
       y(k)=2;
       k=k+1;
    end 
    if ecg_dif(i)>limit2 && ecg_dif(i)<limit3
       y(k)=3;
       k=k+1;
    end
    if ecg_dif(i)>limit1 && ecg_dif(i)<limit2
       y(k)=1;
       k=k+1;
    end
end
T=length(y);
NItterations=3;
