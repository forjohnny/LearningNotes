%example2.6
clc
clear
%�켣��������
%ʱ��
t0=0;
t1=8;
%λ�ú��ٶȣ�a��
q0=0;
q1=10;
v0=0;
v1=0;
%���ù�ʽ��1-22����ϵ��
h=q1-q0;
T=t1-t0;
a0=q0;
a1=v0;
a2=(3*h-(2*v0+v1)*T)/(T*T);
a3=(-2*h+(v0+v1)*T)/(T*T*T);
%�켣����
t=t0:0.1:t1;
%λ��
q=a0+a1*power((t-t0),1)+a2*power((t-t0),2)+a3*power((t-t0),3);
%�ٶ�
v=a1+2*a2*power((t-t0),1)+3*a3*power((t-t0),2);
%���ٶ�
acc=2*a2+6*a3*power((t-t0),1);
%��ͼ
subplot(3,2,1)
plot(t,q,'r');
ylabel('position')
grid on
subplot(3,2,3)
plot(t,v,'b');
ylabel('velocity')
grid on
subplot(3,2,5)
plot(t,acc,'g');
xlabel('(a)');
ylabel('acceleration')
grid on

%ʱ��
t0=0;
t1=8;
%λ�ú��ٶȣ�b��
q0=0;
q1=10;
v0=-5;
v1=-10;
%���ù�ʽ��1-22����ϵ��
h=q1-q0;
T=t1-t0;
a0=q0;
a1=v0;
a2=(3*h-(2*v0+v1)*T)/(T*T);
a3=(-2*h+(v0+v1)*T)/(T*T*T);
%�켣����
t=t0:0.1:t1;
%λ��
q=a0+a1*power((t-t0),1)+a2*power((t-t0),2)+a3*power((t-t0),3);
%�ٶ�
v=a1+2*a2*power((t-t0),1)+3*a3*power((t-t0),2);
%���ٶ�
acc=2*a2+6*a3*power((t-t0),1);
%��ͼ
subplot(3,2,2)
plot(t,q,'r');
ylabel('position')
grid on
subplot(3,2,4)
plot(t,v,'b');
ylabel('velocity')
grid on
subplot(3,2,6)
plot(t,acc,'g');
xlabel('(b)');
ylabel('acceleration')
grid on


