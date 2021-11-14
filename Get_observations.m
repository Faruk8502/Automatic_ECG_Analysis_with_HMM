function y=Get_observations(ecg,Fs,tmax,y)
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

for j=1:4
    for k=1:11
    psi(j,k)=2/(2^(j/2)*(3*pi)^(1/4))*(1-((k-6)/2^j)^2)*exp(1/2*((k-6)/2^j)^2);
    end
    for n=1:N
    s(n)=ecg(n)*psi(j,k);
    end
    W(j,k)=sum(s);  
end
plot(psi(1,:))
T=length(y);
NItterations=10;
end

