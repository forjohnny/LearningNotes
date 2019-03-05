/**
*@brief Description: 
*@  File:GetMaximumSubarray.h
*@Author:LiBing
*@  Date:2019/02/24
*@  note:     
*@warning: 
*/
#ifndef FINDMAXSUBARRAY_H_
#define FINDMAXSUBARRAY_H_
#ifdef __cplusplus
extern "C" {
#endif
	/**
	*@brief Description:Ѱ������A����ָ��A������Ԫ�ع��ɵ����飩�����ķǿ�����������.
	*@param[in]		A		��������.
	*@param[in]		low		��ʼԪ�ص��±�.
	*@param[in]		high	ĩβԪ�ص��±�.
	*@param[out]	MaxSum	��������������Ԫ��֮��.
	*@param[out]	SubLow	��������ʼԪ�ص��±�.
	*@param[out]	SubHigh	������ĩβԪ�ص��±�.
	*@return		����0ִ�гɹ������ط���ִ��ʧ��.
	*@retval		0	ִ�гɹ�
	*@retval		1	�����������������HighС��low.
	*@note:			��������ָ��������±�p,q,ʹ�ø��㷨����Ѱ��A��ĳ��������Ԫ�ع��ɵ��������������飬
	*				��ҪѰ����������A�����������ʱ��p=0,rΪA��ĩβԪ�ص��±�.
	*@waring:
	*/
	int FindMaxSubarray(double *A, int low, int high, double *MaxSum, int *SubLow, int *SubHigh);

#ifdef __cplusplus
}
#endif
#endif//FINDMAXSUBARRAY_H_