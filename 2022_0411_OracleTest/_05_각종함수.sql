-- ���ڿ� �Լ�

-- concat ����
select concat('www.','oracleclub')||'.com' name from dual;

-- Lpad Rpad : ����� ���� �ڸ������� ��ü �ڸ����� Ŭ�� ������� �������� ä���� ���ϴ� �Լ�
select LPad('oracleclub', 12, '*') name from dual
union all
select Rpad('oracleclub', 12, '*') name from dual

-- substr : Ư�� ���ڿ� ��ȯ (�ڹٿʹ� �ٸ��� �迭�� 1���� �����Ѵ�)
select substr('oracleclub', 3) name from dual;
-- n��° ���� m���� ���ڿ� ��ȯ
select substr('oracleclub', 3, 4) name from dual
-- �ڿ��� n��° ���� m���� ���ڿ� ��ȯ
select substr('oracleclub', -3, 2) name from dual

-- ���ڿ��� length �� ��ȸ�ϴ� �Լ�
select length('oracleclub') len from dual

-- ���ڿ��� replace �ϴ� �Լ�(��ҹ��ڸ� �����Ѵ�)
select replace('oracleclub', 'oracle', 'sql') name from dual

-- union : ������ ���ڵ�� 1���� ����
-- union all : ��� ����
select * from dept
union all
select * from dept where deptno<30

-- ������: 18����
select '�Դ�����', sysdate, '��������', add_months(sysdate,18) from dual;

-- ���� ��ƿ� �ϼ� 
select months_between(sysdate, to_date('1996-3-12', 'YYYY-MM-DD')) as ��ƿ¿���,
	   sysdate - to_date('1996-3-12', 'YYYY-MM-DD') as ��ƿ��ϼ�
from dual

-- �Ҽ��� 1�ڸ��� ������ ���� �� trunc(����,���ڸ������� ����) �ϸ� �ȴ�.
select 
	   trunc(months_between(sysdate, to_date('1996-3-12', 'YYYY-MM-DD')),1) as ��ƿ¿���,
	   trunc(sysdate - to_date('1996-3-12', 'YYYY-MM-DD'),1) as ��ƿ��ϼ�
from dual

-- ������̺��� �� �������� �ٹ����, �ٹ����� ���ϱ�
select * from  sawon

select sabun, saname, sahire, sapay,
	floor(months_between(sysdate, sahire)/12) as �ٹ����,
	floor(mod(months_between(sysdate,sahire),12)) as �ܿ�����,
	floor(months_between(sysdate,sahire)) as �ѱٹ�����,
	floor(sapay/13)||'����' as ����,
	-- ������1 ���� * �ٹ���� + ���� * �ܿ����� / 12
	floor(sapay/13) * floor(months_between(sysdate,sahire)/12) + 
	floor(floor(sapay/13) * floor(mod(months_between(sysdate,sahire),12))/12) ||'����' as ������1,
	-- ������2 ����/12 * �ѱٹ�����
	floor(trunc((sapay/13/12),1) * floor(months_between(sysdate,sahire)))||'����' as ������2
from sawon

-- ������ ������ ���� (������ ������ ���ԵȰ��)
-- ����: ���� = ����/13 
select sabun, saname, sapay,
	floor(months_between(sysdate, sahire)/12) as �ٹ����,
	floor(mod(months_between(sysdate,sahire),12)) as �ܿ�����,
	floor(months_between(sysdate,sahire)) as �ѱٹ�����,
from sawon

-- ����: ���� = ����/12

-- �Լ���
select * from gogek
where substr(goaddr,1,2) = '����'

select * from gogek
where substr(gojumin,8,1) in ('0', '2', '4', '6', '8') as test1
where mod(to_number(substr(gojumin,8,1)),2)=0



