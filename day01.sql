select * from tab;
-- 현재 커서의 sql문 실행: Ctrl+Enter
-- 단문 주석
/* 복문 주석
   여러 라인 주석
*/
-- 학사관리 프로그램
-- 학생 (Entity) ==>물리적 (Table)
테이블 생성 문장 (DDL - Date Definition Language)
DDL문장: CREATE, DROP, RENAME TO,...
CREATE TABLE 테이블명(
컬럼명1 자료형(크기) 제약조건,
컬럼명2 자료형(크기) ...,
...
);
-----------------------------
--테이블 생성
CREATE TABLE STUDENT(
  NUM NUMBER(4) PRIMARY KEY, --UNIQUE + NOT NULL 학번
  NAME VARCHAR2(30) NOT NULL, --널을 허용하지 않음 학생명
  TEL VARCHAR2(15) NOT NULL, --연락처
  ADDR VARCHAR2(50), --주소
  INDATE DATE DEFAULT SYSDATE, -- 등록된 날의 날짜정보를 자동으로 넣어준다 등록일
  SNAME VARCHAR2(30), --학급명
  SROOM NUMBER(3) --교실번호
);

DESC STUDENT;

SELECT * FROM TAB;

-- 테이블 삭제
-- DROP TABLE 테이블명

DROP TABLE STUDENT; 
-----------------------------------------
--데이터 삽입 - INSERT 문
--
--INSERT INTO 테이블명(컬럼명1, 컬럼명2,...)
--            VALUES (값1, 값2,....)
-----------------------------------------
INSERT INTO STUDENT(NUM, NAME,TEL, ADDR, SNAME, SROOM)
VALUES (1,'홍길동','010-1234-1111','서울','자바반',201);

--데이터 조회----------------------------
--SELECT 컬럼명1,컬럼명2,... FROM 테이블명;
--SELECT * FROM 테이블명
---------------------------------------

SELECT NUM,NAME,SNAME,SROOM FROM STUDENT;

SELECT * FROM STUDENT;

2번 최철수   인천 자바반 201  데이터를 넣으세요

INSERT INTO STUDENT (NAME,NUM,SNAME,SROOM,ADDR,TEL)
VALUES('최철수',2,'자바반',201,'인천','010-2345-2222');

SELECT * FROM STUDENT;

--DML (INSERT, DELETE, UPDATE문) 문장은 COMMIT 또는 ROLLBACK 명령문을 이용해서
--트랙잭션을 마무리 해야 한다
--- COMMIT : 데이터베이스에 데이터를 영구히 저장
--- ROLLBACK : 방금 했던 dml작업을 취소
COMMIT;

3 이민기 연락처, 수원, 빅데이터반 301
INSERT INTO STUDENT(NUM, NAME,TEL, ADDR,SNAME,SROOM)
VALUES(3,'이민기','010-3456-3333','수원','빅데이터반',301);

SELECT * FROM STUDENT;
ROLLBACK;
COMMIT;
--데이터를 모두 넣을 생각이면 컬럼명을 지정을 하지 않아도 된다
--다만, 테이블을 생성했을때 기술한 컬럼순서대로 값을 넣어야 하며,
--모든 값을 넣어야 한다

INSERT INTO STUDENT
VALUES(4,'이차돌','010-4545-5656','부천',SYSDATE,'빅데이터반',301);

INSERT INTO STUDENT
VALUES(5,'이차돌','010-7545-7656','분당','23/09/17',NULL,NULL);
--[X] Pk는 널을 허용하지 않음

SELECT * FROM STUDENT;
COMMIT;
--------------------------------------------------
5번 학생의 학급명을 '자바반'으로 수정하세요
UPDATE 문
UPDATE 테이블명 SET 컬럼명1=값1, 컬럼명2=값2
WHERE 조건절;
-------------------------------
UPDATE STUDENT SET SNAME='자바반';
-- => 모든 레코드가 수정됨. WHERE절을 명시하는 것이 좋다
UPDATE STUDENT SET SNAME='자바반' WHERE NUM=5;

SELECT * FROM STUDENT;
ROLLBACK;

-- 이차돌인 학생의 교실번호를 201호로 수정하세요
-- UPDATE STUDENT SET SROOM=201 WHERE NAME='이차돌';
ROLLBACK;
UPDATE STUDENT SET SROOM=201, TEL='010-8888-9999', SNAME='자바반' WHERE NUM=5;

SELECT * FROM STUDENT;
COMMIT;
------------------------------------
--데이터 삭제: DELETE 문
--DELETE FROM 테이블명
--WHERE 조건절
----------------------
--2번 최철수 학생의 데이터를 삭제하세요

DELETE FROM STUDENT; -- 모든 데이터가 삭제됨
ROLLBACK;

DELETE FROM STUDENT WHERE NUM=2;

SELECT * FROM STUDENT;
COMMIT;
---------------------------
응용SW가 기본적으로 갖는 기능
CRUD             SQL
C: CREATE  ==> INSERT문
R: READ    ==> SELECT문
U: UPDATE  ==> UPDATE문
D: DELETE  ==> DELETE문
----------------------------

--테이블 삭제
--DROP TABLE 테이블명;
-- DDL문장은 즉각적으로 영향을 미친다

DROP TABLE STUDENT;
SELECT * FROM TAB;

--학급테이블 생성하기
--테이블명: SCLASS
--컬럼:
--학급번호: SNUM NUMBER(4) pk
--학급명: SNAME VARCHAR2(30) NOT NULL
--교실번호: SROOM NUMBER(3)

CREATE TABLE SCLASS(
    SNUM NUMBER(4) PRIMARY KEY, --학급번호
    SNAME VARCHAR2(30) NOT NULL, --학급명
    SROOM NUMBER(3)
);

DESC SCLASS;

-- 학생테이블 만들기
-- 학급정보에 학급테이블의 학급번호를 참조하는 외래키로 만들어 보자

CREATE TABLE STUDENT(
    NUM NUMBER(4) PRIMARY KEY,
    NAME VARCHAR2(30) NOT NULL,
    TEL VARCHAR2(15) NOT NULL,
    ADDR VARCHAR2(50),
    INDATE DATE DEFAULT SYSDATE,
    --학급번호를 외래키로
    SNUM_FK NUMBER(4) REFERENCES SCLASS (SNUM) 
);
--외래키(fk)는 부모 테이블(SCLASS)의 pk를 참조하거나, UNIQUE 제약조건을 갖는 컬럼을 참조해야 한다
--부모 테이블에 등록되지 않은 값이 자식 테이블에 등록되거나 수정되는 것을 허용하지 않는다

--학급 테이블에
--10 자바반 201
--20 빅데이터반 301
--30 인공지능반 401
--데이터를 넣으시오

INSERT INTO SCLASS VALUES(10,'자바반',201);
INSERT INTO SCLASS VALUES(20,'빅데이터반',301);
INSERT INTO SCLASS VALUES(30,'인공지능반',401);

SELECT * FROM SCLASS;
COMMIT;

--학생정보 넣기
--자바반 3명
--1 홍길동 연락처 서울 등록일 학급번호
--빅데이터반 2명
--인공지능반 1명

INSERT INTO STUDENT
VALUES(1,'홍길동','010-1111-1111','서울',SYSDATE,10);
INSERT INTO STUDENT
VALUES(2,'이철수','010-2111-1111','일산',SYSDATE,10);
INSERT INTO STUDENT
VALUES(3,'김영희','010-3111-1111','분당',SYSDATE,10);

SELECT * FROM STUDENT;
COMMIT;

INSERT INTO STUDENT(NUM,NAME,ADDR,SNUM_FK,TEL)
VALUES(4,'이민기','인천',20,'011-4444-5555');
INSERT INTO STUDENT(NUM,NAME,ADDR,SNUM_FK,TEL)
VALUES(5,'민기영','수원',20,'010-8444-5551');

INSERT INTO STUDENT(NUM,NAME,ADDR,SNUM_FK,TEL)
VALUES(6,'알파고','서울',30,'010-7744-5555');

-- INSERT INTO STUDENT
-- VALUES(7,'김미상','010-2323-8989','서울',SYSDATE,50); --[X]
-- integrity constraint (SCOTT.SYS_C007010) violated - parent key not found

SELECT * FROM STUDENT;

--JOIN 문 : 2개 이상의 테이블을 하나로 합쳐서 보여준다 
--이때 PK와 FK가 같은 조건으로 조인을 하는 경우가 많다 => EQUI JOIN

SELECT NUM, NAME, SNUM_FK, SNAME, SROOM, TEL, ADDR,INDATE
FROM SCLASS JOIN STUDENT
ON SCLASS.SNUM = STUDENT.SNUM_FK;

자바반 교실을 201호에서 501호로 변경되었습니다
학급 테이블에 10번 학급의 교시을 501호로 변경하세요

UPDATE SCLASS SET SROOM=501 WHERE SNUM=10;
SELECT * FROM SCLASS;
COMMIT;

SELECT NUM, NAME, SNUM_FK, SNAME, SROOM, TEL, ADDR,INDATE
FROM SCLASS JOIN STUDENT
ON SCLASS.SNUM = STUDENT.SNUM_FK;

인공지능반의 개강이 취소되었어요
학급테이블에서 인공지능반(30번)을 삭제하세요

DELETE FROM SCLASS WHERE SNUM=30; --[X]
--ORA-02292: integrity constraint (SCOTT.SYS_C007010) violated - child record found

--자식 레코드가 존재하고 있는 상태에서 부모 테이블의 관련있는 데이터를 삭제할 수 없다
--자식 레코드를 먼저 지우고, 부모 레코드를 삭제해보자

DELETE FROM STUDENT WHERE SNUM_FK=30;
SELECT * FROM STUDENT;

DELETE FROM SCLASS WHERE SNUM=30;

SELECT * FROM SCLASS;
COMMIT;

-- 쇼핑몰 관련 데이터베이스
SELECT * FROM TAB;

SELECT * FROM MEMBER;
SELECT * FROM CATEGORY;
SELECT * FROM PRODUCTS;
SELECT * FROM SUPPLY_COMP;

-- 인사관리 관련 데이터베이스
SELECT * FROM DEPT; --부서
SELECT * FROM EMP; --사원
SELECT * FROM SALGRADE; --급여등급 테이블
-------------------------------------------------------------
# 데이터 조회
SELECT * FROM EMP;

사원테이블에서 사번,사원명,부서번호를 가져와 보여주세요

SELECT EMPNO, ENAME, DEPTNO FROM EMP;

산술표현식을 사용할 수도 있다.

사원명, 급여, 급여의 10%인상액을 가져와 보여주세요

SELECT ENAME, SAL, SAL*1.1 AS "SAL UP" FROM EMP;
-- ALIAS (별칭)을 지정할때 AS "별칭"

사번, 사원명, 급여, 보너스(COMM), 연봉을 연산해서 함께 출력하세요
연봉: 급여*12 +보너스  별칭: 1 YEAR SALARY

SELECT EMPNO, ENAME, JOB,SAL, COMM, SAL*12+COMM "연봉" , SAL*12+NVL(COMM,0) "1 YEAR SALARY"  FROM EMP;

#NVL함수: NULL값을 지정된 값으로 변환하여 연산하도록 함
NVL(컬럼,변환할값)

#NVL2함수
NVL2(컬럼, 값1, 값2) : 컬럼값이 NULL이 아닐 경우에는 값1을 반환하고
                    NULL일 경우에는 값2를 반환하는 함수

--사원 테이블에서 관리자(MGR)이 있는 경우는 1, 없으면 0을
--	 출력하시오 별칭은 "직속상관 유무"

SELECT EMPNO,ENAME,MGR, NVL2(MGR,1,0) "직속 상관 유무"
FROM EMP;


# 문자열 결합 연산자: ||

SELECT ENAME||' IS A '||JOB FROM EMP;


--문제] EMP테이블에서 이름과 연봉을 "KING: 1 YEAR SALARY = 60000"
--	형식으로 출력하라.






















































