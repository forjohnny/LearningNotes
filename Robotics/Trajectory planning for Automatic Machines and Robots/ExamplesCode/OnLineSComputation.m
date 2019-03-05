clc
clear
close('all')
%%
%����켣�߽�������Լ������
Ts=0.001;
q0=0;
q1=10;
v0=1;
v1=0;
a0=0;
a1=0;
v_max=5;
v_min=-5;
a_max=10;
a_min=-10;
j_max=30;
j_min=-30;
%%
%�����㷨�Ӻ����������ٶȹ滮���õ��滮���
fun=OnLineFun();
InParam=fun.InitialParam(q0,q1,v0,v1,a0,a1,v_max,v_min,a_max,a_min,j_max,j_min,Ts);
%��ʼ������ṹ��
%falg:  �켣���־��0���ڼ��ٶȶΣ�1���ڼ��ٶΣ�2�����յ�
%   k:   �켣����������ʼλ��q0Ϊ��һ���켣��
% kd:   ���ٿ�ʼ�켣�������
Qk=struct('flag',{0},'k',{1},'kd',{0},'t',{0},'qk',{q0},'vk',{v0},'ak',{a0},'jk',{j_max},'Tj2a',{0},'Tj2b',{0},'Td',{0});

while(Qk.flag<2)
    time(Qk.k)=Qk.t;
    dis(Qk.k)=Qk.qk;
    vel(Qk.k)=Qk.vk;
    acc(Qk.k)=Qk.ak;
    jerk(Qk.k)=Qk.jk;
    Qk=fun.OnLineCalc(Qk,InParam);
end
%%
%��ͼ
hold on
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
v_ref2=v_min*ones(1,length(time));
plot(time,v_ref1,'b--','LineWidth',1.5);
plot(time,v_ref2,'b--','LineWidth',1.5);
%���ٶ�
subplot(4,1,3)
plot(time,acc,'g','LineWidth',1.5);
grid on
hold on
ylabel('acceleration')
a_ref1=a_max*ones(1,length(time));
a_ref2=a_min*ones(1,length(time));
plot(time,a_ref1,'g--','LineWidth',1.5);
plot(time,a_ref2,'g--','LineWidth',1.5);
%�Ӽ��ٶ�
subplot(4,1,4)
plot(time,jerk,'m','LineWidth',1.5)
grid on
hold on
ylabel('jerk')
j_ref1=j_max*ones(1,length(time));
j_ref2=j_min*ones(1,length(time));
plot(time,j_ref1,'m--','LineWidth',1.5);
plot(time,j_ref2,'m--','LineWidth',1.5);
%����
