clc
clear
close('all')
%%����ϵ���任���������任
T1=troty(60);
T2=transl(4,0,3);
T=T2*T1;
p1=[2;4;3;1];
Ap1=T*p1;
%%����ϵ��任����������任
Tr=inv(T);
Bp1=Tr*p1;
%%��ͼ
T0=transl(0,0,0);
trplot(T0,'frame','A','color','b');
axis([-5 5 -5 5 -5 5]);
hold on,
tranimate(T0,T,'frame','B','color','r');
