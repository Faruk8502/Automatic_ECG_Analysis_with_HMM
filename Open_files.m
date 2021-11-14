NRec=5;
load('RecName.mat')
for i=1:NRec
[sig, Fs, tm] = rdsamp('qtdb/'+int2str(RecName(i)), 1);
[ann] = rdann('qtdb/'+int2str(RecName(i)),'qt1');
tmax=15;
N=Fs*tmax;
ecg(i,1:N)=sig;
for i=1:length(ann)
    c(1,i)=6;
    a(i)=ann(i)/Fs;
 end
end
plot(tm(1:N), ecg(1:N));
hold on
bar(a,c,0.1)
