/* VIEW�� ������ ���̺� : ���̺�ó�� ����� �� ���� 
   VIEW�� ������
	1. ���� : ������ ����̳� ������ �����ϰ� ����� �� �ִ�.
	2. ���ȼ� : �߿� �����͸� �ܺηκ��� ���� �� �ִ�. 
	�Ϲ������� ��ȸ �뵵�� ���ȴ�
   VIEW �� ���� ����: ���ο� ������ �� �ִ� SQL���� ����
   VIEW�� ����Ϸ��� ������ �ο��޾ƾ��Ѵ�.
   
*/

-- 

-- ������̺��� ���������� ��ȸ�ϴ� �� �����

CREATE OR REPLACE VIEW SAWON_VIEW_GENDER_MALE
AS SELECT * FROM SAWON WHERE SASEX = '����'

-- �� ����ϱ�
SELECT * FROM SAWON_VIEW_GENDER_MALE

-- ������̺��� �Ի�⵵/�Ի��/�Ի����� ���ϴ� �� �����
CREATE OR REPLACE VIEW SAWONVIEW
AS
	SELECT 
		SABUN, SANAME, SASEX, DEPTNO, SAJOB, SAHIRE, SAMGR, SAPAY,
		TO_NUMBER(TO_CHAR(SAHIRE,'YYYY')) AS HIRED_YEAR,
		TO_NUMBER(TO_CHAR(SAHIRE,'MM')) AS HIRED_MONTH,
		TO_NUMBER(TO_CHAR(SAHIRE,'DD')) AS HIRED_DAY
FROM SAWON

SELECT 
	HIRED_YEAR,
	COUNT(*)
FROM SAWONVIEW
GROUP BY HIRED_YEAR
ORDER BY HIRED_YEAR

-- ���� �信 �Ի� ���� �߰��ϱ�
CREATE OR REPLACE VIEW SAWON_SEASONVIEW
AS(
	SELECT 
	SV.*,
	CASE FLOOR(HIRED_MONTH/3)
	WHEN 1 THEN '��'
	WHEN 2 THEN '����'
	WHEN 3 THEN '����'
	ELSE '�ܿ�'
	END AS HIRED_SEASON
	FROM (SELECT * FROM SAWONVIEW) SV -- INLINE VIEW (������ ������ �Ҹ�Ǵ� �Ͻ����� VIEW) 
)

SELECT * FROM SAWON_SEASONVIEW 

-- ������̺��� �Ի������ �ο����� ���ϱ�
SELECT
HIRED_SEASON,
COUNT(*) AS �ο�
FROM SAWON_SEASONVIEW
GROUP BY HIRED_SEASON

-- �����̺�
CREATE OR REPLACE VIEW GOGEKVIEW
AS
	SELECT 
	GOBUN, 
	GONAME, 
	GOADDR,
	SUBSTR(GOJUMIN,1,7)|| '*******' AS GOJUMIN,
	(
	TO_NUMBER(SUBSTR(GOJUMIN,1,2)) +
		CASE 
		WHEN TO_NUMBER(SUBSTR(GOJUMIN,8,1)) IN(1,2,5,6) THEN 1900
		WHEN TO_NUMBER(SUBSTR(GOJUMIN,8,1)) IN(3,4,7,8) THEN 2000
		ELSE 1800
		END
	) AS BIRTHYEAR,
	GODAM
FROM GOGEK
ORDER BY GOBUN
SELECT * FROM GOGEKVIEW

-- CONNECTIONS PROFILE NAME �� ORACLE_SYSTEM���� �����ϰ� �۾��ؾ���
-- SYSTEM �������κ��� TEST7 ������ �����Ѵ�.
CREATE USER TEST7 IDENTIFIED BY TEST7
GRANT CONNECT TO TEST7

-- GOGEKVIEW�� ���� ������(SELECT)�� TEST7���� �ο��ϱ�
-- �ش簳ü�� ���� ������ ������(DBO)�� �ο��Ѵ�.
GRANT SELECT ON GOGEKVIEW TO TEST7

SELECT * FROM test.GOGEKVIEW







