% function y=Get_observations(ecg,Fs,tmax,y)
Fs=250;
T=1/Fs;
tmax=10;
N=Fs*tmax;
t=0:T:tmax-T;
ecg_learning=ecg_learning-mean(ecg_learning);
ecg_learning=ecg_learning/max(abs(ecg));
subplot(3,1,1)
figure(1)
plot(t,ecg_learning(1:N));
xlim([0,20]);
grid on;
grid minor;
xlabel('Время(секунды)')
ylabel('Амплитуда');
title('ЭКГ');

% блок формирования вейвлетов
b=16;
Fsw=1;
for j=1:4
  k=-b*j:1/Fsw:b*j;
  M=2*b*j*Fsw+1;
    for i=1:M
    psi(j,i)=2/(2^(j/2)*3^(0.5)*pi^(0.25))*(1-(k(i)/2^j)^2)*exp(-0.5*(k(i)/2^j)^2);
    end
    for i=M:N
        for tau=1:M
        s(tau)=ecg_learning(i-(M-tau))*psi(j,tau);
        W(j,i)=sum(s);  
    end
    end
end
figure(5)
plot(W(1,:))
%______________________________________

% блок формирования векторов наблюдений
% n=1;
% for i=1:N-n
%     
% end

%______________________________________

% cwt(ecg_testing(1,1:N),'amor',Fs)
% figure(4)
% plot(coi)
% plot(t,s)
% T=length(y);
% NItterations=10;
% end

