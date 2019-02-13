%{
CalcFun.m
S���ٶȹ滮���㷨�Ӻ���
%}
%%
%�Ӻ����������ɹ��ⲿ�ļ�����
function fun=CalcFun
fun.displacement=@displacement;
fun.velocity=@velocity;
fun.acceleration=@acceleration;
fun.jerk=@jerk;
fun.CalcSProfile=@CalcSProfile;
fun.InitialParam=@InitialParam;
end
%%
%�Ӻ�������
%{
����ʽ(3.30a)-(3.30g)��������ʱ�̵�λ��
%}
function q=displacement(t,Param)
q0=Param.q0;
q1=Param.q1;
v0=Param.v0;
v1=Param.v1;
vlim=Param.vlim;
alima=Param.alima;
alimd=Param.alimd;
jmax=Param.jmax;
Tj1=Param.Tj1;
Ta=Param.Ta;
Tv=Param.Tv;
Tj2=Param.Tj2;
Td=Param.Td;
T=Param.T;
jmin=Param.jmin;
if(t>=0 && t<Tj1)
    q=q0+v0*t+jmax*t^3/6;
elseif(t>=Tj1 && t<Ta-Tj1)   
    q=q0+v0*t+alima/6*(3*t^2-3*Tj1*t+Tj1^2);
elseif(t>=Ta-Tj1 && t<Ta)
    q=q0+(vlim+v0)*Ta/2-vlim*(Ta-t)-jmin*(Ta-t)^3/6;
elseif(t>=Ta && t<Ta+Tv)
    q=q0+(vlim+v0)*Ta/2+vlim*(t-Ta);
elseif(t>=T-Td && t<T-Td+Tj2)
    q=q1-(vlim+v1)*Td/2+vlim*(t-T+Td)-jmax*(t-T+Td)^3/6;
elseif(t>=T-Td+Tj2 && t<T-Tj2)
    q=q1-(vlim+v1)*Td/2+vlim*(t-T+Td)+alimd/6*(3*(t-T+Td)^2-3*Tj2*(t-T+Td)+Tj2^2);
else
    q=q1-v1*(T-t)-jmax*(T-t)^3/6;
end
%���㣨3.33��
    q=Param.sigma*q;
end


%{
����ʽ(3.30a)-(3.30g)��������ʱ�̵��ٶ�
%}
function dq=velocity(t,Param)

v0=Param.v0;
v1=Param.v1;
vlim=Param.vlim;
alima=Param.alima;
alimd=Param.alimd;
jmax=Param.jmax;
Tj1=Param.Tj1;
Ta=Param.Ta;
Tv=Param.Tv;
Tj2=Param.Tj2;
Td=Param.Td;
T=Param.T;
jmin=Param.jmin;
if(t>=0 && t<Tj1)
    dq=v0+jmax*t^2/2;
elseif(t>=Tj1 && t<Ta-Tj1)   
    dq=v0+alima*(t-Tj1/2);
elseif(t>=Ta-Tj1 && t<Ta)
    dq=vlim+jmin*(Ta-t)^2/2;
elseif(t>=Ta && t<Ta+Tv)
    dq=vlim;
elseif(t>=T-Td && t<T-Td+Tj2)
    dq=vlim-jmax*(t-T+Td)^2/2;
elseif(t>=T-Td+Tj2 && t<T-Tj2)
    dq=vlim+alimd*(t-T+Td-Tj2/2);
else
    dq=v1+jmax*(T-t)^2/2;
end
%���㣨3.33��
dq=Param.sigma*dq;
end

%{
����ʽ(3.30a)-(3.30g)��������ʱ�̵ļ��ٶ�
%}
function ddq=acceleration(t,Param)

alima=Param.alima;
alimd=Param.alimd;
jmax=Param.jmax;
Tj1=Param.Tj1;
Ta=Param.Ta;
Tv=Param.Tv;
Tj2=Param.Tj2;
Td=Param.Td;
T=Param.T;
jmin=Param.jmin;
if(t>=0 && t<Tj1)
    ddq=jmax*t;
elseif(t>=Tj1 && t<Ta-Tj1)   
    ddq=alima;
elseif(t>=Ta-Tj1 && t<Ta)
    ddq=-jmin*(Ta-t);
elseif(t>=Ta && t<Ta+Tv)
    ddq=0;
elseif(t>=T-Td && t<T-Td+Tj2)
   ddq=-jmax*(t-T+Td);
elseif(t>=T-Td+Tj2 && t<T-Tj2)
    ddq=alimd;
else
    ddq=-jmax*(T-t);
end
%���㣨3.33��
ddq=Param.sigma*ddq;
end

%{
����ʽ(3.30a)-(3.30g)��������ʱ�̵ļӼ��ٶ�
%}
function jt=jerk(t,Param)

jmax=Param.jmax;
Tj1=Param.Tj1;
Ta=Param.Ta;
Tv=Param.Tv;
Tj2=Param.Tj2;
Td=Param.Td;
T=Param.T;
jmin=Param.jmin;
if(t>=0 && t<Tj1)
    jt=jmax;
elseif(t>=Tj1 && t<Ta-Tj1)   
    jt=0;
elseif(t>=Ta-Tj1 && t<Ta)
    jt=jmin;
elseif(t>=Ta && t<Ta+Tv)
    jt=0;
elseif(t>=T-Td && t<T-Td+Tj2)
   jt=jmin;
elseif(t>=T-Td+Tj2 && t<T-Tj2)
    jt=0;
else
    jt=jmax;
end
%���㣨3.33��
jt=Param.sigma*jt;
end

%{
��1�������Ϸ��Լ��
��2����ʼ�������ṹ��
%}
function IniParam=InitialParam(q0,q1,v0,v1,v_max,a_max,j_max)
%������飬����ֵС��1.0E-8����ֵ��Ϊ��0.
if(abs(v_max)<1.0E-8)
    disp('������������ٶȲ���Ϊ0�������˳���');
    return;
end
if(abs(a_max)<1.0E-8)
    disp('�������������ٶȲ���Ϊ0�������˳���');
    return;
end
if(abs(j_max)<1.0E-8)
    disp('�����������Ӽ��ٶȲ���Ϊ0�������˳���');
    return;
end
if(abs(q1-q0)<1.0E-8)
    disp('������������λ�Ʋ���Ϊ0�������˳���');
    return;
end
%%
%���岢��ʼ����������Ľṹ��
if(q1-q0>0)
    sigma=1;
else
    sigma=-1;
end
v_min=-v_max;
j_min=-j_max;
a_min=-a_max;
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
'q0',{hq0},...
'q1',{hq1},...
'v0',{hv0},...
'v1',{hv1},...
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
���������������S���ٶȹ滮��������Param
%}
function Param=CalcSProfile(q0,q1,v0,v1,v_max,a_max,j_max)

%��ʼ������
InParam=InitialParam(q0,q1,v0,v1,v_max,a_max,j_max);
%���岢��ʼ���洢�滮����Ľṹ��
Param=struct(...
 'Tj1',{0},'Ta',{0},'Tv',{0},'Tj2',{0},'Td',{0},'T',{0},...
 'q0',{0},...
 'q1',{0},...
'v0',{0},...
'v1',{0},...
'vlim',{0},...
'alima',{0},...
'alimd',{0},...
'jmax',{0},...
'jmin',{0},...
'sigma',{InParam.sigma}...
);
Param.q0=InParam.q0;
Param.q1=InParam.q1;
Param.v0=InParam.v0;
Param.v1=InParam.v1;
Param.jmax=InParam.jmax;
Param.jmin=InParam.jmin;
%%
%���㣨3.17���ͣ�3.18��
T1=sqrt(abs(InParam.v1-InParam.v0)/InParam.jmax);
T2=InParam.amax/InParam.jmax;
Tjs=min(T1,T2);
if(T1<=T2)
    Dq=InParam.q1-InParam.q0;
    if(Dq<Tjs*(InParam.v0+InParam.v1))
        disp('λ�ƹ�С������������ʼĩ�ٶȵĹ켣�������˳���');
        return;
    end
else
    Dq=InParam.q1-InParam.q0;
    if(Dq<0.5*(InParam.v0+InParam.v1)*(Tjs+abs(InParam.v1-InParam.v0)/InParam.amax))
        disp('λ�ƹ�С������������ʼĩ�ٶȵĹ켣�������˳���');
        return;
    end
end
%%
%���������ȷ�󣨼��켣���ڣ�����������
if((InParam.vmax-InParam.v0)*InParam.jmax<InParam.amax^2)
    %(3.19)����,amax���ܴﵽ
    Tj1=sqrt((InParam.vmax-InParam.v0)/InParam.jmax);
    Ta=2*Tj1;
    Param.alima=InParam.jmax*Tj1;
else
    %(3.19)�����㣬amax�ܴﵽ
    Tj1=InParam.amax/InParam.jmax;
    Ta=Tj1+(InParam.vmax-InParam.v0)/InParam.amax;
    Param.alima=InParam.amax;
end

if((InParam.vmax-InParam.v1)*InParam.jmax<InParam.amax^2)
    %(3.20)����,amin���ܴﵽ
    Tj2=sqrt((InParam.vmax-InParam.v1)/InParam.jmax);
    Td=2*Tj2;
    Param.alimd=-InParam.jmax*Tj2;
else
     %(3.20)������,amin�ܴﵽ
    Tj2=InParam.amax/InParam.jmax;
    Td=Tj2+(InParam.vmax-InParam.v1)/InParam.amax;
    Param.alimd=-InParam.amax;
end
 
%���㣨3.25��
Tv=(InParam.q1-InParam.q0)/InParam.vmax-Ta/2*(1+InParam.v0/InParam.vmax)-...
    Td/2*(1+InParam.v1/InParam.vmax);
if(Tv>0)
    %case1,����ٶ��ܴﵽ
    Param.vlim=InParam.vmax;
    Param.Tj1=Tj1;
    Param.Ta=Ta;
    Param.Tj2=Tj2;
    Param.Td=Td; 
    Param.T=Ta+Tv+Td;
    Param.Tv=Tv;
    return;   
else
   % case2,����ٶȲ��ܴﵽ
   Tv=0;
   Param.Tv=Tv;
   %���㣨3.26a��,(3.27),��3.26b��,��3.26c��
   Tj=InParam.amax/InParam.jmax;
   Tj1=Tj;
   Tj2=Tj;
   Delta=InParam.amax^4/InParam.jmax^2+2*(InParam.v0^2+InParam.v1^2)+InParam.amax*...
       (4*(InParam.q1-InParam.q0)-2*InParam.amax/InParam.jmax*(InParam.v0+InParam.v1));
   Ta=(InParam.amax^2/InParam.jmax-2*InParam.v0+sqrt(Delta))/(2*InParam.amax);
   Td=(InParam.amax^2/InParam.jmax-2*InParam.v1+sqrt(Delta))/(2*InParam.amax);
   if(Ta>2*Tj && Td>2*Tj)
       %���ٶκͼ��ٶζ��ܴﵽ�����ٶ�
       Param.Tj1=Tj1;
       Param.Tj2=Tj2;
       Param.Ta=Ta;
       Param.Td=Td;
       Param.T=Ta+Tv+Td;
       Param.alima=InParam.amax;
       Param.alimd=-InParam.amax;
       Param.vlim=InParam.v0+(Ta-Tj1)*Param.alima;
       return;
   else
       %������һ�β��ܴﵽ�����ٶ�
       gamma=0.99;
       amax=InParam.amax;
       %�𽥼�С�����ٶ�Լ��
       while(Ta<2*Tj || Td<2*Tj)
           if(Ta>0 && Td>0)
               amax=gamma*amax;
                %ѭ�����㣨3.26a��,(3.27),��3.26b��,��3.26c��
               Tj=amax/InParam.jmax;
               Tj1=Tj;
               Tj2=Tj;
               Delta=amax^4/InParam.jmax^2+2*(InParam.v0^2+InParam.v1^2)+amax*...
                   (4*(InParam.q1-InParam.q0)-2*amax/InParam.jmax*(InParam.v0+InParam.v1));
               Ta=(amax^2/InParam.jmax-2*InParam.v0+sqrt(Delta))/(2*amax);
               Td=(amax^2/InParam.jmax-2*InParam.v1+sqrt(Delta))/(2*amax);          
           else
               %����Ta��TdС��0
               if(Ta<=0)
                   Ta=0;
                   Tj1=0;
                   %���㣨3.28a��
                   Td=2*(InParam.q1-InParam.q0)/(InParam.v0+InParam.v1);
                   %���㣨3.28b��
                   num=InParam.jmax*(InParam.q1-InParam.q0)-...
                       sqrt(InParam.jmax*(InParam.jmax*(InParam.q1-InParam.q0)^2+...
                       (InParam.v1+InParam.v0)^2*(InParam.v1-InParam.v0)));
                   den=InParam.jmax*(InParam.v1+InParam.v0);
                   Tj2=num/den;
               elseif(Td<=0)
                   Td=0;
                   Tj2=0;
                   %���㣨3.29a��
                   Ta=2*(InParam.q1-InParam.q0)/(InParam.v0+InParam.v1);
                   %���㣨3.29b��
                    num=InParam.jmax*(InParam.q1-InParam.q0)-...
                       sqrt(InParam.jmax*(InParam.jmax*(InParam.q1-InParam.q0)^2-...
                       (InParam.v1+InParam.v0)^2*(InParam.v1-InParam.v0)));
                   den=InParam.jmax*(InParam.v1+InParam.v0);
                   Tj1=num/den;
               end 
               Param.Tj1=Tj1;
               Param.Tj2=Tj2;
               Param.Ta=Ta;
               Param.Td=Td;
               Param.T=Ta+Tv+Td;
               Param.alima=InParam.jmax*Tj1;
               Param.alimd=-InParam.jmax*Tj2;
               Param.vlim=InParam.v0+(Ta-Tj1)* Param.alima;
               return;             
           end   
       end
       Param.Tj1=Tj1;
       Param.Tj2=Tj2;
       Param.Ta=Ta;
       Param.Td=Td;
       Param.T=Ta+Tv+Td;
       Param.alima=InParam.jmax*Tj1;
       Param.alimd=-InParam.jmax*Tj2;
       Param.vlim=InParam.v0+(Ta-Tj1)* Param.alima;
       return;    
   end    
end

end