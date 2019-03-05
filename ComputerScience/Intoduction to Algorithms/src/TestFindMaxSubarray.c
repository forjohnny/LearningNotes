/**
*@brief Description: 
*@  File:TestFindMaxSubarray.c
*@Author:LiBing
*@  Date:2019/02/25
*@  note:     
*@warning: 
*/
#include <stdio.h>
#include "FindMaxSubarray.h"

int main()
{
	double A[16] = { 13,-3,-25,20,-3,-16,-23,18,20,-7,12,-5,-22,15,-4,7 };//�㷨����4.1�ڵ�����
	int low = 0;
	int high = 15;
	double MaxSum;
	int SubLow;
	int SubHigh;
	int ret=FindMaxSubarray(A, low, high, &MaxSum, &SubLow, &SubHigh);
	if (ret)
	{
		printf("FindMaxSubarray error %d\n", ret);
		return 0;
	}

	//��ӡ���
	printf("����A��\n");
	for (int i=low;i<=high;i++)
	{
		printf("%lf ", A[i]);
	}
	printf("\n");
	printf("A�ĺ����ķǿ����������飺\n");
	for (int i=SubLow;i<=SubHigh;i++)
	{
		printf("A[%d]=%lf\t", i,A[i]);
	}
	printf("\n");
	return 0;
}
