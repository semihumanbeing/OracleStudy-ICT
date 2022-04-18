/*
 DDL (Data definition language): create drop alter
 1. ���� ����
 create user test identified by test
 
 DCL (Data control language): grant(�ο�) revoke(���)
 2. ���� �ο�
 grant connect to test -- ���� ����
 grant resource to test  -- �ڿ� ���� (table/view������)
 
 grant connect, resource to test -- 2�� ����� �ѹ��� ó���ϱ�
 
 3. ���� ȸ��
 revoke connect, resource from test
 
 
 -- ��ü����: scott �� test���� scott.dept�� ��ȸ�� �� �ִ� ���� �ο��ϱ�
       (����)     (���)
 grant select on dept to test -- ���� �ο�
 
 revoke select on dept from test -- ���� ȸ��
 
  
 */
