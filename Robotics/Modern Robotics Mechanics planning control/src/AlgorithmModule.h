/**
*@brief Description: ������ѧ���㷨ģ��ĺ�������.
*@  AlgorithmModule.h
*@Author:LiBing
*@  Date:2019/03/01
*@  note:     
*@warning: 
*/
#ifndef ALGORITHMMODULE_H_
#define ALGORITHMMODULE_H_
#ifdef __cplusplus
extern "C" {

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
	int GrublersFormula(int m, int N,  int J, int *f);





#ifdef __cplusplus
}
#endif

#endif//ALGORITHMMODULE_H_


#endif