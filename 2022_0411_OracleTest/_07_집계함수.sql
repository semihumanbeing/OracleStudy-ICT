-- �����Լ�
-- count(�ʵ�): ������ ���� ���ϱ� (null ������)
-- count(*): ��ü ���ڵ� �� ���ϱ�
select count(*), count(samgr) from sawon

-- sum(����): �������� ��
-- avg(����): �������� ���
-- max(����): ������ ���� �ִ밪
-- min(����): ������ ���� �ּҰ�

select 
	sum(sapay) as ��ü�޿�, 
	floor(avg(sapay)) as ��ձ޿�,
	max(sapay) as �ִ�޿���,
	min(sapay) as �ּұ޿���,
	max(sahire) as �ֱ��Ի�����,
	min(sahire) as �����Ի�����
from sawon

