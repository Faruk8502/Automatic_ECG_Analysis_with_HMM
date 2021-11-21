NRec=4;
load('RecName1.mat')

for i=1:NRec
display (RecName1(i))
RecName="qtdb/sel"+RecName1(i);
[sig, Fs, tm] = rdsamp(char(RecName), 1);
[ann] = rdann(char(RecName),'pu');
tmax=10;
N=Fs*tmax;
t(i,1:N)=tm(1:N);
  if i<NRec/2+1
  ecg_learning(i,1:N)=sig(1:N);
  k=2;
     for j=1:length(ann)
      if ann(k)==ann(k-1) && k<length(ann)
      k=k+1;
      end
      c(1,j)=1;
      a_learning(i,j)=ann(k-1)/Fs;
      if k<length(ann)
      k=k+1;
      end
     end
  figure(i)
  plot(t(i,1:N),ecg_learning(i,1:N));
  hold on
  bar(a_learning(i,1:157),c(1:157),0.1)
  else
  ecg_testing(i-NRec/2,1:N)=sig(1:N);
  k=2;
    for j=1:length(ann)
     if ann(k)==ann(k-1) && k<length(ann)
     k=k+1;
     end
     c(1,j)=1;
     a_testing(i-NRec/2,j)=ann(k-1)/Fs;
     if k<length(ann)
     k=k+1;
     end    
    end
  figure(i)
  plot(t(i-NRec/2,1:N),ecg_testing(i-NRec/2,1:N));
  hold on
  bar(a_testing(i-NRec/2,1:157),c(1:157),0.1)
  end
end
