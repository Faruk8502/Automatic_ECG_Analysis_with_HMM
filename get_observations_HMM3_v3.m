% o1=zeros(1,250);
% o2=zeros(1,250);

k=1;
m=1;
for i=1:10   
    QRS_markers_segm(1,i)=QRS_markers(k)+8;
    QRS_markers_segm(2,i)=QRS_markers(k+1)+8;
    QRS_markers_segm(3,i)=QRS_markers(k+2)+8;
    k=k+3;
end
k=1;
m=1;
for i=1:length(QRS_markers)/3
    for j=1:QRS_markers_segm(2,i)-QRS_markers_segm(1,i)
    O(1,k)=abs(W(1,QRS_markers_segm(1,i)+j))-abs(W(2,QRS_markers_segm(1,i)+(j-1)));
    k=k+1;
    end
    for j=1:QRS_markers_segm(3,i)-QRS_markers_segm(2,i)
    O(2,m)=abs(W(1,QRS_markers_segm(2,i)+j))-abs(W(2,QRS_markers_segm(1,i)+(j-1)));
    m=m+1;
    end
end

O(3,:)=1;
% l=1;
% for i=1:length(QRS_markers)/3-1
%     for j=1:QRS_markers_segm(1,i+1)-QRS_markers_segm(3,i)
%     o3(l)=W(1,QRS_markers_segm(3,i)+j)-W(1,QRS_markers_segm(3,i)+(j-1));
%     l=l+1;
%     end
% end  

O(1,:)=sort(O(1,:));
O(2,:)=sort(O(2,:));
% o3=sort(o3);

mo1=mean(O(1,:));
mo2=mean(O(2,:));
% mo3=mean(o3);
so1=std(O(1,:));
so2=std(O(2,:));
% so3=std(o3);

for i=1:length(O(1,:))
o1(i)=O(1,i);
b1(i)=1/((2*pi)^0.5*so1)*exp((-0.5)*(o1(i)-mo1)^2/(so1^2));
end
for i=1:length(O(2,:))
o2(i)=O(2,i);
b2(i)=1/((2*pi)^0.5*so2)*exp((-0.5)*(o2(i)-mo2)^2/(so2^2));
end

sum1=sum(b1);
b1=b1/sum1;

sum2=sum(b2);
b2=b2/sum2;


% for i=1:length(o3)
% b3(i)=1/((2*pi)^0.5*so3)*exp((-0.5)*(o3(i)-mo3)^2/(so3^2));
% end

o1=O(1,:);
Koeff_b1=csaps(o1,b1,1);
A1=0:0.001:1;
Splain_b1=ppval(Koeff_b1,A1);

o2=O(2,:);
Koeff_b2=csaps(O(2,:),b2,1);
A2=0:0.001:1;
Splain_b2=ppval(Koeff_b2,A2);

A3=0:0.001:1;

% Koeff_b3=csaps(o3,b3,1);
% A3=o3(1):0.001:o3(end);
% Splain_b3=ppval(Koeff_b3,A3);

figure()
plot(A1,Splain_b1)
figure()
plot(A2,Splain_b2)
figure()
plot(b2)
% s=sum(b1);

B(1,:)=Splain_b1;
B(2,:)=Splain_b2;
B(3,:)=1;

AS(1,:)=A1;
AS(2,:)=A2;
AS(3,:)=A3;

NItterations=1;
% N=3;
% pi=randn(1,N);
% A=randn(N,N);
T=length(W);