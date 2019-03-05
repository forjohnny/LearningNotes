/**
*@brief Description: 
*@  File:GetMaximumSubarray.c
*@Author:LiBing
*@  Date:2019/02/24
*@  note:     
*@warning: 
*/
#include <limits.h>

#define INDEX_ERR	1  //�����������������HighС��low.
/**
*@brief Description:Ѱ�ҿ�Խ����A�м�㣨A[low...mid]��A[mid+1...high]�������������.
*@param[in]		A			��������.
*@param[in]		low			��ʼԪ�ص��±�.
*@param[in]		high		ĩβԪ�ص��±�.
*@param[in]		mid			�м���Ԫ�أ���������ĩβԪ�أ����±�.
*@param[out]	CrossSum	��������������Ԫ��֮��.
*@param[out]	CrossLow	��������ʼԪ�ص��±�.
*@param[out]	CrossHigh	������ĩβԪ�ص��±�.
*@note:			
*@waring:
*/
int FindMaxCrossingSubarray(double *A, int low, int mid, int high, double *CrossSum, int *CrossLow, int *CrossHigh)
{
	double LeftSum = INT_MIN;
	double RightSum = INT_MIN;
	double sum = A[mid];
	int i = 0;
	int MaxLeft = mid;
	int MaxRight = mid+1;
	for (i=mid;i>=low;i--)
	{
		sum = sum + A[i];
		if (sum>LeftSum)
		{
			LeftSum = sum;
			MaxLeft = i;
		}
	}
	sum = 0;
	for (i=mid+1;i<=high;i++)
	{
		sum = sum + A[i];
		if (sum>RightSum)
		{
			RightSum = sum;
			MaxRight = i;
		}
	}
	*CrossSum = LeftSum + RightSum;
	*CrossLow = MaxLeft;
	*CrossHigh = MaxRight;
	return 0;
}

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
int FindMaxSubarray(double *A, int low, int high, double *MaxSum, int *SubLow, int *SubHigh)
{
	int mid = 0;
	int LeftLow;
	int LeftHigh;
	int RightLow;
	int RightHigh;
	int CrossLow;
	int CrossHigh;
	double LeftSum;
	double RightSum;
	double CrossSum;
	int ret = 0;
	if (high<low)//������������
	{
		return INDEX_ERR;
	}
	if (high==low)//ֻ��һ��Ԫ��
	{
		*MaxSum = A[low];
		*SubLow = low;
		*SubHigh = low;
	}
	else
	{
		//�ֽ�������
		mid = (int)((low + high) / 2);
		//Ѱ���м���������������
		ret=FindMaxSubarray(A, low, mid, &LeftSum, &LeftLow, &LeftHigh);
		if (ret)
		{
			return ret;
		}
		//Ѱ���м���Ҳ�����������
		ret = FindMaxSubarray(A, mid+1, high, &RightSum, &RightLow, &RightHigh);
		if (ret)
		{
			return ret;
		}
		//Ѱ�ҿ�Խ�м������������
		ret = FindMaxCrossingSubarray(A, low, mid, high, &CrossSum, &CrossLow, &CrossHigh);
		if (ret)
		{
			return ret;
		}
		//������Ľ�ϳ�ԭ����Ľ�
		if (LeftSum>=RightSum && LeftSum>=CrossSum)
		{
			*MaxSum = LeftSum;
			*SubLow = LeftLow;
			*SubHigh = LeftHigh;
		}
		else if (RightSum>=LeftSum && RightSum>=CrossSum)
		{
			*MaxSum = RightSum;
			*SubLow = RightLow;
			*SubHigh = RightHigh;
		}
		else
		{
			*MaxSum = CrossSum;
			*SubLow = CrossLow;
			*SubHigh = CrossHigh;
		}
	}
	return 0;
}