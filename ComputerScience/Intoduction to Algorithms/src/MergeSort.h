/**
*@brief Description: 
*@  File:MergeSort.h
*@Author:LiBing
*@  Date:2019/02/24
*@  note:     
*@warning: 
*/


#ifndef MERGESORT_H_
#define MERGESORT_H_
#ifdef __cplusplus
extern "C" {
#endif
	/**
	*@brief Description:�ϲ������ź��򣨴�С���󣩵������飬�ϲ������в��ź��򣨴�С����.
	*@param[in][out]		A		����A����źϲ�ǰ��������Ԫ�أ��Լ��ϲ����ź����Ԫ��.
	*@param[in]				p		��һ��������L����ʼԪ����A�е��±�.
	*@param[in]				q		��һ��������L�Ľ���Ԫ����A�е��±�.
	*@param[in]				r		�ڶ���������R�Ľ���Ԫ����A�е��±�
	*@return��0���ɹ�������ʧ��.
	*@retval				0		�ɹ�
	*@retval				1		��̬�����ڴ�ʧ��
	*@note:����ʱ�����������ǽ����Ŵ��������A�У�A�п��ܻ�������Ԫ�أ���A=[...,L,R,...];
	*@warning:
	*/
	int Merge(double *A, int p, int q, int r);


	/**
	*@brief Description:���ù鲢�����㷨������A�е�p��Ԫ�ص���r����Ԫ�ؽ������򣨴�С����.
	*@param[in][out]		A		����A���������ǰ��Ԫ�أ��Լ�������Ԫ��.
	*@param[in]				p		��ʼԪ����A�е��±�.
	*@param[in]				r		����Ԫ����A�е��±�.
	*@return��0���ɹ�������ʧ��.
	*@retval				0		�ɹ�
	*@retval				1		��̬�����ڴ�ʧ��
	*@note:����ʱ�����������ǽ����Ŵ��������A�У�A�п��ܻ�������Ԫ�أ���A=[...,L,R,...];
	*@warning:
	*/
	int MergeSort(double *A, int p, int r);


#ifdef __cplusplus
}
#endif 
#endif//MERGESORT_H_