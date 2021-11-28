T=1/Fs;
tmax=20;
N=Fs*tmax;
t=0:T:tmax-T;
% ecg_learning=ecg_learning-mean(ecg_learning);
% ecg_learning=ecg_learning/max(abs(ecg));

% блок формирования вейвлетов
b=8;
Tsw=1;
for j=1:4
  k=-b*j:Tsw:b*j;
  M=2*b*j/Tsw+1;
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
W=round(W,3);
plot(W(1,:))
%______________________________________

%блок формирования векторов наблюдений
n=1;
j=0;
k=1;
for i=1:10
    P_markers((i-1)*3+1:(i-1)*3+3)=ann(k:k+2);  
%     PQ_markers((i-1)*2+1:(i-1)*2+2)=ann(k+6:k+7);   
    QRS_markers((i-1)*3+1:(i-1)*3+3)=ann(k+3:k+5);   
%     ST_markers((i-1)*2+1:(i-1)*2+2)=ann(k+11:k+12);   
%     T_markers((i-1)*3+1:(i-1)*3+3)=ann(k+13:k+15);   
    ISO_markers((i-1)*2+1:(i-1)*2+2)=ann(k+6:k+7);
    k=k+8;
end

% QRS_index=ann(1,7:9:end);
% for i=7:length(a_learning)
%     k=find(t==a_learning(i));
%     o(1,i-6)=W(1,k);
%     j=j+1;
%     if j==3
%        j=0;
%        i=i+9;
%     end
%     if i>=length(a_learning)
%         i=length(a_learning);
%     end
% end

%______________________________________

% cwt(ecg_testing(1,1:N),'amor',Fs)
% figure(4)
% plot(coi)
% plot(t,s)
% T=length(y);
% NItterations=10;
% end

