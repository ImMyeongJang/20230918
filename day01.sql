select * from tab;
-- ���� Ŀ���� sql�� ����: Ctrl+Enter
-- �ܹ� �ּ�
/* ���� �ּ�
   ���� ���� �ּ�
*/
-- �л���� ���α׷�
-- �л� (Entity) ==>������ (Table)
���̺� ���� ���� (DDL - Date Definition Language)
DDL����: CREATE, DROP, RENAME TO,...
CREATE TABLE ���̺��(
�÷���1 �ڷ���(ũ��) ��������,
�÷���2 �ڷ���(ũ��) ...,
...
);
-----------------------------
--���̺� ����
CREATE TABLE STUDENT(
  NUM NUMBER(4) PRIMARY KEY, --UNIQUE + NOT NULL �й�
  NAME VARCHAR2(30) NOT NULL, --���� ������� ���� �л���
  TEL VARCHAR2(15) NOT NULL, --����ó
  ADDR VARCHAR2(50), --�ּ�
  INDATE DATE DEFAULT SYSDATE, -- ��ϵ� ���� ��¥������ �ڵ����� �־��ش� �����
  SNAME VARCHAR2(30), --�б޸�
  SROOM NUMBER(3) --���ǹ�ȣ
);

DESC STUDENT;

SELECT * FROM TAB;

-- ���̺� ����
-- DROP TABLE ���̺��

DROP TABLE STUDENT; 
-----------------------------------------
--������ ���� - INSERT ��
--
--INSERT INTO ���̺��(�÷���1, �÷���2,...)
--            VALUES (��1, ��2,....)
-----------------------------------------
INSERT INTO STUDENT(NUM, NAME,TEL, ADDR, SNAME, SROOM)
VALUES (1,'ȫ�浿','010-1234-1111','����','�ڹٹ�',201);

--������ ��ȸ----------------------------
--SELECT �÷���1,�÷���2,... FROM ���̺��;
--SELECT * FROM ���̺��
---------------------------------------

SELECT NUM,NAME,SNAME,SROOM FROM STUDENT;

SELECT * FROM STUDENT;

2�� ��ö��   ��õ �ڹٹ� 201  �����͸� ��������

INSERT INTO STUDENT (NAME,NUM,SNAME,SROOM,ADDR,TEL)
VALUES('��ö��',2,'�ڹٹ�',201,'��õ','010-2345-2222');

SELECT * FROM STUDENT;

--DML (INSERT, DELETE, UPDATE��) ������ COMMIT �Ǵ� ROLLBACK ��ɹ��� �̿��ؼ�
--Ʈ������� ������ �ؾ� �Ѵ�
--- COMMIT : �����ͺ��̽��� �����͸� ������ ����
--- ROLLBACK : ��� �ߴ� dml�۾��� ���
COMMIT;

3 �̹α� ����ó, ����, �����͹� 301
INSERT INTO STUDENT(NUM, NAME,TEL, ADDR,SNAME,SROOM)
VALUES(3,'�̹α�','010-3456-3333','����','�����͹�',301);

SELECT * FROM STUDENT;
ROLLBACK;
COMMIT;
--�����͸� ��� ���� �����̸� �÷����� ������ ���� �ʾƵ� �ȴ�
--�ٸ�, ���̺��� ���������� ����� �÷�������� ���� �־�� �ϸ�,
--��� ���� �־�� �Ѵ�

INSERT INTO STUDENT
VALUES(4,'������','010-4545-5656','��õ',SYSDATE,'�����͹�',301);

INSERT INTO STUDENT
VALUES(5,'������','010-7545-7656','�д�','23/09/17',NULL,NULL);
--[X] Pk�� ���� ������� ����

SELECT * FROM STUDENT;
COMMIT;
--------------------------------------------------
5�� �л��� �б޸��� '�ڹٹ�'���� �����ϼ���
UPDATE ��
UPDATE ���̺�� SET �÷���1=��1, �÷���2=��2
WHERE ������;
-------------------------------
UPDATE STUDENT SET SNAME='�ڹٹ�';
-- => ��� ���ڵ尡 ������. WHERE���� ����ϴ� ���� ����
UPDATE STUDENT SET SNAME='�ڹٹ�' WHERE NUM=5;

SELECT * FROM STUDENT;
ROLLBACK;

-- �������� �л��� ���ǹ�ȣ�� 201ȣ�� �����ϼ���
-- UPDATE STUDENT SET SROOM=201 WHERE NAME='������';
ROLLBACK;
UPDATE STUDENT SET SROOM=201, TEL='010-8888-9999', SNAME='�ڹٹ�' WHERE NUM=5;

SELECT * FROM STUDENT;
COMMIT;
------------------------------------
--������ ����: DELETE ��
--DELETE FROM ���̺��
--WHERE ������
----------------------
--2�� ��ö�� �л��� �����͸� �����ϼ���

DELETE FROM STUDENT; -- ��� �����Ͱ� ������
ROLLBACK;

DELETE FROM STUDENT WHERE NUM=2;

SELECT * FROM STUDENT;
COMMIT;
---------------------------
����SW�� �⺻������ ���� ���
CRUD             SQL
C: CREATE  ==> INSERT��
R: READ    ==> SELECT��
U: UPDATE  ==> UPDATE��
D: DELETE  ==> DELETE��
----------------------------

--���̺� ����
--DROP TABLE ���̺��;
-- DDL������ �ﰢ������ ������ ��ģ��

DROP TABLE STUDENT;
SELECT * FROM TAB;

--�б����̺� �����ϱ�
--���̺��: SCLASS
--�÷�:
--�б޹�ȣ: SNUM NUMBER(4) pk
--�б޸�: SNAME VARCHAR2(30) NOT NULL
--���ǹ�ȣ: SROOM NUMBER(3)

CREATE TABLE SCLASS(
    SNUM NUMBER(4) PRIMARY KEY, --�б޹�ȣ
    SNAME VARCHAR2(30) NOT NULL, --�б޸�
    SROOM NUMBER(3)
);

DESC SCLASS;

-- �л����̺� �����
-- �б������� �б����̺��� �б޹�ȣ�� �����ϴ� �ܷ�Ű�� ����� ����

CREATE TABLE STUDENT(
    NUM NUMBER(4) PRIMARY KEY,
    NAME VARCHAR2(30) NOT NULL,
    TEL VARCHAR2(15) NOT NULL,
    ADDR VARCHAR2(50),
    INDATE DATE DEFAULT SYSDATE,
    --�б޹�ȣ�� �ܷ�Ű��
    SNUM_FK NUMBER(4) REFERENCES SCLASS (SNUM) 
);
--�ܷ�Ű(fk)�� �θ� ���̺�(SCLASS)�� pk�� �����ϰų�, UNIQUE ���������� ���� �÷��� �����ؾ� �Ѵ�
--�θ� ���̺� ��ϵ��� ���� ���� �ڽ� ���̺� ��ϵǰų� �����Ǵ� ���� ������� �ʴ´�

--�б� ���̺�
--10 �ڹٹ� 201
--20 �����͹� 301
--30 �ΰ����ɹ� 401
--�����͸� �����ÿ�

INSERT INTO SCLASS VALUES(10,'�ڹٹ�',201);
INSERT INTO SCLASS VALUES(20,'�����͹�',301);
INSERT INTO SCLASS VALUES(30,'�ΰ����ɹ�',401);

SELECT * FROM SCLASS;
COMMIT;

--�л����� �ֱ�
--�ڹٹ� 3��
--1 ȫ�浿 ����ó ���� ����� �б޹�ȣ
--�����͹� 2��
--�ΰ����ɹ� 1��

INSERT INTO STUDENT
VALUES(1,'ȫ�浿','010-1111-1111','����',SYSDATE,10);
INSERT INTO STUDENT
VALUES(2,'��ö��','010-2111-1111','�ϻ�',SYSDATE,10);
INSERT INTO STUDENT
VALUES(3,'�迵��','010-3111-1111','�д�',SYSDATE,10);

SELECT * FROM STUDENT;
COMMIT;

INSERT INTO STUDENT(NUM,NAME,ADDR,SNUM_FK,TEL)
VALUES(4,'�̹α�','��õ',20,'011-4444-5555');
INSERT INTO STUDENT(NUM,NAME,ADDR,SNUM_FK,TEL)
VALUES(5,'�α⿵','����',20,'010-8444-5551');

INSERT INTO STUDENT(NUM,NAME,ADDR,SNUM_FK,TEL)
VALUES(6,'���İ�','����',30,'010-7744-5555');

-- INSERT INTO STUDENT
-- VALUES(7,'��̻�','010-2323-8989','����',SYSDATE,50); --[X]
-- integrity constraint (SCOTT.SYS_C007010) violated - parent key not found

SELECT * FROM STUDENT;

--JOIN �� : 2�� �̻��� ���̺��� �ϳ��� ���ļ� �����ش� 
--�̶� PK�� FK�� ���� �������� ������ �ϴ� ��찡 ���� => EQUI JOIN

SELECT NUM, NAME, SNUM_FK, SNAME, SROOM, TEL, ADDR,INDATE
FROM SCLASS JOIN STUDENT
ON SCLASS.SNUM = STUDENT.SNUM_FK;

�ڹٹ� ������ 201ȣ���� 501ȣ�� ����Ǿ����ϴ�
�б� ���̺� 10�� �б��� ������ 501ȣ�� �����ϼ���

UPDATE SCLASS SET SROOM=501 WHERE SNUM=10;
SELECT * FROM SCLASS;
COMMIT;

SELECT NUM, NAME, SNUM_FK, SNAME, SROOM, TEL, ADDR,INDATE
FROM SCLASS JOIN STUDENT
ON SCLASS.SNUM = STUDENT.SNUM_FK;

�ΰ����ɹ��� ������ ��ҵǾ����
�б����̺��� �ΰ����ɹ�(30��)�� �����ϼ���

DELETE FROM SCLASS WHERE SNUM=30; --[X]
--ORA-02292: integrity constraint (SCOTT.SYS_C007010) violated - child record found

--�ڽ� ���ڵ尡 �����ϰ� �ִ� ���¿��� �θ� ���̺��� �����ִ� �����͸� ������ �� ����
--�ڽ� ���ڵ带 ���� �����, �θ� ���ڵ带 �����غ���

DELETE FROM STUDENT WHERE SNUM_FK=30;
SELECT * FROM STUDENT;

DELETE FROM SCLASS WHERE SNUM=30;

SELECT * FROM SCLASS;
COMMIT;

-- ���θ� ���� �����ͺ��̽�
SELECT * FROM TAB;

SELECT * FROM MEMBER;
SELECT * FROM CATEGORY;
SELECT * FROM PRODUCTS;
SELECT * FROM SUPPLY_COMP;

-- �λ���� ���� �����ͺ��̽�
SELECT * FROM DEPT; --�μ�
SELECT * FROM EMP; --���
SELECT * FROM SALGRADE; --�޿���� ���̺�
-------------------------------------------------------------
# ������ ��ȸ
SELECT * FROM EMP;

������̺��� ���,�����,�μ���ȣ�� ������ �����ּ���

SELECT EMPNO, ENAME, DEPTNO FROM EMP;

���ǥ������ ����� ���� �ִ�.

�����, �޿�, �޿��� 10%�λ���� ������ �����ּ���

SELECT ENAME, SAL, SAL*1.1 AS "SAL UP" FROM EMP;
-- ALIAS (��Ī)�� �����Ҷ� AS "��Ī"

���, �����, �޿�, ���ʽ�(COMM), ������ �����ؼ� �Բ� ����ϼ���
����: �޿�*12 +���ʽ�  ��Ī: 1 YEAR SALARY

SELECT EMPNO, ENAME, JOB,SAL, COMM, SAL*12+COMM "����" , SAL*12+NVL(COMM,0) "1 YEAR SALARY"  FROM EMP;

#NVL�Լ�: NULL���� ������ ������ ��ȯ�Ͽ� �����ϵ��� ��
NVL(�÷�,��ȯ�Ұ�)

#NVL2�Լ�
NVL2(�÷�, ��1, ��2) : �÷����� NULL�� �ƴ� ��쿡�� ��1�� ��ȯ�ϰ�
                    NULL�� ��쿡�� ��2�� ��ȯ�ϴ� �Լ�

--��� ���̺��� ������(MGR)�� �ִ� ���� 1, ������ 0��
--	 ����Ͻÿ� ��Ī�� "���ӻ�� ����"

SELECT EMPNO,ENAME,MGR, NVL2(MGR,1,0) "���� ��� ����"
FROM EMP;


# ���ڿ� ���� ������: ||

SELECT ENAME||' IS A '||JOB FROM EMP;


--����] EMP���̺��� �̸��� ������ "KING: 1 YEAR SALARY = 60000"
--	�������� ����϶�.






















































