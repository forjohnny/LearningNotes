/**
* @file mp_harmonic.c
* @brif 
*
* @author LiBing
* @date 2018/1/9
*/

#include<math.h>
#include<mp_harmonic.h>

#define MP_OK 0			/*�ٶȹ滮�ɹ�*/
#define PARA_ERR 1		/*��������Ƿ�*/


#define MIN_ERR  1.0E-5 /*��ֵ�Ƚ���������*/

//�������
typedef struct {
	double t0;		/*<��ʼʱ��*/
	double t1;
	double q0;
	double q1;
	double dT;
	double vs;
	double ve;
	double acc;
	double jerk;
	double snap;
}input_para;

//�˶��滮�����ṹ��
typedef struct {
	double t0;
	double t1;
	double T;
	double q0;
	double q1;
	double dT;
	double h;
	double vs;
	double ve;
	double acc;
	double jerk;
	double snap;
}mp_para;

//�켣�滮�����ӿ�

int ret = 0;
int mp_harmonic_traj(const input_para *in,mp_para *out)
{
	if ((ret = mp_para_initial(in, out)) != MP_OK)
	{
		return ret;
	}





}


/*��ʼ���������*/
static int mp_para_initial(const input_para *in, mp_para *out)
{	
	
	if (in->t0 < MIN_ERR || in->t1 < MIN_ERR || in->ve<MIN_ERR
		|| in->vs<MIN_ERR ||in->q0<MIN_ERR ||in->q1<MIN_ERR)
	{
		ret = PARA_ERR;
		return ret;
	}
	out->t0 = in->t0;
	out->t1 = in->t1;
	out->T = in->t1 - in->t0;
	out->q0 = in->q0;
	out->q1 = in->q1;
	out->h = in->q1 - in->q0;
	out->vs = in->vs;
	out->ve = in->ve;
	out->dT = in->dT;
	return MP_OK;

}