/**
*@brief Description:�����㷨�Ӻ���
*@  TestSortFun.c
*@Author:LiBing
*@  Date:2019/02/24
*@  note:     
*@warning: 
*/
#include <stdio.h>
#include "SortFun.h"

int test_Merge();
int test_MergeSort();
int main()
{
	test_MergeSort();
	return 0;
}

//���Ժϲ������Ӻ���
int test_Merge()
{
	double A[10] = { 1,3,4,5,10,2,6,7,8,9 };
	//��������������ֱ�Ϊ[1 ,3,4,5,10]��[2,6,7,8,9]
	int p = 0; 
	int q = 1;
	int r = 3;
	int ret=Merge(A, p, q, r);
	if (ret)
	{
		printf("Merge(A, p, q, r) error %d\n", ret);
	} 
	int i = 0;
	for (i=0;i<r+1;i++)
	{
		printf("%lf\t", A[i]);
	}
	printf("\n");
	return 0;
}

//���Թ鲢�����㷨
int test_MergeSort()
{
	double A[12] = { 3, 4, 1, 2, 9, 8, 6, 32, 15, 16, 11, 7 };
	int p = 0;
	int r = 11;
	int ret = MergeSort(A, p, r);
	if (ret)
	{
		printf("Merge(A, p, q, r) error %d\n", ret);
	}
	int i = 0;
	for (i = 0; i < r + 1; i++)
	{
		printf("%lf\t", A[i]);
	}
	printf("\n");
	return 0;

}