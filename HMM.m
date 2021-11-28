% function [A,B,pi]= HMM1(W, AS, Splain_b1, Splain_b2, NItterations)
for I=100:NItterations
N=3;
pi=randn(1,N);
A=randn(N,N);
for t=2:T
  for i=1:3
    if t==2
      y=abs(round(abs(W(i,t))-abs(W(i,t-1))))*10^3+1;
      alpha(i,t)=pi(i)*B(i,y);
    else
        for j=1:3
         s1(j)=alpha(j,t-1)*A(i,j);
        end
      s2=sum(s1);
      y=abs(round(abs(W(i,t))-abs(W(i,t-1))))*10^3+1;
      alpha(i,t)=B(i,y)*s2; 
    end       
  end
end

betta(1:3,T)=1;

for k=1:(T-1)
   for i=1:3
       for j=1:3
       y=abs(round(abs(W(i,T-k+1))-abs(W(i,T-k))))*10^3+1;
       s(j)=betta(j,T-k+1)*A(i,j)*B(j,y);
       end
   betta(i,T-k)=sum(s);
   end
end

for t=1:T
    for i=1:3
        for j=1:3
        s1(j)=alpha(j,t)*betta(j,t);
        end
     s2=sum(s1);
     gamma(i,t)=alpha(i,t)*betta(i,t)/s2;
    end
end

for t=1:T-1
    for i=1:3
       for j=1:3
          y=abs(round(abs(W(i,t+1))-abs(W(i,t))))*10^3+1;
          s1(i,j)=alpha(i,t)*betta(j,t+1)*A(i,j)*B(j,y);
       end
    end
s2=sum(s1,2);
s3=sum(s2,1);

    for i=1:3
       for j=1:3
          y=abs(round(abs(W(i,t+1))-abs(W(i,t))))*10^3+1;
          num=alpha(i,t)*betta(j,t+1)*A(i,j)*B(j,y);  
          psi(i,t)=num/s3;
       end
    end
end
k=1;
for i=1:3
      pi(i)= gamma(i,1);
      for t=2:T
      y=abs(round(abs(W(i,t))-abs(W(i,t-1))));
         if y==O(i,k)
             delta=1;
             k=k+1;
         else
             delta=0;
         end
        s1(i,t)=delta*gamma(i,t); 
        s2(t)=s1(i,t);
      end
num=sum(s2,1);
B(i)=num/sum(gamma(i,1:T),2);
end
A=sum(psi,2)/sum(gamma,2);
clear s s1 s2 s3 num %инициализировать в начале
end
% end
