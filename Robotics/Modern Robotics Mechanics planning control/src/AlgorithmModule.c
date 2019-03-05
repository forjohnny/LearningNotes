/**
*@brief Description: ������ѧ���㷨ģ��ĺ���ʵ��.
*@  File:AlgorithmModule.c
*@Author:LiBing
*@  Date:2019/03/01
*@  note:     
*@warning: 
*/

/**
*@brief Description:ʹ��GrublersFormula��ʽ������������ɶ�.
*@param[in]		N		���˵���Ŀ��������أ�.
*@param[in]		m		����(����)�����ɶȣ�ƽ�����m=3,�ռ����m=6��.
*@param[in]		J		�ؽڵ�����.
*@param[in]		f		���飬ÿ���ؽڵ����ɶ�.
*@return				��������û��������ɶ�.
*@note:					�����ؽڵ�Լ���Ƕ����Ĳ���ʹ�øú���������������ɶ�.
*@waring:
*/
int GrublersFormula(int m, int N, int J, int *f)
{
	int i;
	int dof;
	int c = 0;
	for (i=1;i<=J;i++)
	{
		//�������ɶȵ�Լ��
		c = c + f[i-1];
	}
	dof = m*(N - 1 - J) + c;
	return dof;
}

