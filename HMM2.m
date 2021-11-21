function [A,B,pi]= HMM(y,T,NItterations)
for I=1:NItterations
O=[1 2 3];
N=3;
M=3;
pi=randn(1,M);
A=randn(N,M);
B=randn(N,M);
for t=1:T
  for i=1:3
    if t==1
      alpha(i,t)=pi(i)*B(y(t),i);
    else
        for j=1:3
         s1(j)=alpha(j,t-1)*A(i,j);
        end
      s2=sum(s1);
      alpha(i,t)=B(y(i),i)*s2; 
    end       
  end
end

betta(1:3,T)=1;

for k=1:(T-1)
   for i=1:3
       for j=1:3
       s(j)=betta(j,T-k+1)*A(i,j)*B(y(T-k+1),j);
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
          s1(i,j)=alpha(i,t)*betta(j,t+1)*A(i,j)*B(y(t+1),j);
       end
    end
s2=sum(s1,2);
s3=sum(s2,1);

    for i=1:3
       for j=1:3
          num=alpha(i,t)*betta(j,t+1)*A(i,j)*B(y(t+1),j);  
          psi(i,t)=num/s3;
       end
    end
end

for i=1:3
      pi(i)= gamma(i,1);
      for t=1:10
         if y(t)==O(i)
             delta=1;
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