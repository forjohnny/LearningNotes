%{
%SProfileTest.m
S���ٶȹ滮���Գ���2019.02.12��Brian
��1������켣�ı߽�������Լ��������
��2�������ٶȹ滮�Ľ����
%}
clc
clear
close('all')
%%
%����켣�߽�������Լ������
q0=-5;
q1=10;
v0=-3;
v1=0;
v_max=10;
a_max=10;
j_max=30;
%%
%�����㷨�Ӻ����������ٶȹ滮���õ��滮���
fun=CalcFun();
Param=fun.CalcSProfile(q0,q1,v0,v1,v_max,a_max,j_max);
%%
%���ݹ滮����������㷨�Ӻ�������켣
Ts=0.001;
i=0;
for t=0:Ts:Param.T
    i=i+1; 
    time(i)=i*Ts;
    dis(i)=fun.displacement(t,Param);
    vel(i)=fun.velocity(t,Param);
    acc(i)=fun.acceleration(t,Param);
    jerk(i)=fun.jerk(t,Param);
end
%%
%��ͼ
figure
%λ��
subplot(4,1,1)
plot(time,dis,'r','LineWidth',1.5);
grid on
ylabel('position')
%�ٶ�
subplot(4,1,2)
plot(time,vel,'b','LineWidth',1.5);
grid on
hold on
ylabel('velocity')
v_ref1=v_max*ones(1,length(time));
v_ref2=-v_max*ones(1,length(time));
plot(time,v_ref1,'b--','LineWidth',1.5);
plot(time,v_ref2,'b--','LineWidth',1.5);
%���ٶ�
subplot(4,1,3)
plot(time,acc,'g','LineWidth',1.5);
grid on
hold on
ylabel('acceleration')
a_ref1=a_max*ones(1,length(time));
a_ref2=-a_max*ones(1,length(time));
plot(time,a_ref1,'g--','LineWidth',1.5);
plot(time,a_ref2,'g--','LineWidth',1.5);
%�Ӽ��ٶ�
subplot(4,1,4)
plot(time,jerk,'m','LineWidth',1.5)
grid on
hold on
ylabel('jerk')
j_ref1=j_max*ones(1,length(time));
j_ref2=-j_max*ones(1,length(time));
plot(time,j_ref1,'m--','LineWidth',1.5);
plot(time,j_ref2,'m--','LineWidth',1.5);
%����