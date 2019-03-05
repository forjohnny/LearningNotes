/**
*@brief Description: �鲢�����㷨��ʵ�ֺ���
*@  File:MergeSort.c
*@Author:LiBing
*@  Date:2019/02/24
*@  note:     
*@warning: 
*/

#include <stdlib.h>
#define MALLOC_ERR        1  //��̬�����ڴ�ʧ��
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
int Merge(double *A, int p, int q, int r)
{
	int n1 = q - p + 1;
	int n2 = r - q;
	double *L = (double *)malloc(n1 * sizeof(double));
	if (L==NULL)
	{
		return MALLOC_ERR;
	}
	double *R = (double *)malloc(n2 * sizeof(double));
	if (R == NULL)
	{
		return MALLOC_ERR;
	}
	int i = 0;
	int j = 0;
	int k = 0;
	//�ֽ�AΪL��R
	for (i=0;i<n1;i++)
	{
		L[i] = A[p + i ];
	}
	for (j=0;j<n2;j++)
	{
		R[j] = A[q + j + 1];
	}
	i = 0;
	j = 0;
	//�ϲ�L,R
	for (k = p; k < r + 1; k++)
	{
		if (i<n1&&j<n2)//L��R��δ���������Ҫ�Ƚ�
		{
			if (L[i] <= R[j])
			{
				A[k] = L[i];
				i = i + 1;
			}
			else
			{
				A[k] = R[j];
				j = j + 1;
			}
		}
		else
		{
			//����Ƚϣ�ֱ�ӿ���ʣ���Ԫ��
			if (i<n1)
			{
				A[k] = L[i];
				i = i + 1;
			}
			if (j < n2)
			{
				A[k] = R[j];
				j = j + 1;
			}
		}
	}
	free(L);
	free(R);
	return 0;
}

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
int MergeSort(double *A, int p, int r)
{
	int ret = 0;
	if (p<r)//��Ҫ�����Ԫ�ظ�������1����Ҫ�����������
	{
		int q = (int)((p + r) / 2);
		//�鲢����
		ret=MergeSort(A, p, q);
		if (ret)
		{
			return ret;
		}
		ret=MergeSort(A, q + 1, r);
		if (ret)
		{
			return ret;
		}
		//�ϲ������ź����������
		ret=Merge(A, p, q, r);
		if (ret)
		{
			return ret;
		}
	}
	return 0;
}