NRec=24;
load('RecName1.mat')

for i=24:NRec
display (RecName1(i))
RecName="qtdb/sel"+RecName1(i);
[sig, Fs, tm] = rdsamp(char(RecName), 1);
[ann] = rdann(char(RecName),'q1c');
tmax=10;
N=Fs*tmax;
t(i,1:N)=tm(1:N);
%   if i<NRec/2+1
  ecg_learning(1,1:156197-150273+1)=sig(150273:156197);
  ecg_learning=ecg_learning-mean(ecg_learning);
  k=2;
  const=ann(1);
  c=0;
     for i=1:length(ann)
      ann(i)=ann(i)-const+1;
      c(i)=1;
     end
  figure(i)
  plot(ecg_learning);
  hold on
  bar(ann,c,0.1)
%   else
%   ecg_testing(i-NRec/2,1:N)=sig(1:N);
%   k=2;
%     for j=1:length(ann)
%      if ann(k)==ann(k-1) && k<length(ann)
%      k=k+1;
%      end
%      c(1,j)=1;
%      a_testing(i-NRec/2,j)=ann(k-1)/Fs;
%      if k<length(ann)
%      k=k+1;
%      end    
%     end
%   figure(i)
%   plot(t(i-NRec/2,1:N),ecg_testing(i-NRec/2,1:N));
%   hold on
%   bar(a_testing(i-NRec/2,1:157),c(1:157),0.1)
%   end
end


