%{
OnLineFun.m
S���ٶȹ滮���߼�������Ӻ�������
%}
function fun=OnLineFun
fun.InitialParam=@InitialParam;
fun.CalcJk1=@CalcJk1;
fun.CalcJk2=@CalcJk2;
fun.CalcQk=@CalcQk;
fun.OnLineCalc=@OnLineCalc;
end

%{
��1�������Ϸ��Լ��
��2����ʼ�������ṹ��
%}
function IniParam=InitialParam(q0,q1,v0,v1,a0,a1,v_max,v_min,a_max,a_min,j_max,j_min,Ts)
%������飬����ֵС��1.0E-8����ֵ��Ϊ��0.
if(abs(v_max)<1.0E-8)
    disp('������������ٶȲ���Ϊ0�������˳���');
    return;
end
if(abs(a_max)<1.0E-8 || abs(a_min)<1.0E-8)
    disp('�����������/��С���ٶȲ���Ϊ0�������˳���');
    return;
end
if(abs(j_max)<1.0E-8 || abs(j_min)<1.0E-8)
    disp('�����������/��С�Ӽ��ٶȲ���Ϊ0�������˳���');
    return;
end
if(abs(q1-q0)<1.0E-8)
    disp('������������λ�Ʋ���Ϊ0�������˳���');
    return;
end
if(Ts<1.0E-8)
    disp('�������󡣲������ڲ���Ϊ0�������˳���');
    return;
end
%%
%���岢��ʼ����������Ľṹ��
if(q1-q0>0)
    sigma=1;
else
    sigma=-1;
end
%���㣨3.31����
hq0=sigma*q0;
hq1=sigma*q1;
hv0=sigma*v0;
hv1=sigma*v1;
%���㣨3.32��
hv_max=(sigma+1)/2*v_max+(sigma-1)/2*v_min;
hv_min=(sigma+1)/2*v_min+(sigma-1)/2*v_max;
ha_max=(sigma+1)/2*a_max+(sigma-1)/2*a_min;
ha_min=(sigma+1)/2*a_min+(sigma-1)/2*a_max;
hj_max=(sigma+1)/2*j_max+(sigma-1)/2*j_min;
hj_min=(sigma+1)/2*j_min+(sigma-1)/2*j_max;
IniParam=struct(...
 'Ts',{Ts},...
'q0',{hq0},...
'q1',{hq1},...
'v0',{hv0},...
'v1',{hv1},...
'a0',{a0},...
'a1',{a1},...
'vmax',{hv_max},...
'vmin',{hv_min},...
'amax',{ha_max},...
'amin',{ha_min},...
'jmax',{hj_max},...
'jmin',{hj_min},...
'sigma',{sigma}...
);

end

%{
���㣨3.35����ȷ�����ٽ׶εļӼ��ٶ�
%}
function jk=CalcJk1(Q0,InParam)
vk=Q0.vk;
ak=Q0.ak;
if((vk-ak^2/(2*InParam.jmin)<InParam.vmax) && ak<InParam.amax)
    jk=InParam.jmax;  
elseif((vk-ak^2/(2*InParam.jmin)<InParam.vmax) && ak >=InParam.amax)
    jk=0;
elseif((vk-ak^2/(2*InParam.jmin)>=InParam.vmax) && ak>0)
    jk=InParam.jmin;
elseif((vk-ak^2/(2*InParam.jmin)>=InParam.vmax) && ak<=0)
    jk=0;
end
if(Q0.k>980)
    Q0.k;
end
end
%{
���㣨3.38����ȷ�����ٶȽ׶εļӼ��ٶ�
%}
function jk=CalcJk2(Q0,InParam)
Tj2a=Q0.Tj2a;
Tj2b=Q0.Tj2b;
Td=Q0.Td;
if( (Q0.k-Q0.kd)>0 && (Q0.k-Q0.kd)<=(Tj2a/InParam.Ts))
    jk=InParam.jmin;
elseif((Q0.k-Q0.kd)>(Tj2a/InParam.Ts) && (Q0.k-Q0.kd)<=((Td-Tj2b)/InParam.Ts))
    jk=0;
else
    jk=InParam.jmax;
end

end
%{
���㣨3.34�������ݵ�ǰ���ڵĹ켣�������һ�����ڵĹ켣��
%}
function Qk=CalcQk(jk,Q0,InParam)
%Q0Ϊ��ǰ���ڵ�ֵ��QkΪ��һ�����ڵ�ֵ
Qk=Q0;%�൱�ڶ���һ��Qk
Ts=InParam.Ts;
Qk.k=Q0.k+1;
Qk.t=Q0.t+Ts;
Qk.jk=jk;
Qk.ak=Q0.ak+Ts/2*(Q0.jk+jk);
Qk.vk=Q0.vk+Ts/2*(Q0.ak+Qk.ak);
Qk.qk=Q0.qk+Ts/2*(Q0.vk+Qk.vk);

end

%{
S���ٶ����߹滮
%}
function Qk=OnLineCalc(Q0,InParam)
Qk=Q0;
jmax=InParam.jmax;
jmin=InParam.jmin;
q1=InParam.q1;
amin=InParam.amin;
a0=InParam.a0;
a1=InParam.a1;
v1=InParam.v1;
%�жϼ��ٵ�
if(Q0.flag<1) 
    Tj2a=(amin-Q0.ak)/jmin;
    Tj2b=(a1-amin)/jmax;
    Td=(v1-Q0.vk)/amin+Tj2a*(amin-Q0.ak)/(2*amin)+...
        Tj2b*(amin-a1)/(2*amin);
    if(Td>=Tj2a+Tj2b)
        %�ﵽ��С���ٶ�
    else
        %���ܴﵽ��С���ٶ�
        Tj2a=-Q0.ak/jmin+sqrt((jmax-jmin)*(Q0.ak^2*jmax-jmin*(a1^2+2*jmax*(Q0.vk-v1))))/(jmin*(jmin-jmax));
        Tj2b=a1/jmax+sqrt((jmax-jmin)*(Q0.ak^2*jmax-jmin*(a1^2+2*jmax*(Q0.vk-v1))))/(jmax*(jmax-jmin));
        Td=Tj2a+Tj2b;
    end
    hk=1.0/2*Q0.ak*Td^2+1.0/6*(jmin*Tj2a*(3*Td^2-3*Td*Tj2a+Tj2a^2)+jmax*Tj2b^3)+Td*Q0.vk;
    if(hk<q1-Q0.qk)
        %δ������ٶ�
    else
        %������ٽ׶�
        Q0.flag=1;
        Q0.kd=Q0.k;
        Q0.Tj2a=Tj2a;
        Q0.Tj2b=Tj2b;
        Q0.Td=Td;
    end
end
if(Qk.flag<1)
    %��δ�����ٶ�
    jk=CalcJk1(Q0,InParam);
else
    %������ٶ�
   jk=CalcJk2(Q0,InParam);
end
   Qk=CalcQk(jk,Q0,InParam);
   if(Qk.qk>=InParam.q1)
       Qk.qk=InParam.q1;
       Qk.flag=2;
   end
   Qk.qk=InParam.sigma*Qk.qk;
   Qk.vk=InParam.sigma*Qk.vk;
   Qk.ak=InParam.sigma*Qk.ak;
   Qk.jk=InParam.sigma*Qk.jk;
end

