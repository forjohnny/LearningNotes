/*************************************************
create on: 2018-1-5
author: LiBing
*************************************************/

#include<math.h>
#include<mp_harmonic.h>

//�˶��滮�����ṹ��
typedef struct {
	double q0;
	double q1;
	double vs;
	double ve;
	double acc;
	double jerk;
	double snap;
	double dT;
	double T;

}mp_para;

//�켣�滮�����ӿ�
mp_para inout;
int mp_harmonic_traj(mp_para *st)
{

}

static int mp_para_initial(mp_para *st)
{
	inout.vs = st->vs;
	inout.ve = st->ve;
	inout.dT = st->dT;

}