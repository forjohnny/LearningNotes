%example2.8
clc
clear
%�켣��������
t_array=[0,2,4,8,10];
q_array=[10,20,0,30,40];
v_array=[-1,-10,5,3,8];
%����켣
%��ʼλ��
t=t_array(1);
q=q_array(1);
v=v_array(1);
v_array2=v_array;

for k=1:length(t_array)-1
    %����ʽ��1-23��ʽȷ���м����ٶ�ֵ
    if(k>1)
        dk1=(q_array(k)-q_array(k-1))/(t_array(k)-t_array(k-1));
        dk2=(q_array(k+1)-q_array(k))/(t_array(k+1)-t_array(k));
        if((dk2>=0 && dk1>=0) || (dk2<=0 && dk1<=0))
            v_array2(k)=1.0/2.0*(dk1+dk2);
        else
            v_array2(k)=0;
        end  
    end
end

%������ι켣
for k=1:length(t_array)-1
    %������ζ���ʽ��ϵ��
    h(k)=q_array(k+1)-q_array(k);
    T(k)=t_array(k+1)-t_array(k);
    a0(k)=q_array(k);
    a1(k)=v_array2(k);
    a2(k)=(3*h(k)-(2*v_array2(k)+v_array2(k+1))*T(k))/(T(k)*T(k));
    a3(k)=(-2*h(k)+(v_array2(k)+v_array2(k+1))*T(k))/(T(k)*T(k)*T(k));
    
    %���ɸ��ι켣�ܻ������ݵ�
    %�ֲ�ʱ������
    tau=t_array(k):T(k)/100:t_array(k+1);
    %ȫ��ʱ�����꣬�ɾֲ�ʱ���������
    t=[t,tau(2:end)];
    %�ֲ�λ������
    qk=a0(k)+a1(k)*power(tau-tau(k),1)+a2(k)*power(tau-tau(k),2)+a3(k)*power(tau-tau(k),3);
    %ȫ��λ������
    q=[q,qk(2:end)];
    %�ٶ�
    vk=a1(k)+2*a2(k)*power(tau-tau(k),1)+3*a3(k)*power(tau-tau(k),2);
    v=[v,vk(2:end)];
    %���ٶ�
    acck=2*a2(k)+6*a3(k)*power(tau-tau(k),1);
    if(k==1)
        acc=2*a2(k);
    end
    acc=[acc,acck(2:end)];
    
end
%��ͼ
subplot(3,1,1);
h2=plot(t,q,'--r');
legend(h2,'�ڶ��ַ�ʽ')
hold on;
plot(t_array,q_array,'^r');
axis([0,10,-5,45]);
ylabel('position')
grid on;
subplot(3,1,2);
plot(t_array,v_array2,'^b');
hold on;
plot(t,v,'--b');
axis([0,10,-20,15]);
ylabel('velocity')
grid on;
subplot(3,1,3);
plot(t,acc,'--g');
axis([0,10,-45,45]);
ylabel('acceleration')
grid on;

