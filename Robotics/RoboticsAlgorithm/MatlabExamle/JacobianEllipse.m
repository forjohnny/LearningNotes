%{
This circle maps through the Jacobian to an ellipse in the space of tip velocities
%}
clc
clear
close('all')
L1=1;
L2=1;
t=(0:0.01:2*pi)';
theta1=pi/4;%�ؽ�1λ��
theta2=pi/10;%�ؽ�2λ��
dtheta1=cos(t);%�ؽ�1�ٶ�
dtheta2=sin(t);%�ؽ�2�ٶ�
dtheta=[dtheta1,dtheta2];
f1=subplot(1,2,1);
xlabel('�ؽ�1�ٶ�')
ylabel('�ؽ�2�ٶ�')
grid on
axis equal
hold on
f2=subplot(1,2,2);
xlabel('v_1')
ylabel('v_2')
grid on
axis equal
hold on
for theta1=0.5:0.5:2*pi
    for theta2=0.5:0.5
        J=[-L1*sin(theta1)-L2*sin(theta1+theta2), -L2*sin(theta1+theta2);
            L1*cos(theta1)+L2*cos(theta1+theta2),L2*cos(theta1+theta2)];
        for i=1:length(dtheta2)
            v(i,:)=J*dtheta(i,:)';%�ؽ��ٶȱ仯ʱ����Ӧ��ĩ���ٶ�
        end
        plot(f1,dtheta1,dtheta2,'.','LineWidth',1.5);
        plot(f2,v(:,1),v(:,2),'.','LineWidth',1.5)
    end
end



