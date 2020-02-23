DROP TABLE JOB CASCADE CONSTRAINTS;
DROP TABLE DEPARTMENT CASCADE CONSTRAINTS;
DROP TABLE EMPLOYEE CASCADE CONSTRAINTS;
DROP TABLE WT_TYPE CASCADE CONSTRAINTS;
DROP TABLE WORKTIME CASCADE CONSTRAINTS;
DROP TABLE BOARD_NOTICE CASCADE CONSTRAINTS;
DROP TABLE BOARD_NORMAL CASCADE CONSTRAINTS;
DROP TABLE BOARD_NORMAL_COMMENT CASCADE CONSTRAINTS;
DROP TABLE CCALENDAR CASCADE CONSTRAINTS;
DROP TABLE APPROVAL_FILES CASCADE CONSTRAINTS;
DROP TABLE PROFILE_FILES CASCADE CONSTRAINTS;
DROP TABLE APPROVAL CASCADE CONSTRAINTS;
DROP TABLE LEAVE CASCADE CONSTRAINTS;
DROP TABLE LEAVE_COUNT CASCADE CONSTRAINTS;
DROP TABLE TA_DATA CASCADE CONSTRAINTS;
DROP TABLE WEEK_OVERTIME CASCADE CONSTRAINTS;
DROP TABLE ROUNDTABLE CASCADE CONSTRAINTS;
DROP TABLE PAYTABLE CASCADE CONSTRAINTS;
DROP TABLE VACTABLE CASCADE CONSTRAINTS;
DROP TABLE STAMP CASCADE CONSTRAINTS;
DROP TABLE BOARD_CATEGORY CASCADE CONSTRAINTS;
DROP TABLE APPROLINE CASCADE CONSTRAINTS;
DROP SEQUENCE SEQ_NNO;
DROP SEQUENCE SEQ_BNO;
DROP SEQUENCE SEQ_EMP;
DROP SEQUENCE SEQ_APPRO;
BEGIN 
    DBMS_SCHEDULER.DROP_JOB( JOB_NAME => 'LCOUNT_RESET_L2L3_JOB', FORCE => false);
END ;
/
BEGIN 
    DBMS_SCHEDULER.DROP_JOB( JOB_NAME => 'LCOUNT_RESET_L1_JOB', FORCE => false);
END ;
/


--부서
CREATE TABLE DEPARTMENT(
  DEPT_ID VARCHAR(3) PRIMARY KEY,
  DEPT_TITLE VARCHAR2(20) NOT NULL UNIQUE
 );

--직급
 CREATE TABLE JOB(
  JOB_CODE VARCHAR(3) PRIMARY KEY,
  JOB_NAME VARCHAR2(20) NOT NULL UNIQUE
  );


--사원
CREATE TABLE EMPLOYEE(
  EMP_ID VARCHAR2(50) NOT NULL UNIQUE,
  EMP_CODE NUMBER(3) PRIMARY KEY,
  PWD VARCHAR2(500) NOT NULL,
  EMP_NAME VARCHAR2(20) NOT NULL,
  EMP_ENAME VARCHAR2(30) NOT NULL,
  PERSONAL_ID VARCHAR2(14) NOT NULL UNIQUE,
  EMAIL VARCHAR2(25) NOT NULL UNIQUE,
  GENDER CHAR(1 BYTE) CHECK(GENDER IN('M','F')),
  AGE NUMBER(2) NOT NULL,
  SALARY NUMBER(10) DEFAULT 0,
  CONTACT VARCHAR2(13),
  PHONE VARCHAR2(13) NOT NULL,
  ADDRESS VARCHAR2(500) NOT NULL,
  DEPT_CODE VARCHAR2(3),
  JOB_CODE VARCHAR2(3),
  MANAGER_YN VARCHAR2(1) DEFAULT 'N' CHECK(MANAGER_YN IN('Y','N')),
  HIRE_DATE DATE DEFAULT SYSDATE,
  ETC VARCHAR2(300),
  SUB_DEPT CHAR(2),
  
  CONSTRAINT EMPDEPT FOREIGN KEY (DEPT_CODE) REFERENCES DEPARTMENT ON DELETE CASCADE,
  CONSTRAINT EMPJOB FOREIGN KEY (JOB_CODE) REFERENCES JOB ON DELETE CASCADE
  
);
--게시판 종류 테이블
  CREATE TABLE BOARD_CATEGORY(
  TYPE NUMBER(1) NOT NULL,
  CNAME VARCHAR2(20),
  
  CONSTRAINT PK_TYPE PRIMARY KEY(TYPE)
  );

--게시판 값 입력
  INSERT INTO BOARD_CATEGORY VALUES(1,'전체');
  INSERT INTO BOARD_CATEGORY VALUES(2,'일반');
  INSERT INTO BOARD_CATEGORY VALUES(3,'업무');
  INSERT INTO BOARD_CATEGORY VALUES(4,'부서별');

--공지사항 게시판
  CREATE TABLE BOARD_NOTICE(
  NNO NUMBER,
  NTYPE NUMBER,
  NTITLE VARCHAR2(300),
  NCONTENT VARCHAR2(2000),
  NWRITER VARCHAR2(30),
  NCOUNT NUMBER,
  NDATE DATE,
  NCATEGORY VARCHAR2(30)
  );
			       
 ALTER TABLE BOARD_NOTICE MODIFY NDATE DEFAULT SYSDATE;
			       
-- EMPLOYEE 시퀀스
 CREATE SEQUENCE SEQ_EMP
 START WITH 241
 INCREMENT BY 1
 MAXVALUE 300
 NOCYCLE
 NOCACHE;


-- 공지사항 등록을 위한 시퀀스 입니다. 
 CREATE SEQUENCE SEQ_NNO
 START WITH 1
 INCREMENT BY 1
 NOCYCLE
 NOCACHE;
 
 -- 게시판 시퀀스
 CREATE SEQUENCE SEQ_BNO
 START WITH 1
 INCREMENT BY 1
 NOCYCLE
 NOCACHE;
  
--게시판
  CREATE TABLE BOARD_NORMAL(
  BNO NUMBER NOT NULL,
  BTYPE NUMBER CHECK(BTYPE BETWEEN 1 AND 4),
  BTITLE VARCHAR2(500),
  BCONTENT VARCHAR2(2000),
  BWRITER VARCHAR2(30),
  BCOUNT NUMBER DEFAULT 0,
  BDATE DATE,
  STATUS VARCHAR2(1) DEFAULT 'Y' CHECK(STATUS IN('Y','N')),
  BCATEGORY VARCHAR2(30),
  BDEPT_CODE VARCHAR2(15),
  
  CONSTRAINT FK_BTYPE FOREIGN KEY(BTYPE) REFERENCES BOARD_CATEGORY ON DELETE CASCADE
  );

--게시판(부서) 댓글형
  CREATE TABLE BOARD_NORMAL_COMMENT(
  CNO NUMBER,
  BNO NUMBER,
  CCONTTENT VARCHAR2(2000),
  CWRITER VARCHAR2(15),
  CDATE DATE,
  REF_CNO NUMBER,
  CLEVEL NUMBER
  );
  
--달력
  CREATE TABLE CCALENDAR(
  EMP_CODE NUMBER(3),
  CDATE DATE,
  TO_DO VARCHAR2(50),
  DDATE DATE,
  CTITLE VARCHAR2(50)
  );
  
  
--결제문서파일
 CREATE TABLE APPROVAL_FILES(
  DOC_NUMBER VARCHAR2(300),
  DOC_FILES VARCHAR2(500)
);

--프로필 사진 파일
 CREATE TABLE PROFILE_FILES(
 EMP_PIC NUMBER(3),
 PIC VARCHAR2(2000),
 FOREIGN KEY (EMP_PIC) REFERENCES EMPLOYEE ON DELETE CASCADE
 );

--결제게시판
   CREATE TABLE APPROVAL(
 DOC_NUMBER NUMBER CONSTRAINT APPDOC_PK PRIMARY KEY,  -- 문서번호, 트리거
 ATITLE VARCHAR2(500) NOT NULL,  -- 제목
 AWRITER NUMBER(15) NOT NULL, -- 작성자 코드
 AWRITERNAME VARCHAR2(30), --작성자 이름
 DEPT_TITLE VARCHAR2(20) NOT NULL, --결재명
 DOC_TYPE VARCHAR2(50) NOT NULL, -- 문서 타입
 ASTATUS NUMBER CHECK(ASTATUS IN(0,1,2,3)), -- 문서 진행상황 0: 내부결재 진행, 1: 합의 부서 진행  2: 결재 완료 3: 반려
 APPROVER VARCHAR2(200) NOT NULL, -- 해당 결재자
 IN_DEPTNAME VARCHAR2(40) NOT NULL, -- 결재 부서 
 INPEOPLE VARCHAR2(500)NOT NULL, --결재인원 
 INSTATUS VARCHAR2(500),  --결재인원당 결재상태
 COL_DEPTNAME  VARCHAR2(40), -- 합의 부서명
 COL_PEOPLE VARCHAR2(1000), -- 합의 부서 인원 코드
 COL_STATUS VARCHAR2(500), -- 합의부서당 결재 상태
 VIEW_PEOPLE VARCHAR2(1000), -- 참조 인원
 DOC_DATE DATE DEFAULT SYSDATE, -- 문서 날짜
 RETURNCOMMENT VARCHAR2(1000), -- 반려 코멘트
 DELETE_YN VARCHAR2(3) DEFAULT 'N' CHECK(DELETE_YN IN('Y','N')) -- 삭제여부
 );
 
				
--정/부/결제라인저장 테이블
CREATE TABLE APPROLINE( --결제 정/부 결제 라인 저장 테이블
    EMP_CODE NUMBER CONSTRAINT APPROLINE_EMP_ERROR REFERENCES EMPLOYEE ON DELETE CASCADE,
    DEPT_CODE VARCHAR2(3),
    SUB_CODE NUMBER CONSTRAINT APPROLINE_SUB_ERROR REFERENCES EMPLOYEE ON DELETE CASCADE,
    LINE1 VARCHAR2(1000),
    LINE2 VARCHAR2(1000),
    LINE3 VARCHAR2(1000)
);
					 
--결제 시퀀스
 CREATE SEQUENCE SEQ_APPRO
 START WITH 1
 INCREMENT BY 1
 MAXVALUE 100000
 NOCYCLE
 NOCACHE;
					 
-- 근태관련
 CREATE TABLE LEAVE(
 LEAVE_CODE CHAR(2) PRIMARY KEY,
 LEAVE_NAME VARCHAR2(10) NOT NULL
 );
 
 CREATE TABLE WT_TYPE(
    TA_TYPE_CODE CHAR(2) PRIMARY KEY,
    TA_NAME VARCHAR(15) NOT NULL
);
 
 CREATE TABLE VACTABLE(
  DOC_NUMBER NUMBER NOT NULL UNIQUE,
   TCONTENT VARCHAR2(2000),
  LEAVE_CODE CHAR(2) NOT NULL, -- L1 : 연차 / L2 : 월차 / L3 : 반차
  START_DATE DATE NOT NULL,
  END_DATE DATE NOT NULL,
  DAYOFF_MA CHAR(1) DEFAULT 'N' CHECK(DAYOFF_MA IN ('A','P','N')),  --  N : NULL / A : 오전 / P : 오후
 
  
  FOREIGN KEY (DOC_NUMBER) REFERENCES APPROVAL ON DELETE CASCADE, 
  FOREIGN KEY (LEAVE_CODE) REFERENCES LEAVE ON DELETE CASCADE
);

 CREATE TABLE LEAVE_COUNT(
 EMP_CODE NUMBER(3) NOT NULL,
 LEAVE_CODE CHAR(2) NOT NULL,
 LCOUNT NUMBER(3),
 
 FOREIGN KEY (EMP_CODE) REFERENCES EMPLOYEE ON DELETE CASCADE,
 FOREIGN KEY (LEAVE_CODE) REFERENCES LEAVE ON DELETE CASCADE
 );
 
CREATE TABLE WORKTIME(
    EMP_CODE NUMBER(3),
    WT_DATE DATE DEFAULT SYSDATE,
    TA_TYPE_CODE CHAR(2),
    WT_TIME NUMBER(10) NOT NULL,
    
    FOREIGN KEY (EMP_CODE) REFERENCES EMPLOYEE ON DELETE CASCADE,
    FOREIGN KEY (TA_TYPE_CODE) REFERENCES WT_TYPE ON DELETE CASCADE
);

CREATE TABLE WEEK_OVERTIME(
	EMP_CODE NUMBER(3) NOT NULL,            --SESSION
	TODAY_DATE DATE DEFAULT SYSDATE,
	TODAY_OVERTIME NUMBER(10),
	WEEK_OF_YEAR NUMBER(2) NOT NULL,
	THE_WEEK NUMBER(10) NOT NULL,

	FOREIGN KEY (EMP_CODE) REFERENCES EMPLOYEE ON DELETE CASCADE
);
-- 수정예정
CREATE TABLE TA_DATA(
  EMP_CODE NUMBER(3) NOT NULL,
  LATE_COUNT NUMBER(2),
  WORKDAY_COUNT NUMBER(2),
  
  FOREIGN KEY (EMP_CODE) REFERENCES EMPLOYEE ON DELETE CASCADE
);
--  근태 끝


CREATE TABLE ROUNDTABLE(
  DOC_NUMBER NUMBER NOT NULL UNIQUE,
  TCONTENT VARCHAR2(2000)
  
 
);

CREATE TABLE PAYTABLE(
  DOC_NUMBER NUMBER NOT NULL UNIQUE,
  TCONTENT VARCHAR2(2000),
  PAID NUMBER NOT NULL

);



CREATE TABLE STAMP(
 EMP_CODE VARCHAR2(3),
 STAMP_FILE VARCHAR2(100)
);
				      
--	근태 프로시저 / 스케줄러
--	GRANT CREATE ANY JOB TO semi; --> 관리자에서 권한 부여 필요
--	월차 반차 매달 초기화 
CREATE OR REPLACE PROCEDURE LCOUNT_RESET_L2L3
IS
BEGIN 
    UPDATE LEAVE_COUNT SET LCOUNT=1 WHERE LEAVE_CODE='L2' OR LEAVE_CODE='L3';
END;
/

BEGIN
    DBMS_SCHEDULER.CREATE_JOB
    (
    JOB_NAME => 'LCOUNT_RESET_L2L3_JOB',
    JOB_TYPE => 'STORED_PROCEDURE',
    JOB_ACTION => 'LCOUNT_RESET_L2L3',
    REPEAT_INTERVAL => 'FREQ = MONTHLY; BYMONTHDAY = 1;', 
    COMMENTS => 'LCOUNT RESET JOB'
    );
END;
/

BEGIN
    DBMS_SCHEDULER.ENABLE ('LCOUNT_RESET_L2L3_JOB');
END;
/

-- 연차 매년 초기화 (15개로 고정)
CREATE OR REPLACE PROCEDURE LCOUNT_RESET_L1
IS
BEGIN 
    UPDATE LEAVE_COUNT SET LCOUNT=15 WHERE LEAVE_CODE='L1';
END;
/

BEGIN
    DBMS_SCHEDULER.CREATE_JOB
    (
    JOB_NAME => 'LCOUNT_RESET_L1_JOB',
    JOB_TYPE => 'STORED_PROCEDURE',
    JOB_ACTION => 'LCOUNT_RESET_L1',
    REPEAT_INTERVAL => 'FREQ = YEARLY; BYDATE = 0101;',
    COMMENTS => 'LCOUNT RESET JOB'
    );
END;
/

BEGIN
    DBMS_SCHEDULER.ENABLE ('LCOUNT_RESET_L1_JOB');
END;
/


--	근태  프로시저 / 끝


------------------------------------------------------------------------
--  INSERT  ------------------------------------------------------------
--  DEPARTMENT
INSERT INTO DEPARTMENT VALUES ('D0', '임원');
INSERT INTO DEPARTMENT VALUES ('D1', '인사부서');
INSERT INTO DEPARTMENT VALUES ('D2', '영업부서');
INSERT INTO DEPARTMENT VALUES ('D3', '기획부서');
INSERT INTO DEPARTMENT VALUES ('D4', '연구부서');
INSERT INTO DEPARTMENT VALUES ('D5', '미발령');

--  JOB
INSERT INTO JOB VALUES ('J1', '사장');
INSERT INTO JOB VALUES ('J2', '부사장');
INSERT INTO JOB VALUES ('J3', '상무');
INSERT INTO JOB VALUES ('J4', '부장');
INSERT INTO JOB VALUES ('J5', '차장');
INSERT INTO JOB VALUES ('J6', '과장');
INSERT INTO JOB VALUES ('J7', '대리');
INSERT INTO JOB VALUES ('J8', '사원');
INSERT INTO JOB VALUES ('J9', '관리자');

--  LEAVE
INSERT INTO LEAVE VALUES ('L1', '연차');
INSERT INTO LEAVE VALUES ('L2', '월차');
INSERT INTO LEAVE VALUES ('L3', '반차');

--  WT_TYPE
INSERT INTO WT_TYPE VALUES ('T1', '출근');
INSERT INTO WT_TYPE VALUES ('T2', '퇴근');
INSERT INTO WT_TYPE VALUES ('T3', '야근');
INSERT INTO WT_TYPE VALUES ('T4', '특근출근');
INSERT INTO WT_TYPE VALUES ('T5', '특근퇴근');


--  부서 랑 직급이 없어서 INSERT 안됨
--  EMPLOYEE
--  관리자
INSERT INTO EMPLOYEE VALUES('admin',100,
        'x61Ey612Kl2gpFL56FT9weDnpSo4AV8j8+qx2AuTHdRyY036xxzTTrw10Wq3+4qQyB+XURPWx1ONxp3Y3pB37A==','관리자',
        'admin','000000-0000000','admin@coo.com','M',1,null,'00-000-0000','000-0000-0000','COO'
        ,'D5','J9','Y','20/02/01',null,null);
--  사장        
INSERT INTO EMPLOYEE VALUES('Hong_gildong',200,
        '1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==',
        '홍길동','Honggildong','620205-1004567',
        'Hong_gildong@coo.com','M',58,null,'02-812-4685','010-8712-4685','서울시 강남구'
        ,'D0','J9','N','20/02/01',NULL,NULL);
--  부사장        
INSERT INTO EMPLOYEE VALUES('Hong_gilsoon',201,
        '1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==',
        '홍길순','Honggilsoon','690903-2001675',
        'Hong_gilsoon@coo.com','F',51,65000000,'02-812-1951','010-5822-1951','서울시 동작구'
        ,'D0','J2','N','20/02/01',NULL,NULL);
--  상무 1        
INSERT INTO EMPLOYEE VALUES('Kim_juhee',202,
        '1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==',
        '김주희','Kimjuhee','730803-2006722',
        'Kim_juhee@coo.com','F',47,55000000,'02-864-3752','010-2854-3752','서울시 용산구'
        ,'D0','J3','N','20/02/01',NULL,NULL);
--  상무 2        
INSERT INTO EMPLOYEE VALUES('Park_deadong',203,
        '1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==',
        '박대동','Parkdeadong','750319-1008673',
        'Park_deadong@coo.com','M',45,55000000,'02-385-3852','010-3852-4475','서울시 구로구'
        ,'D0','J3','N','20/02/01',NULL,NULL);
--  인사과 부장        
INSERT INTO EMPLOYEE VALUES('Kim_suksu',204,
        '1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==',
        '김석수','Kimsuksu','760827-1002758',
        'Kim_suksu@coo.com','M',44,50000000,'02-691-6935','010-3478-6935','서울시 강남구'
        ,'D1','J4','N','20/02/01',NULL,NULL);
--  인사과 차장 1
INSERT INTO EMPLOYEE VALUES('Kang_dongha',205,
        '1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==',
        '강동하','Kangdongha','791122-1004648',
        'Kang_dongha@coo.com','M',41,47000000,'02-1670-8534','010-2854-8534','서울시 동작구'
        ,'D1','J5','N','20/02/01',NULL,NULL);
--  인사과 차장 2
INSERT INTO EMPLOYEE VALUES('Kim_juli',206,
        '1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==',
        '김주리','Kimjuli','801202-2002724',
        'Kim_juli@coo.com','F',40,47000000,'02-0820-3341','010-0946-3341','서울시 용산구'
        ,'D1','J5','N','20/02/01',NULL,NULL);
--  인사과 과장 1
INSERT INTO EMPLOYEE VALUES('Na_jinsu',207,
        '1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==',
        '나진수','Najinsu','820630-1000630',
        'Na_jinsu@coo.com','M',38,44000000,'02-2726-8822','010-2726-2264','서울시 구로구'
        ,'D1','J6','N','20/02/01',NULL,NULL);
--  인사과 과장 2
INSERT INTO EMPLOYEE VALUES('Lee_jeamin',208,
        '1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==',
        '이제민','Leejeamin','820420-1006493',
        'Lee_jeamin@coo.com','M',38,44000000,'02-2726-8822','010-2726-2264','서울시 구로구'
        ,'D1','J6','N','20/02/01',NULL,NULL);
--  인사과 대리 1
INSERT INTO EMPLOYEE VALUES('Lym_jungsu',209,
        '1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==',
        '임정수','Lymjungsu','850627-1005572',
        'Lym_jungsu@coo.com','M',35,42000000,'02-8123-7234','010-0547-7234','서울시 강남구'
        ,'D1','J7','N','20/02/01',NULL,NULL);
--  인사과 대리 2
INSERT INTO EMPLOYEE VALUES('Kim_gundo',240,
        '1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==',
        '김건도','Kimgundo','840927-1002271',
        'Kim_gundo@coo.com','M',36,42000000,'02-7164-2702','010-0846-2702','서울시 용산구'
        ,'D1','J7','N','20/02/01',NULL,NULL);
--  인사과 사원 1
INSERT INTO EMPLOYEE VALUES('Park_hayoung',210,
        '1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==',
        '박하영','Parkhayoung','900927-2001675',
        'Park_hayoung@coo.com','F',30,34000000,'02-3751-6241','010-0841-6241','서울시 구로구'
        ,'D1','J8','N','20/02/01',NULL,NULL);
--  인사과 사원 2
INSERT INTO EMPLOYEE VALUES('Go_gilsu',211,
        '1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==',
        '고길수','Gogilsu','930907-1001162',
        'Go_gilsu@coo.com','M',27,30000000,'02-6823-0014','010-2743-0014','서울시 동작구'
        ,'D1','J8','N','20/02/01',NULL,NULL);
--  영업부 부장 
INSERT INTO EMPLOYEE VALUES('Kang_sujin',212,
        '1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==',
        '강수진','Kangsujin','760907-2002268',
        'Kang_sujin@coo.com','F',44,60000000,'02-1134-9682','010-0047-9682','서울시 강남구'
        ,'D2','J4','N','20/02/01',NULL,NULL);
--  영업부 차장
INSERT INTO EMPLOYEE VALUES('Cha_goil',213,
        '1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==',
        '차고일','Chagoil','790117-1003374',
        'Cha_goil@coo.com','M',41,52000000,'02-1199-9964','010-0842-9964','서울시 동작구'
        ,'D2','J5','N','20/02/01',NULL,NULL);
--  영업부 차장 2
INSERT INTO EMPLOYEE VALUES('Ju_jungmin',214,
        '1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==',
        '주정민','Jujungmin','800827-1007648',
        'Ju_jungmin@coo.com','M',40,50000000,'02-6671-0304','010-4862-0304','서울시 용산구'
        ,'D2','J5','N','20/02/01',NULL,NULL);
--  영업부 과장 1
INSERT INTO EMPLOYEE VALUES('Jung_hugook',215,
        '1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==',
        '정후국','Junghugook','820827-1001612',
        'Jung_hugook@coo.com','M',38,46000000,'02-246-0725','010-1613-0725','서울시 구로구'
        ,'D2','J6','N','20/02/01',NULL,NULL);
--  영업부 과장 2
INSERT INTO EMPLOYEE VALUES('Jung_juga',216,
        '1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==',
        '정주하','Jungjuga','850827-1006425',
        'Jung_juga@coo.com','F',35,43000000,'02-9611-0033','010-5642-0033','서울시 용산구'
        ,'D2','J6','N','20/02/01',NULL,NULL);
--  영업부 대리 1
INSERT INTO EMPLOYEE VALUES('Jang_jinho',217,
        '1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==',
        '장진호','Jangjinho','870822-1062721',
        'Jang_jinho@coo.com','M',32,37000000,'02-6623-8761','010-0024-8761','서울시 강남구'
        ,'D2','J7','N','20/02/01',NULL,NULL);
--  영업부 대리 2
INSERT INTO EMPLOYEE VALUES('Kim_mudo',218,
        '1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==',
        '김무도','Kimmudo','880430-1062291',
        'Kim_mudo@coo.com','M',31,35000000,'02-672-9901','010-6721-9901','서울시 서초구'
        ,'D2','J7','N','20/02/01',NULL,NULL);
--  영업부 사원 1
INSERT INTO EMPLOYEE VALUES('Park_dongju',219,
        '1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==',
        '박동주','Parkdongju','910121-2063312',
        'Park_dongju@coo.com','F',28,30000000,'02-772-1219','010-2671-1219','서울시 강남구'
        ,'D2','J8','N','20/02/01',NULL,NULL);
--  영업부 사원 2
INSERT INTO EMPLOYEE VALUES('Bae_jione',220,
        '1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==',
        '배지원','Baejione','940608-1063372',
        'Bae_jione@coo.com','M',25,27000000,'02-976-0614','010-1237-0614','서울시 서초구'
        ,'D2','J8','N','20/02/01',NULL,NULL);
--  기획부 부장
INSERT INTO EMPLOYEE VALUES('Park_jojung',221,
        '1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==',
        '박조정','Parkjojung','760321-2001182',
        'Park_jojung@coo.com','F',44,55000000,'02-0605-3245','010-8564-3245','서울시 강남구'
        ,'D3','J4','N','20/02/01',NULL,NULL);
--  기획부 차장 1
INSERT INTO EMPLOYEE VALUES('Sung_jungsu',222,
        '1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==',
        '성정수','Sungjungsu','800911-1006925',
        'Sung_jungsu@coo.com','M',40,50000000,'02-0605-3345','010-8564-3645','서울시 동작구'
        ,'D3','J5','N','20/02/01',NULL,NULL);
--  기획부 차장 2
INSERT INTO EMPLOYEE VALUES('Su_sujin',223,
        '1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==',
        '서수진','Susujin','821215-2001002',
        'Su_sujin@coo.com','F',38,48000000,'02-0622-3345','010-8224-3645','서울시 서초구'
        ,'D3','J5','N','20/02/01',NULL,NULL);
--  기획부 과장 1
INSERT INTO EMPLOYEE VALUES('Juk_minsu',224,
        '1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==',
        '적민수','Jukminsu','840628-1009642',
        'Juk_minsu@coo.com','M',36,45000000,'02-8812-9671','010-0347-3645','서울시 구로구'
        ,'D3','J6','N','20/02/01',NULL,NULL);
--  기획부 과장 2
INSERT INTO EMPLOYEE VALUES('Jang_woojin',225,
        '1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==',
        '장우진','Jangwoojin','860312-1006672',
        'Jang_woojin@coo.com','M',34,42000000,'02-712-9671','010-0347-8800','서울시 동작구'
        ,'D3','J6','N','20/02/01',NULL,NULL);
--  기획부 대리 1
INSERT INTO EMPLOYEE VALUES('Kim_gosu',226,
        '1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==',
        '김고수','Kimgosu','870808-1003372',
        'Kim_gosu@coo.com','M',33,38000000,'02-627-1825','010-3396-3370','서울시 강남구'
        ,'D3','J7','N','20/02/01',NULL,NULL);
--  기획부 대리 2
INSERT INTO EMPLOYEE VALUES('Kim_mujung',227,
        '1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==',
        '김무정','Kimmujung','870828-2006372',
        'Kim_mujung@coo.com','F',33,38000000,'02-633-1995','010-4856-1995','서울시 서초구'
        ,'D3','J7','N','20/02/01',NULL,NULL);
--  기획부 대리 3
INSERT INTO EMPLOYEE VALUES('Park_hadong',228,
        '1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==',
        '박하동','Parkhadong','890527-1003396',
        'Park_hadong@coo.com','M',31,34000000,'02-633-9630','010-4856-9630','서울시 동작구'
        ,'D3','J7','N','20/02/01',NULL,NULL);
--  기획부 사원 1
INSERT INTO EMPLOYEE VALUES('Kim_suman',229,
        '1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==',
        '김수만','Kimsuman','910227-1006915',
        'Kim_suman@coo.com','M',29,30000000,'02-8575-9630','010-2584-9630','서울시 구로구'
        ,'D3','J8','N','20/02/01',NULL,NULL);
--  기획부 사원 2
INSERT INTO EMPLOYEE VALUES('Gil_radong',230,
        '1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==',
        '길라동','Gilradong','930725-1003372',
        'Gil_radong@coo.com','M',27,27000000,'02-3327-9220','010-3548-9220','서울시 구로구'
        ,'D3','J8','N','20/02/01',NULL,NULL);
--  연구부서 부장
INSERT INTO EMPLOYEE VALUES('Park_soda',231,
        '1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==',
        '박소다','Parksoda','750725-2002172',
        'Park_soda@coo.com','F',45,60000000,'02-117-2020','010-3396-2020','서울시 서초구'
        ,'D4','J4','N','20/02/01',NULL,NULL);
--  연구부서 차장 1
INSERT INTO EMPLOYEE VALUES('Kim_dongwoo',232,
        '1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==',
        '김동우','Kimdongwoo','790227-1006661',
        'Kim_dongwoo@coo.com','M',41,54000000,'02-336-9613','010-1237-9613','서울시 강남구'
        ,'D4','J5','N','20/02/01',NULL,NULL);
--  연구부서 차장 2
INSERT INTO EMPLOYEE VALUES('Park_gudong',233,
        '1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==',
        '박구동','Parkgudong','800313-1005722',
        'Park_gudong@coo.com','M',40,52000000,'02-007-3824','010-0022-3824','서울시 동작구'
        ,'D4','J5','N','20/02/01',NULL,NULL);
--  연구부서 과장 1
INSERT INTO EMPLOYEE VALUES('Mung_mahoon',234,
        '1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==',
        '명마훈','Mungmahoon','830113-1006672',
        'Mung_mahoon@coo.com','M',37,48000000,'02-672-9991','010-6725-9991','서울시 동작구'
        ,'D4','J6','N','20/02/01',NULL,NULL);
--  연구부서 과장 2
INSERT INTO EMPLOYEE VALUES('Ma_dongsu',235,
        '1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==',
        '마동수','Madongsu','841120-1001514',
        'Ma_dongsu@coo.com','M',36,46000000,'02-227-3465','010-8852-9124','서울시 강남구'
        ,'D4','J6','N','20/02/01',NULL,NULL);
--  연구부서 대리 1
INSERT INTO EMPLOYEE VALUES('Su_jungmi',236,
        '1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==',
        '수정미','Sujungmi','861110-2002457',
        'Su_jungmi@coo.com','F',34,42000000,'02-227-3115','010-1152-9129','서울시 서초구'
        ,'D4','J7','N','20/02/01',NULL,NULL);
--  연구부서 대리 2
INSERT INTO EMPLOYEE VALUES('Kim_mijung',237,
        '1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==',
        '김미정','Kimmijung','880808-2009765',
        'Kim_mijung@coo.com','F',32,39000000,'02-227-1115','010-1962-3529','서울시 구로구'
        ,'D4','J7','N','20/02/01',NULL,NULL);
--  연구부서 사원 1
INSERT INTO EMPLOYEE VALUES('Kang_gomung',238,
        '1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==',
        '강고명','Kanggomung','910718-1002287',
        'Kang_gomung@coo.com','M',29,31000000,'02-211-1645','010-1262-4629','서울시 강남구'
        ,'D4','J8','N','20/02/01',NULL,NULL);
--  연구부서 사원 2
INSERT INTO EMPLOYEE VALUES('Kim_sangu',239,
        '1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==',
        '김산구','Kimsangu','950128-1003324',
        'Kim_sangu@coo.com','M',25,28000000,'02-2114-1615','010-1992-4999','서울시 서초구'
        ,'D4','J8','N','20/02/01',NULL,NULL);
        
--- 부서별 검색을 위한 코드
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 1, '전체 공지', '연습용 전체 공지 입니다.', 'Hong_gildong', DEFAULT, sysdate, DEFAULT, 1, 'D0');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 2, '일반 공지', '연습용  일반 공지 입니다.', 'Hong_gilsoon', DEFAULT, sysdate, DEFAULT, 2, 'D0');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 3, '업무 공지', '연습용  업무 공지 입니다.', 'Kim_juhee', DEFAULT, sysdate, DEFAULT, 3, 'D0');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 4, '부서 공지', '연습용  부서 공지 입니다.', 'Park_deadong', DEFAULT, sysdate, DEFAULT, 4, 'D0');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 1, '전체 게시판', '연습용 게시판 입니다.', 'Hong_gildong', DEFAULT, sysdate, DEFAULT, 2, 'D0');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 2, '일반 게시판', '연습용 게시판 입니다.', 'Hong_gilsoon', DEFAULT, sysdate, DEFAULT, 2, 'D0');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 3, '업무 게시판', '연습용 게시판 입니다.', 'Kim_juhee', DEFAULT, sysdate, DEFAULT, 3, 'D0');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 4, '부서 게시판', '연습용 게시판 입니다.', 'Park_deadong', DEFAULT, sysdate, DEFAULT, 4, 'D0');
        
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 1, '전체 공지', '연습용 전체 공지 입니다.', 'admin', DEFAULT, sysdate, DEFAULT, 1, 'D5');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 1, '전체 게시판', '연습용 전체 게시판 입니다.', 'admin', DEFAULT, sysdate, DEFAULT, 1, 'D5');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 2, '일반 게시판', '연습용 일반 게시판 입니다.', 'admin', DEFAULT, sysdate, DEFAULT, 2, 'D5');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 2, '일반 공지', '연습용 일반 공지 입니다.', 'admin', DEFAULT, sysdate, DEFAULT, 2, 'D5');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 3, '업무 게시판', '연습용 업무 게시판 입니다.', 'admin', DEFAULT, sysdate, DEFAULT, 3, 'D5');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 3, '업무 공지', '연습용 업무 공지 입니다.', 'admin', DEFAULT, sysdate, DEFAULT, 3, 'D5');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 4, '부서 게시판', '연습용 부서 게시판 입니다.', 'admin', DEFAULT, sysdate, DEFAULT, 4, 'D5');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 4, '부서 공지', '연습용 부서 공지 입니다.', 'admin', DEFAULT, sysdate, DEFAULT, 1, 'D5');

INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 1, '전체 공지', '연습용 전체 공지 입니다.', 'Kim_suksu', DEFAULT, sysdate, DEFAULT, 1, 'D1');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 2, '일반 공지', '연습용  일반 공지 입니다.', 'Kang_dongha', DEFAULT, sysdate, DEFAULT, 2, 'D1');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 3, '업무 공지', '연습용  업무 공지 입니다.', 'Na_jinsu', DEFAULT, sysdate, DEFAULT, 3, 'D1');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 4, '부서 공지', '연습용  부서 공지 입니다.', 'Kim_juli', DEFAULT, sysdate, DEFAULT, 4, 'D1');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 1, '전체 게시판', '연습용 게시판 입니다.', 'Lee_jeamin', DEFAULT, sysdate, DEFAULT, 1, 'D1');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 2, '일반 게시판', '연습용 게시판 입니다.', 'Lym_jungsu', DEFAULT, sysdate, DEFAULT, 2, 'D1');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 3, '업무 게시판', '연습용 게시판 입니다.', 'Kim_gundo', DEFAULT, sysdate, DEFAULT, 3, 'D1');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 4, '부서 게시판', '연습용 게시판 입니다.', 'Park_hayoung', DEFAULT, sysdate, DEFAULT, 4, 'D1');

INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 1, '전체 공지', '연습용 전체 공지 입니다.', 'Bae_jione', DEFAULT, sysdate, DEFAULT, 1, 'D2');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 2, '일반 공지', '연습용  일반 공지 입니다.', 'Park_dongju', DEFAULT, sysdate, DEFAULT, 2, 'D2');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 3, '업무 공지', '연습용  업무 공지 입니다.', 'Kim_mudo', DEFAULT, sysdate, DEFAULT, 3, 'D2');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 4, '부서 공지', '연습용  부서 공지 입니다.', 'Park_dongju', DEFAULT, sysdate, DEFAULT, 4, 'D2');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 1, '전체 게시판', '연습용 전체 게시판 입니다.', 'Jang_jinho', DEFAULT, sysdate, DEFAULT, 1, 'D2');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 2, '일반 게시판', '연습용 일반 게시판 입니다.', 'Jung_juga', DEFAULT, sysdate, DEFAULT, 2, 'D2');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 3, '업무 게시판', '연습용 업무 게시판 입니다.', 'Jung_hugook', DEFAULT, sysdate, DEFAULT, 3, 'D2');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 4, '부서 게시판', '연습용 부서 게시판 입니다.', 'Ju_jungmin', DEFAULT, sysdate, DEFAULT, 4, 'D2');

INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 1, '전체 공지', '연습용 전체 공지 입니다.', 'Park_jojung', DEFAULT, sysdate, DEFAULT, 1, 'D3');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 2, '일반 공지', '연습용  일반 공지 입니다.', 'Sung_jungsu', DEFAULT, sysdate, DEFAULT, 2, 'D3');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 3, '업무 공지', '연습용  업무 공지 입니다.', 'Su_sujin', DEFAULT, sysdate, DEFAULT, 3, 'D3');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 4, '부서 공지', '연습용  부서 공지 입니다.', 'Juk_minsu', DEFAULT, sysdate, DEFAULT, 4, 'D3');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 1, '전체 게시판', '연습용 전체 게시판 입니다.', 'Jang_woojin', DEFAULT, sysdate, DEFAULT, 1, 'D3');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 2, '일반 게시판', '연습용 일반 게시판 입니다.', 'Kim_gosu', DEFAULT, sysdate, DEFAULT, 2, 'D3');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 3, '업무 게시판', '연습용 업무 게시판 입니다.', 'Kim_mujung', DEFAULT, sysdate, DEFAULT, 3, 'D3');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 4, '부서 게시판', '연습용 부서 게시판 입니다.', 'Park_hadong', DEFAULT, sysdate, DEFAULT, 4, 'D3');

INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 1, '전체 공지', '연습용 전체 공지 입니다.', 'Park_soda', DEFAULT, sysdate, DEFAULT, 1, 'D4');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 2, '일반 공지', '연습용  일반 공지 입니다.', 'Kim_dongwoo', DEFAULT, sysdate, DEFAULT, 2, 'D4');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 3, '업무 공지', '연습용  업무 공지 입니다.', 'Park_gudong', DEFAULT, sysdate, DEFAULT, 3, 'D4');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 4, '부서 공지', '연습용  부서 공지 입니다.', 'Mung_mahoon', DEFAULT, sysdate, DEFAULT, 4, 'D4');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 1, '전체 게시판', '연습용 전체 게시판 입니다.', 'Ma_dongsu', DEFAULT, sysdate, DEFAULT, 1, 'D4');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 2, '일반 게시판', '연습용 일반 게시판 입니다.', 'Su_jungmi', DEFAULT, sysdate, DEFAULT, 2, 'D4');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 3, '업무 게시판', '연습용 업무 게시판 입니다.', 'Kim_mijung', DEFAULT, sysdate, DEFAULT, 3, 'D4');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 4, '부서 게시판', '연습용 부서 게시판 입니다.', 'Kang_gomung', DEFAULT, sysdate, DEFAULT, 4, 'D4');

-- 추가 더미 데이터
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 1, '전체 공지', '더미 데이터 찾기 용 이것이 삶인가 그렇다면 다시 한번더 : 니체', 'admin', DEFAULT, TO_DATE('2020-02-11','YYYY-MM-DD'), DEFAULT, 1, 'D5');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 1, '전체 공지', '더미 데이터 찾기 용 오늘날 프로그래밍은 바보도 문제없이 쓸 수 있는 프로그램을 더 거대하고 더 낫게 구축하려 애쓰는  소프트웨어 기술자와 더 거대한 하고 더 나은 바보를 만들려는 우주의 경쟁이다. 지금까지는 우주가 이기고 있다.', 'admin', DEFAULT, TO_DATE('2020-02-12','YYYY-MM-DD'), DEFAULT, 1, 'D5');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 1, '전체 공지', '더미 데이터 찾기 용 물 위를 걷는 것과 명세서로 소프트웨어를 개발하는 것은 쉽다. 둘다  동결되었다면…… ', 'Hong_gildong', DEFAULT, TO_DATE('2020-02-11','YYYY-MM-DD'), DEFAULT, 1, 'D0 ');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 1, '전체 공지', '더미 데이터 찾기 용 코드 실행 "위 코드의 버그를 조심하라. 나는 코드가 올바르다는 것만 증명했을 뿐, 실행해보지는 않았다." -도널드크누스- ', 'Hong_gilsoon', DEFAULT, TO_DATE('2020-02-11','YYYY-MM-DD'), DEFAULT, 1, 'D0');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 2, '전체 공지', '컴퓨터 시스템 분석은 아이를 키우는 것과 같다. 극심한 상처를 줄 수는 있지만 성공을 보장해줄 수는 없다.', 'Park_soda', DEFAULT, TO_DATE('2020-02-11','YYYY-MM-DD'), DEFAULT, 1, 'D4 ');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 2, '전체 공지', '프로그램-프로그래밍 : PHP가 무능한 아마추어들이 구상하고 만든 소소한 악이라면, 펄은 유능하지만 변태적인 프로들이 구상하고 만든 거대하고 교활한 악이다.', 'Kim_suksu', DEFAULT, TO_DATE('2020-02-13','YYYY-MM-DD'), DEFAULT, 2, 'D1');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 2, '전체 공지', '프로그램-프로그래밍 : 나는 진정한 프로그래머가 아니다. 될 때까지 이것저것 마구 시도해보고 되면 다음으로 넘어간다. 진정한 프로그래머는 “네, 되긴 하지만 여기저기서 메모리 누수가 발생합니다. 아마 수정해야겠지요”라고 말한다. 나는 그냥 요청이 10번 들어올 때마다 아파치를 재시작한다. -라스무스 러도프(1968년 11월 22일 ).-', 'Kim_juli', DEFAULT, TO_DATE('2020-02-12','YYYY-MM-DD'), DEFAULT, 1, 'D1');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 2, '전체 공지', '프로그램-프로그래밍 : 쓰레기가 들어가면 무엇이 나오는가? “두 차례나, 그것도 국회의원들에게 이런 질문을 받았다. ‘배비지씨, 기계에 틀린 수치를 입력해도 올바른 답이 나옵니까?’ 나는 어떤 개념의 혼란에 빠져야 그러한 질문이 나오는지 도무지 이해할 수 없다.', 'Na_jinsu', DEFAULT, TO_DATE('2020-02-11','YYYY-MM-DD'), DEFAULT, 1, 'D1');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 1, '전체 공지', '프로그램-프로그래밍 : 자신이 컴퓨터를 싫어한다고 생각하는 사람들을 보면, 사실은 형편없는 프로그래머를 싫어하는 것이다.', 'Park_gudong', DEFAULT, sysdate, DEFAULT, 1, 'D4');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 1, '전체 공지', '프로그램-프로그래밍 : 올바로 동작하지 않더라도 걱정말아라. 모든 것이 그랬다면, 넌 직업을 잃었을테니까. -소프트웨어 공학에서의 모셔의 법칙(Mosher’s Law)-', 'Mung_mahoon', DEFAULT, sysdate, DEFAULT, 1, 'D4');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 2, '일반 공지', '프로그램-프로그래밍 : 그래, 자바가 프로그래밍 언어가 따라야 할 전형일 수는 있다. 하지만, 자바 애플리케이션은 애플리케이션이라면 반드시 피해야할 전형이다. -pixadel', 'Go_gilsu', DEFAULT, TO_DATE('2020-02-14','YYYY-MM-DD'), DEFAULT, 2, 'D1');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 3, '업무 공지', '프로그램-프로그래밍 : 유일한 진실을 말하자면, 객체 지향 판 ‘스파게티 코드’는, 당연히, 라쟈냐 코드’이다. (과하게 많은 계층) -로버트 월트만(Roberto Waltman)', 'Park_hayoung', DEFAULT, sysdate, DEFAULT, 3, 'D1');  
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 4, '부서 공지', '프로그램-프로그래밍 : 오랜 시간 나는 그토록 비싸고, 그토록 첨단인 무엇이 그토록 쓸모 없을 수 있는지 이해하지 못했다. 그러다가 컴퓨터는 놀랍도록 똑똑한 것을 할 수 있는 멍청한 기계이고, 컴퓨터 프로그래머는 놀랍도록 멍청한 짓을 할 수 있는 똑똑한 사람이라는 생각이 들었다.  즉, 둘은 완벽한 한 쌍이다.', 'Park_jojung', DEFAULT, sysdate, DEFAULT, 4, 'D3');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 1, '전체 게시판', '프로그램-프로그래밍 : 말은 쉽지, 코드를 보여줘. -리누스 토르발스(Linus Torvalds)', 'Sung_jungsu', DEFAULT, sysdate, DEFAULT, 1, 'D3');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 2, '일반 게시판', '프로그램-프로그래밍 : 완벽함은 아무것도 더할 것이 없을 때가 아닌, 아무것도 제거할 것이 남지 않았을 때 달성된다.', 'Su_sujin', DEFAULT, sysdate, DEFAULT, 2, 'D3');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 1, '전체 게시판', '프로그램-프로그래밍 : 이론상, 이론과 실제는 같다. 실제로는, 그렇지 않다.', 'Juk_minsu', DEFAULT, sysdate, DEFAULT, 1, 'D3');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 1, '전체 공지', '프로그램-프로그래밍 : 사람들은 컴퓨터 과학이 천재들의 기예이라고 생각하지만 사실 현실은 반대로, 단지 많은 사람이, 작은 돌로 된 담처럼, 다른 사람의 작업 위에 쌓아 올릴 뿐이다.', 'admin', DEFAULT, TO_DATE('02/02/11','yy/mm/dd'), DEFAULT, 1, 'D5');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 3, '업무 게시판', '아모르파티 , 니체', 'admin', DEFAULT, sysdate, DEFAULT, 3, 'D5');

-- BOARD_NOTICE
INSERT INTO BOARD_NOTICE VALUES(SEQ_NNO.NEXTVAL, 1, '연습_공지입니다-1.', '연습_공지입니다-1.', 'admin', '0', sysdate, 'Y');
INSERT INTO BOARD_NOTICE VALUES(SEQ_NNO.NEXTVAL, 2, '연습_공지입니다-2.', '연습_공지입니다-2.', 'admin', '0', sysdate, 'Y');
INSERT INTO BOARD_NOTICE VALUES(SEQ_NNO.NEXTVAL, 3, '연습_공지입니다-3.', '연습_공지입니다-3.', 'admin', '0', sysdate, 'Y');
INSERT INTO BOARD_NOTICE VALUES(SEQ_NNO.NEXTVAL, 4, '연습_공지입니다-4.', '연습_공지입니다-4.', 'admin', '0', sysdate, 'Y');
INSERT INTO BOARD_NOTICE VALUES(SEQ_NNO.NEXTVAL, 5, '연습_공지입니다-5.', '연습_공지입니다-5.', 'admin', '0', sysdate, 'Y');
INSERT INTO BOARD_NOTICE VALUES(SEQ_NNO.NEXTVAL, 6, '연습_공지입니다-6.', '연습_공지입니다-6.', 'admin', '0', sysdate, 'Y');
INSERT INTO BOARD_NOTICE VALUES(SEQ_NNO.NEXTVAL, 7, '연습_공지입니다-7.', '연습_공지입니다-7.', 'admin', '0', sysdate, 'Y');
INSERT INTO BOARD_NOTICE VALUES(SEQ_NNO.NEXTVAL, 8, '연습_공지입니다-8.', '연습_공지입니다-8.', 'admin', '0', sysdate, 'Y');
INSERT INTO BOARD_NOTICE VALUES(SEQ_NNO.NEXTVAL, 9, '연습_공지입니다-9.', '연습_공지입니다-9.', 'admin', '0', sysdate, 'Y');
INSERT INTO BOARD_NOTICE VALUES(SEQ_NNO.NEXTVAL, 10, '연습_공지입니다-10.', '연습_공지입니다-10.', 'admin', '0', sysdate, 'Y');
INSERT INTO BOARD_NOTICE VALUES(SEQ_NNO.NEXTVAL, 2, '연습_게시판입니다-1.', '연습_게시판입니다-1.', 'admin', '0', sysdate, 'Y');
INSERT INTO BOARD_NOTICE VALUES(SEQ_NNO.NEXTVAL, 2, '연습_게시판입니다-2.', '연습_게시판입니다-2.', 'admin', '0', sysdate, 'Y');
INSERT INTO BOARD_NOTICE VALUES(SEQ_NNO.NEXTVAL, 2, '연습_게시판입니다-3.', '연습_게시판입니다-3.', 'admin', '0', sysdate, 'Y');
INSERT INTO BOARD_NOTICE VALUES(SEQ_NNO.NEXTVAL, 2, '연습_게시판입니다-4.', '연습_게시판입니다-4.', 'admin', '0', sysdate, 'Y');
INSERT INTO BOARD_NOTICE VALUES(SEQ_NNO.NEXTVAL, 2, '연습_게시판입니다-5.', '연습_게시판입니다-5.', 'admin', '0', sysdate, 'Y');
INSERT INTO BOARD_NOTICE VALUES(SEQ_NNO.NEXTVAL, 2, '연습_게시판입니다-6.', '연습_게시판입니다-6.', 'admin', '0', sysdate, 'Y');
INSERT INTO BOARD_NOTICE VALUES(SEQ_NNO.NEXTVAL, 2, '연습_게시판입니다-7.', '연습_게시판입니다-7.', 'admin', '0', sysdate, 'Y');
INSERT INTO BOARD_NOTICE VALUES(SEQ_NNO.NEXTVAL, 2, '연습_게시판입니다-8.', '연습_게시판입니다-8.', 'admin', '0', sysdate, 'Y');
INSERT INTO BOARD_NOTICE VALUES(SEQ_NNO.NEXTVAL, 2, '연습_게시판입니다-9.', '연습_게시판입니다-9.', 'admin', '0', sysdate, 'Y');
INSERT INTO BOARD_NOTICE VALUES(SEQ_NNO.NEXTVAL, 2, '연습_게시판입니다-10.', '연습_게시판입니다-10.', 'admin', '0', sysdate, 'Y');

INSERT INTO BOARD_NOTICE VALUES(SEQ_NNO.NEXTVAL, 1, '연습_공지입니다-1.', '연습_공지입니다-1.', 'admin', '0', TO_DATE('2020-02-10','YYYY-MM-DD'), 'Y');
INSERT INTO BOARD_NOTICE VALUES(SEQ_NNO.NEXTVAL, 2, '연습_공지입니다-2.', '연습_공지입니다-2.', 'admin', '0', TO_DATE('2020-02-11','YYYY-MM-DD'), 'Y');
INSERT INTO BOARD_NOTICE VALUES(SEQ_NNO.NEXTVAL, 3, '연습_공지입니다-3.', '연습_공지입니다-3.', 'admin', '0', TO_DATE('2020-02-12','YYYY-MM-DD'), 'Y');
INSERT INTO BOARD_NOTICE VALUES(SEQ_NNO.NEXTVAL, 4, '연습_공지입니다-4.', '연습_공지입니다-4.', 'admin', '0', TO_DATE('2020-02-13','YYYY-MM-DD'), 'Y');
INSERT INTO BOARD_NOTICE VALUES(SEQ_NNO.NEXTVAL, 5, '연습_공지입니다-5.', '연습_공지입니다-5.', 'admin', '0', TO_DATE('2020-02-14','YYYY-MM-DD'), 'Y');
INSERT INTO BOARD_NOTICE VALUES(SEQ_NNO.NEXTVAL, 6, '연습_공지입니다-6.', '연습_공지입니다-6.', 'admin', '0', TO_DATE('2020-02-15','YYYY-MM-DD'), 'Y');
INSERT INTO BOARD_NOTICE VALUES(SEQ_NNO.NEXTVAL, 7, '연습_공지입니다-7.', '연습_공지입니다-7.', 'admin', '0', TO_DATE('2020-02-16','YYYY-MM-DD'), 'Y');
INSERT INTO BOARD_NOTICE VALUES(SEQ_NNO.NEXTVAL, 8, '연습_공지입니다-8.', '연습_공지입니다-8.', 'admin', '0', TO_DATE('2020-02-17','YYYY-MM-DD'), 'Y');
INSERT INTO BOARD_NOTICE VALUES(SEQ_NNO.NEXTVAL, 9, '연습_공지입니다-9.', '연습_공지입니다-9.', 'admin', '0', TO_DATE('2020-02-18','YYYY-MM-DD'), 'Y');
INSERT INTO BOARD_NOTICE VALUES(SEQ_NNO.NEXTVAL, 10, '연습_공지입니다-10.', '연습_공지입니다-10.', 'admin', '0', TO_DATE('2020-02-09','YYYY-MM-DD'), 'Y');
INSERT INTO BOARD_NOTICE VALUES(SEQ_NNO.NEXTVAL, 2, '연습_게시판입니다-1.', '연습_게시판입니다-1.', 'admin', '0', TO_DATE('2020-02-09','YYYY-MM-DD'), 'Y');
INSERT INTO BOARD_NOTICE VALUES(SEQ_NNO.NEXTVAL, 2, '연습_게시판입니다-2.', '연습_게시판입니다-2.', 'admin', '0', TO_DATE('2020-02-10','YYYY-MM-DD'), 'Y');
INSERT INTO BOARD_NOTICE VALUES(SEQ_NNO.NEXTVAL, 2, '연습_게시판입니다-3.', '연습_게시판입니다-3.', 'admin', '0', TO_DATE('2020-02-11','YYYY-MM-DD'), 'Y');
INSERT INTO BOARD_NOTICE VALUES(SEQ_NNO.NEXTVAL, 2, '연습_게시판입니다-4.', '연습_게시판입니다-4.', 'admin', '0', TO_DATE('2020-02-12','YYYY-MM-DD'), 'Y');
INSERT INTO BOARD_NOTICE VALUES(SEQ_NNO.NEXTVAL, 2, '연습_게시판입니다-5.', '연습_게시판입니다-5.', 'admin', '0', TO_DATE('2020-02-13','YYYY-MM-DD'), 'Y');
INSERT INTO BOARD_NOTICE VALUES(SEQ_NNO.NEXTVAL, 2, '연습_게시판입니다-6.', '연습_게시판입니다-6.', 'admin', '0', TO_DATE('2020-02-14','YYYY-MM-DD'), 'Y');
INSERT INTO BOARD_NOTICE VALUES(SEQ_NNO.NEXTVAL, 2, '연습_게시판입니다-7.', '연습_게시판입니다-7.', 'admin', '0', TO_DATE('2020-02-15','YYYY-MM-DD'), 'Y');
INSERT INTO BOARD_NOTICE VALUES(SEQ_NNO.NEXTVAL, 2, '연습_게시판입니다-8.', '연습_게시판입니다-8.', 'admin', '0', TO_DATE('2020-02-16','YYYY-MM-DD'), 'Y');
INSERT INTO BOARD_NOTICE VALUES(SEQ_NNO.NEXTVAL, 2, '연습_게시판입니다-9.', '연습_게시판입니다-9.', 'admin', '0', TO_DATE('2020-02-17','YYYY-MM-DD'), 'Y');
INSERT INTO BOARD_NOTICE VALUES(SEQ_NNO.NEXTVAL, 2, '연습_게시판입니다-10.', '연습_게시판입니다-10.', 'admin', '0', TO_DATE('2020-02-18','YYYY-MM-DD'), 'Y');
-- 검색을 위한 더미 데이터 
INSERT INTO BOARD_NOTICE VALUES(SEQ_NNO.NEXTVAL, 2, '사장님 말씀', '프로그래밍-프로그램 : 먼저 컴퓨터 과학과 모든 이론을 배워라. 다음엔 프로그래밍 방식을 개발하라. 그러고 나선 모두 잊고 그냥 파헤쳐라.', 'admin', '0', TO_DATE('2020-02-09','YYYY-MM-DD'), 'Y');
INSERT INTO BOARD_NOTICE VALUES(SEQ_NNO.NEXTVAL, 2, '사장님 말씀', '프로그래밍-프로그램 : 아니쓴 코드에 오류날까?', 'admin', '0', TO_DATE('2020-02-09','YYYY-MM-DD'), 'Y');
INSERT INTO BOARD_NOTICE VALUES(SEQ_NNO.NEXTVAL, 2, '사장님 말씀', '프로그래밍-프로그램 : 오늘날 소프트웨어 대부분은 이집트 피라미드와 매우 비슷한데, 수많은 블럭을 차곡차곡 쌓은 이것은, 구조적 무결성은 없고, 그저 마구잡이로 노예 수천을 동원해 완성됐다.', 'admin', '0', sysdate, 'Y');
INSERT INTO BOARD_NOTICE VALUES(SEQ_NNO.NEXTVAL, 2, '오늘의 말', '프로그래밍-프로그램 : 결국 당신 코드를 유지보수하게 될 친구가 당신이 어디에 사는지 아는 광폭한 싸이코패스가 될 것이라고 여기고 코드를 작성하라.', 'admin', '0', TO_DATE('2020-02-11','YYYY-MM-DD'), 'Y');
INSERT INTO BOARD_NOTICE VALUES(SEQ_NNO.NEXTVAL, 2, '오늘의 말', '프로그래밍-프로그램 : 당신 대부분은 프로그래머의 미덕과 친숙하다. 미덕은 세 가지인데, 당연히, 게으름, 성급함, 오만이다.', 'admin', '0', TO_DATE('2020-02-13','YYYY-MM-DD'), 'Y');
INSERT INTO BOARD_NOTICE VALUES(SEQ_NNO.NEXTVAL, 2, '오늘의 말', '프로그래밍-프로그램 : 다른 사람을 믿으라. 그 사람이 해결해줄지도 모른다. 주의사항 - 먼저 자신을 의심해라.', 'admin', '0', sysdate, 'Y');


--  TA_DATA INSERT
INSERT INTO TA_DATA VALUES(200, 0, 15);
INSERT INTO TA_DATA VALUES(201, 0, 15);
INSERT INTO TA_DATA VALUES(202, 0, 15);
INSERT INTO TA_DATA VALUES(203, 0, 15);
INSERT INTO TA_DATA VALUES(204, 0, 15);
INSERT INTO TA_DATA VALUES(205, 2, 15);
INSERT INTO TA_DATA VALUES(206, 1, 15);
INSERT INTO TA_DATA VALUES(207, 0, 15);
INSERT INTO TA_DATA VALUES(208, 0, 15);
INSERT INTO TA_DATA VALUES(209, 1, 15);
INSERT INTO TA_DATA VALUES(210, 3, 15);
INSERT INTO TA_DATA VALUES(211, 0, 15);
INSERT INTO TA_DATA VALUES(212, 5, 15);
INSERT INTO TA_DATA VALUES(213, 0, 15);
INSERT INTO TA_DATA VALUES(214, 2, 15);
INSERT INTO TA_DATA VALUES(215, 0, 15);
INSERT INTO TA_DATA VALUES(216, 0, 15);
INSERT INTO TA_DATA VALUES(217, 1, 15);
INSERT INTO TA_DATA VALUES(218, 0, 15);
INSERT INTO TA_DATA VALUES(219, 1, 15);
INSERT INTO TA_DATA VALUES(220, 0, 15);
INSERT INTO TA_DATA VALUES(231, 0, 15);
INSERT INTO TA_DATA VALUES(232, 0, 15);
INSERT INTO TA_DATA VALUES(233, 0, 15);
INSERT INTO TA_DATA VALUES(234, 1, 15);
INSERT INTO TA_DATA VALUES(235, 0, 15);
INSERT INTO TA_DATA VALUES(236, 0, 15);
INSERT INTO TA_DATA VALUES(237, 1, 15);
INSERT INTO TA_DATA VALUES(238, 0, 15);
INSERT INTO TA_DATA VALUES(239, 0, 15);
INSERT INTO TA_DATA VALUES(240, 2, 15);




--  LEAVE_COUNT INSERT
INSERT INTO LEAVE_COUNT VALUES (200, 'L1', 20);
INSERT INTO LEAVE_COUNT VALUES (200, 'L2', 1);
INSERT INTO LEAVE_COUNT VALUES (200, 'L3', 1);
INSERT INTO LEAVE_COUNT VALUES (201, 'L1', 18);
INSERT INTO LEAVE_COUNT VALUES (201, 'L2', 1);
INSERT INTO LEAVE_COUNT VALUES (201, 'L3', 1);
INSERT INTO LEAVE_COUNT VALUES (202, 'L1', 18);
INSERT INTO LEAVE_COUNT VALUES (202, 'L2', 1);
INSERT INTO LEAVE_COUNT VALUES (202, 'L3', 1);
INSERT INTO LEAVE_COUNT VALUES (203, 'L1', 15);
INSERT INTO LEAVE_COUNT VALUES (203, 'L2', 1);
INSERT INTO LEAVE_COUNT VALUES (203, 'L3', 1);
INSERT INTO LEAVE_COUNT VALUES (204, 'L1', 15);
INSERT INTO LEAVE_COUNT VALUES (204, 'L2', 1);
INSERT INTO LEAVE_COUNT VALUES (204, 'L3', 1);
INSERT INTO LEAVE_COUNT VALUES (205, 'L1', 15);
INSERT INTO LEAVE_COUNT VALUES (205, 'L2', 1);
INSERT INTO LEAVE_COUNT VALUES (205, 'L3', 1);
INSERT INTO LEAVE_COUNT VALUES (206, 'L1', 15);
INSERT INTO LEAVE_COUNT VALUES (206, 'L2', 1);
INSERT INTO LEAVE_COUNT VALUES (206, 'L3', 1);
INSERT INTO LEAVE_COUNT VALUES (207, 'L1', 15);
INSERT INTO LEAVE_COUNT VALUES (207, 'L2', 1);
INSERT INTO LEAVE_COUNT VALUES (207, 'L3', 1);
INSERT INTO LEAVE_COUNT VALUES (208, 'L1', 15);
INSERT INTO LEAVE_COUNT VALUES (208, 'L2', 1);
INSERT INTO LEAVE_COUNT VALUES (208, 'L3', 1);
INSERT INTO LEAVE_COUNT VALUES (209, 'L1', 15);
INSERT INTO LEAVE_COUNT VALUES (209, 'L2', 1);
INSERT INTO LEAVE_COUNT VALUES (209, 'L3', 1);
INSERT INTO LEAVE_COUNT VALUES (210, 'L1', 15);
INSERT INTO LEAVE_COUNT VALUES (210, 'L2', 1);
INSERT INTO LEAVE_COUNT VALUES (210, 'L3', 1);
INSERT INTO LEAVE_COUNT VALUES (211, 'L1', 15);
INSERT INTO LEAVE_COUNT VALUES (211, 'L2', 1);
INSERT INTO LEAVE_COUNT VALUES (211, 'L3', 1);
INSERT INTO LEAVE_COUNT VALUES (212, 'L1', 15);
INSERT INTO LEAVE_COUNT VALUES (212, 'L2', 1);
INSERT INTO LEAVE_COUNT VALUES (212, 'L3', 1);
INSERT INTO LEAVE_COUNT VALUES (213, 'L1', 15);
INSERT INTO LEAVE_COUNT VALUES (213, 'L2', 1);
INSERT INTO LEAVE_COUNT VALUES (213, 'L3', 1);
INSERT INTO LEAVE_COUNT VALUES (214, 'L1', 15);
INSERT INTO LEAVE_COUNT VALUES (214, 'L2', 1);
INSERT INTO LEAVE_COUNT VALUES (214, 'L3', 1);
INSERT INTO LEAVE_COUNT VALUES (215, 'L1', 15);
INSERT INTO LEAVE_COUNT VALUES (215, 'L2', 1);
INSERT INTO LEAVE_COUNT VALUES (215, 'L3', 1);
INSERT INTO LEAVE_COUNT VALUES (216, 'L1', 15);
INSERT INTO LEAVE_COUNT VALUES (216, 'L2', 1);
INSERT INTO LEAVE_COUNT VALUES (216, 'L3', 1);
INSERT INTO LEAVE_COUNT VALUES (217, 'L1', 15);
INSERT INTO LEAVE_COUNT VALUES (217, 'L2', 1);
INSERT INTO LEAVE_COUNT VALUES (217, 'L3', 1);
INSERT INTO LEAVE_COUNT VALUES (218, 'L1', 15);
INSERT INTO LEAVE_COUNT VALUES (218, 'L2', 1);
INSERT INTO LEAVE_COUNT VALUES (218, 'L3', 1);
INSERT INTO LEAVE_COUNT VALUES (219, 'L1', 15);
INSERT INTO LEAVE_COUNT VALUES (219, 'L2', 1);
INSERT INTO LEAVE_COUNT VALUES (219, 'L3', 1);
INSERT INTO LEAVE_COUNT VALUES (220, 'L1', 15);
INSERT INTO LEAVE_COUNT VALUES (220, 'L2', 1);
INSERT INTO LEAVE_COUNT VALUES (220, 'L3', 1);
INSERT INTO LEAVE_COUNT VALUES (221, 'L1', 15);
INSERT INTO LEAVE_COUNT VALUES (221, 'L2', 1);
INSERT INTO LEAVE_COUNT VALUES (221, 'L3', 1);
INSERT INTO LEAVE_COUNT VALUES (222, 'L1', 15);
INSERT INTO LEAVE_COUNT VALUES (222, 'L2', 1);
INSERT INTO LEAVE_COUNT VALUES (222, 'L3', 1);
INSERT INTO LEAVE_COUNT VALUES (223, 'L1', 15);
INSERT INTO LEAVE_COUNT VALUES (223, 'L2', 1);
INSERT INTO LEAVE_COUNT VALUES (223, 'L3', 1);
INSERT INTO LEAVE_COUNT VALUES (224, 'L1', 15);
INSERT INTO LEAVE_COUNT VALUES (224, 'L2', 1);
INSERT INTO LEAVE_COUNT VALUES (224, 'L3', 1);
INSERT INTO LEAVE_COUNT VALUES (225, 'L1', 15);
INSERT INTO LEAVE_COUNT VALUES (225, 'L2', 1);
INSERT INTO LEAVE_COUNT VALUES (225, 'L3', 1);
INSERT INTO LEAVE_COUNT VALUES (226, 'L1', 15);
INSERT INTO LEAVE_COUNT VALUES (226, 'L2', 1);
INSERT INTO LEAVE_COUNT VALUES (226, 'L3', 1);
INSERT INTO LEAVE_COUNT VALUES (227, 'L1', 15);
INSERT INTO LEAVE_COUNT VALUES (227, 'L2', 1);
INSERT INTO LEAVE_COUNT VALUES (227, 'L3', 1);
INSERT INTO LEAVE_COUNT VALUES (228, 'L1', 15);
INSERT INTO LEAVE_COUNT VALUES (228, 'L2', 1);
INSERT INTO LEAVE_COUNT VALUES (228, 'L3', 1);
INSERT INTO LEAVE_COUNT VALUES (229, 'L1', 15);
INSERT INTO LEAVE_COUNT VALUES (229, 'L2', 1);
INSERT INTO LEAVE_COUNT VALUES (229, 'L3', 1);
INSERT INTO LEAVE_COUNT VALUES (230, 'L1', 15);
INSERT INTO LEAVE_COUNT VALUES (230, 'L2', 1);
INSERT INTO LEAVE_COUNT VALUES (230, 'L3', 1);
INSERT INTO LEAVE_COUNT VALUES (231, 'L1', 15);
INSERT INTO LEAVE_COUNT VALUES (231, 'L2', 1);
INSERT INTO LEAVE_COUNT VALUES (231, 'L3', 1);
INSERT INTO LEAVE_COUNT VALUES (232, 'L1', 15);
INSERT INTO LEAVE_COUNT VALUES (232, 'L2', 1);
INSERT INTO LEAVE_COUNT VALUES (232, 'L3', 1);
INSERT INTO LEAVE_COUNT VALUES (233, 'L1', 15);
INSERT INTO LEAVE_COUNT VALUES (233, 'L2', 1);
INSERT INTO LEAVE_COUNT VALUES (233, 'L3', 1);
INSERT INTO LEAVE_COUNT VALUES (234, 'L1', 15);
INSERT INTO LEAVE_COUNT VALUES (234, 'L2', 1);
INSERT INTO LEAVE_COUNT VALUES (234, 'L3', 1);
INSERT INTO LEAVE_COUNT VALUES (235, 'L1', 15);
INSERT INTO LEAVE_COUNT VALUES (235, 'L2', 1);
INSERT INTO LEAVE_COUNT VALUES (235, 'L3', 1);
INSERT INTO LEAVE_COUNT VALUES (236, 'L1', 15);
INSERT INTO LEAVE_COUNT VALUES (236, 'L2', 1);
INSERT INTO LEAVE_COUNT VALUES (236, 'L3', 1);
INSERT INTO LEAVE_COUNT VALUES (237, 'L1', 15);
INSERT INTO LEAVE_COUNT VALUES (237, 'L2', 1);
INSERT INTO LEAVE_COUNT VALUES (237, 'L3', 1);
INSERT INTO LEAVE_COUNT VALUES (238, 'L1', 15);
INSERT INTO LEAVE_COUNT VALUES (238, 'L2', 1);
INSERT INTO LEAVE_COUNT VALUES (238, 'L3', 1);
INSERT INTO LEAVE_COUNT VALUES (239, 'L1', 15);
INSERT INTO LEAVE_COUNT VALUES (239, 'L2', 1);
INSERT INTO LEAVE_COUNT VALUES (239, 'L3', 1);
INSERT INTO LEAVE_COUNT VALUES (240, 'L1', 15);
INSERT INTO LEAVE_COUNT VALUES (240, 'L2', 1);
INSERT INTO LEAVE_COUNT VALUES (240, 'L3', 1);



--  WORKTIME / WEEK_OVERTIME   INSERT PL SQL
DECLARE
    DATE_NUM NUMBER := 21;
    WEEK_NUM NUMBER := 6;
    WEEK_OVER NUMBER := 50;
    COUNT_OVER NUMBER := 1;
BEGIN
    LOOP
        IF DATE_NUM = 16 THEN
            DATE_NUM := DATE_NUM - 1;
        END IF;
        
        IF DATE_NUM = 15 THEN
            DATE_NUM := DATE_NUM - 1;
            WEEK_NUM := 7;
            WEEK_OVER := 50;
            COUNT_OVER := 1;
        END IF;
        
        IF DATE_NUM = 9 THEN
            DATE_NUM := DATE_NUM - 1;
        END IF;
        
        IF DATE_NUM = 8 THEN
            DATE_NUM := DATE_NUM - 1;
            WEEK_NUM := 8;
            WEEK_OVER := 50;
            COUNT_OVER := 1;
        END IF;

        INSERT INTO WORKTIME VALUES (200, SYSDATE-DATE_NUM, 'T1', 850);
        INSERT INTO WORKTIME VALUES (200, SYSDATE-DATE_NUM, 'T2', 1950);
        INSERT INTO WORKTIME VALUES (201, SYSDATE-DATE_NUM, 'T1', 850);
        INSERT INTO WORKTIME VALUES (201, SYSDATE-DATE_NUM, 'T2', 1950);
        INSERT INTO WORKTIME VALUES (202, SYSDATE-DATE_NUM, 'T1', 850);
        INSERT INTO WORKTIME VALUES (202, SYSDATE-DATE_NUM, 'T2', 1950);
        INSERT INTO WORKTIME VALUES (203, SYSDATE-DATE_NUM, 'T1', 850);
        INSERT INTO WORKTIME VALUES (203, SYSDATE-DATE_NUM, 'T2', 1950);
        INSERT INTO WORKTIME VALUES (204, SYSDATE-DATE_NUM, 'T1', 850);
        INSERT INTO WORKTIME VALUES (204, SYSDATE-DATE_NUM, 'T2', 1950);
        INSERT INTO WORKTIME VALUES (205, SYSDATE-DATE_NUM, 'T1', 850);
        INSERT INTO WORKTIME VALUES (205, SYSDATE-DATE_NUM, 'T2', 1950);
        INSERT INTO WORKTIME VALUES (206, SYSDATE-DATE_NUM, 'T1', 850);
        INSERT INTO WORKTIME VALUES (206, SYSDATE-DATE_NUM, 'T2', 1950);
        INSERT INTO WORKTIME VALUES (207, SYSDATE-DATE_NUM, 'T1', 850);
        INSERT INTO WORKTIME VALUES (207, SYSDATE-DATE_NUM, 'T2', 1950);
        INSERT INTO WORKTIME VALUES (208, SYSDATE-DATE_NUM, 'T1', 850);
        INSERT INTO WORKTIME VALUES (208, SYSDATE-DATE_NUM, 'T2', 1950);
        INSERT INTO WORKTIME VALUES (209, SYSDATE-DATE_NUM, 'T1', 850);
        INSERT INTO WORKTIME VALUES (209, SYSDATE-DATE_NUM, 'T2', 1950);
        INSERT INTO WORKTIME VALUES (210, SYSDATE-DATE_NUM, 'T1', 850);
        INSERT INTO WORKTIME VALUES (210, SYSDATE-DATE_NUM, 'T2', 1950);
        INSERT INTO WORKTIME VALUES (211, SYSDATE-DATE_NUM, 'T1', 850);
        INSERT INTO WORKTIME VALUES (211, SYSDATE-DATE_NUM, 'T2', 1950);
        INSERT INTO WORKTIME VALUES (212, SYSDATE-DATE_NUM, 'T1', 850);
        INSERT INTO WORKTIME VALUES (212, SYSDATE-DATE_NUM, 'T2', 1950);
        INSERT INTO WORKTIME VALUES (213, SYSDATE-DATE_NUM, 'T1', 850);
        INSERT INTO WORKTIME VALUES (213, SYSDATE-DATE_NUM, 'T2', 1950);
        INSERT INTO WORKTIME VALUES (214, SYSDATE-DATE_NUM, 'T1', 850);
        INSERT INTO WORKTIME VALUES (214, SYSDATE-DATE_NUM, 'T2', 1950);
        INSERT INTO WORKTIME VALUES (215, SYSDATE-DATE_NUM, 'T1', 850);
        INSERT INTO WORKTIME VALUES (215, SYSDATE-DATE_NUM, 'T2', 1950);
        INSERT INTO WORKTIME VALUES (216, SYSDATE-DATE_NUM, 'T1', 850);
        INSERT INTO WORKTIME VALUES (216, SYSDATE-DATE_NUM, 'T2', 1950);
        INSERT INTO WORKTIME VALUES (217, SYSDATE-DATE_NUM, 'T1', 850);
        INSERT INTO WORKTIME VALUES (217, SYSDATE-DATE_NUM, 'T2', 1950);
        INSERT INTO WORKTIME VALUES (218, SYSDATE-DATE_NUM, 'T1', 850);
        INSERT INTO WORKTIME VALUES (218, SYSDATE-DATE_NUM, 'T2', 1950);
        INSERT INTO WORKTIME VALUES (219, SYSDATE-DATE_NUM, 'T1', 850);
        INSERT INTO WORKTIME VALUES (219, SYSDATE-DATE_NUM, 'T2', 1950);
        INSERT INTO WORKTIME VALUES (220, SYSDATE-DATE_NUM, 'T1', 850);
        INSERT INTO WORKTIME VALUES (220, SYSDATE-DATE_NUM, 'T2', 1950);
        INSERT INTO WORKTIME VALUES (221, SYSDATE-DATE_NUM, 'T1', 850);
        INSERT INTO WORKTIME VALUES (221, SYSDATE-DATE_NUM, 'T2', 1950);
        INSERT INTO WORKTIME VALUES (222, SYSDATE-DATE_NUM, 'T1', 850);
        INSERT INTO WORKTIME VALUES (222, SYSDATE-DATE_NUM, 'T2', 1950);
        INSERT INTO WORKTIME VALUES (223, SYSDATE-DATE_NUM, 'T1', 850);
        INSERT INTO WORKTIME VALUES (223, SYSDATE-DATE_NUM, 'T2', 1950);
        INSERT INTO WORKTIME VALUES (224, SYSDATE-DATE_NUM, 'T1', 850);
        INSERT INTO WORKTIME VALUES (224, SYSDATE-DATE_NUM, 'T2', 1950);
        INSERT INTO WORKTIME VALUES (225, SYSDATE-DATE_NUM, 'T1', 850);
        INSERT INTO WORKTIME VALUES (225, SYSDATE-DATE_NUM, 'T2', 1950);
        INSERT INTO WORKTIME VALUES (226, SYSDATE-DATE_NUM, 'T1', 850);
        INSERT INTO WORKTIME VALUES (226, SYSDATE-DATE_NUM, 'T2', 1950);
        INSERT INTO WORKTIME VALUES (227, SYSDATE-DATE_NUM, 'T1', 850);
        INSERT INTO WORKTIME VALUES (227, SYSDATE-DATE_NUM, 'T2', 1950);
        INSERT INTO WORKTIME VALUES (228, SYSDATE-DATE_NUM, 'T1', 850);
        INSERT INTO WORKTIME VALUES (228, SYSDATE-DATE_NUM, 'T2', 1950);
        INSERT INTO WORKTIME VALUES (229, SYSDATE-DATE_NUM, 'T1', 850);
        INSERT INTO WORKTIME VALUES (229, SYSDATE-DATE_NUM, 'T2', 1950);
        INSERT INTO WORKTIME VALUES (230, SYSDATE-DATE_NUM, 'T1', 850);
        INSERT INTO WORKTIME VALUES (230, SYSDATE-DATE_NUM, 'T2', 1950);
        INSERT INTO WORKTIME VALUES (231, SYSDATE-DATE_NUM, 'T1', 850);
        INSERT INTO WORKTIME VALUES (231, SYSDATE-DATE_NUM, 'T2', 1950);
        INSERT INTO WORKTIME VALUES (232, SYSDATE-DATE_NUM, 'T1', 850);
        INSERT INTO WORKTIME VALUES (232, SYSDATE-DATE_NUM, 'T2', 1950);
        INSERT INTO WORKTIME VALUES (233, SYSDATE-DATE_NUM, 'T1', 850);
        INSERT INTO WORKTIME VALUES (233, SYSDATE-DATE_NUM, 'T2', 1950);
        INSERT INTO WORKTIME VALUES (234, SYSDATE-DATE_NUM, 'T1', 850);
        INSERT INTO WORKTIME VALUES (234, SYSDATE-DATE_NUM, 'T2', 1950);
        INSERT INTO WORKTIME VALUES (235, SYSDATE-DATE_NUM, 'T1', 850);
        INSERT INTO WORKTIME VALUES (235, SYSDATE-DATE_NUM, 'T2', 1950);
        INSERT INTO WORKTIME VALUES (236, SYSDATE-DATE_NUM, 'T1', 850);
        INSERT INTO WORKTIME VALUES (236, SYSDATE-DATE_NUM, 'T2', 1950);
        INSERT INTO WORKTIME VALUES (237, SYSDATE-DATE_NUM, 'T1', 850);
        INSERT INTO WORKTIME VALUES (237, SYSDATE-DATE_NUM, 'T2', 1950);
        INSERT INTO WORKTIME VALUES (238, SYSDATE-DATE_NUM, 'T1', 850);
        INSERT INTO WORKTIME VALUES (238, SYSDATE-DATE_NUM, 'T2', 1950);
        INSERT INTO WORKTIME VALUES (239, SYSDATE-DATE_NUM, 'T1', 850);
        INSERT INTO WORKTIME VALUES (239, SYSDATE-DATE_NUM, 'T2', 1950);
        INSERT INTO WORKTIME VALUES (240, SYSDATE-DATE_NUM, 'T1', 850);
        INSERT INTO WORKTIME VALUES (240, SYSDATE-DATE_NUM, 'T2', 1950);
        
        INSERT INTO WEEK_OVERTIME VALUES (200, SYSDATE-DATE_NUM, 50, WEEK_NUM, WEEK_OVER);
        INSERT INTO WEEK_OVERTIME VALUES (201, SYSDATE-DATE_NUM, 50, WEEK_NUM, WEEK_OVER);
        INSERT INTO WEEK_OVERTIME VALUES (202, SYSDATE-DATE_NUM, 50, WEEK_NUM, WEEK_OVER);
        INSERT INTO WEEK_OVERTIME VALUES (203, SYSDATE-DATE_NUM, 50, WEEK_NUM, WEEK_OVER);
        INSERT INTO WEEK_OVERTIME VALUES (204, SYSDATE-DATE_NUM, 50, WEEK_NUM, WEEK_OVER);
        INSERT INTO WEEK_OVERTIME VALUES (205, SYSDATE-DATE_NUM, 50, WEEK_NUM, WEEK_OVER);
        INSERT INTO WEEK_OVERTIME VALUES (206, SYSDATE-DATE_NUM, 50, WEEK_NUM, WEEK_OVER);
        INSERT INTO WEEK_OVERTIME VALUES (207, SYSDATE-DATE_NUM, 50, WEEK_NUM, WEEK_OVER);
        INSERT INTO WEEK_OVERTIME VALUES (208, SYSDATE-DATE_NUM, 50, WEEK_NUM, WEEK_OVER);
        INSERT INTO WEEK_OVERTIME VALUES (209, SYSDATE-DATE_NUM, 50, WEEK_NUM, WEEK_OVER);
        INSERT INTO WEEK_OVERTIME VALUES (210, SYSDATE-DATE_NUM, 50, WEEK_NUM, WEEK_OVER);
        INSERT INTO WEEK_OVERTIME VALUES (211, SYSDATE-DATE_NUM, 50, WEEK_NUM, WEEK_OVER);
        INSERT INTO WEEK_OVERTIME VALUES (212, SYSDATE-DATE_NUM, 50, WEEK_NUM, WEEK_OVER);
        INSERT INTO WEEK_OVERTIME VALUES (213, SYSDATE-DATE_NUM, 50, WEEK_NUM, WEEK_OVER);
        INSERT INTO WEEK_OVERTIME VALUES (214, SYSDATE-DATE_NUM, 50, WEEK_NUM, WEEK_OVER);
        INSERT INTO WEEK_OVERTIME VALUES (215, SYSDATE-DATE_NUM, 50, WEEK_NUM, WEEK_OVER);
        INSERT INTO WEEK_OVERTIME VALUES (216, SYSDATE-DATE_NUM, 50, WEEK_NUM, WEEK_OVER);
        INSERT INTO WEEK_OVERTIME VALUES (217, SYSDATE-DATE_NUM, 50, WEEK_NUM, WEEK_OVER);
        INSERT INTO WEEK_OVERTIME VALUES (218, SYSDATE-DATE_NUM, 50, WEEK_NUM, WEEK_OVER);
        INSERT INTO WEEK_OVERTIME VALUES (219, SYSDATE-DATE_NUM, 50, WEEK_NUM, WEEK_OVER);
        INSERT INTO WEEK_OVERTIME VALUES (220, SYSDATE-DATE_NUM, 50, WEEK_NUM, WEEK_OVER);
        INSERT INTO WEEK_OVERTIME VALUES (221, SYSDATE-DATE_NUM, 50, WEEK_NUM, WEEK_OVER);
        INSERT INTO WEEK_OVERTIME VALUES (222, SYSDATE-DATE_NUM, 50, WEEK_NUM, WEEK_OVER);
        INSERT INTO WEEK_OVERTIME VALUES (223, SYSDATE-DATE_NUM, 50, WEEK_NUM, WEEK_OVER);
        INSERT INTO WEEK_OVERTIME VALUES (224, SYSDATE-DATE_NUM, 50, WEEK_NUM, WEEK_OVER);
        INSERT INTO WEEK_OVERTIME VALUES (225, SYSDATE-DATE_NUM, 50, WEEK_NUM, WEEK_OVER);
        INSERT INTO WEEK_OVERTIME VALUES (226, SYSDATE-DATE_NUM, 50, WEEK_NUM, WEEK_OVER);
        INSERT INTO WEEK_OVERTIME VALUES (227, SYSDATE-DATE_NUM, 50, WEEK_NUM, WEEK_OVER);
        INSERT INTO WEEK_OVERTIME VALUES (228, SYSDATE-DATE_NUM, 50, WEEK_NUM, WEEK_OVER);
        INSERT INTO WEEK_OVERTIME VALUES (229, SYSDATE-DATE_NUM, 50, WEEK_NUM, WEEK_OVER);
        INSERT INTO WEEK_OVERTIME VALUES (230, SYSDATE-DATE_NUM, 50, WEEK_NUM, WEEK_OVER);
        INSERT INTO WEEK_OVERTIME VALUES (231, SYSDATE-DATE_NUM, 50, WEEK_NUM, WEEK_OVER);
        INSERT INTO WEEK_OVERTIME VALUES (232, SYSDATE-DATE_NUM, 50, WEEK_NUM, WEEK_OVER);
        INSERT INTO WEEK_OVERTIME VALUES (233, SYSDATE-DATE_NUM, 50, WEEK_NUM, WEEK_OVER);
        INSERT INTO WEEK_OVERTIME VALUES (234, SYSDATE-DATE_NUM, 50, WEEK_NUM, WEEK_OVER);
        INSERT INTO WEEK_OVERTIME VALUES (235, SYSDATE-DATE_NUM, 50, WEEK_NUM, WEEK_OVER);
        INSERT INTO WEEK_OVERTIME VALUES (236, SYSDATE-DATE_NUM, 50, WEEK_NUM, WEEK_OVER);
        INSERT INTO WEEK_OVERTIME VALUES (237, SYSDATE-DATE_NUM, 50, WEEK_NUM, WEEK_OVER);
        INSERT INTO WEEK_OVERTIME VALUES (238, SYSDATE-DATE_NUM, 50, WEEK_NUM, WEEK_OVER);
        INSERT INTO WEEK_OVERTIME VALUES (239, SYSDATE-DATE_NUM, 50, WEEK_NUM, WEEK_OVER);
        INSERT INTO WEEK_OVERTIME VALUES (240, SYSDATE-DATE_NUM, 50, WEEK_NUM, WEEK_OVER);
        
        
        
        
        DATE_NUM := DATE_NUM - 1;
        COUNT_OVER := COUNT_OVER + 1;
        
        IF COUNT_OVER = 2 THEN
            WEEK_OVER := 140;
        ELSIF COUNT_OVER = 3 THEN
            WEEK_OVER := 230;
        ELSIF COUNT_OVER = 4 THEN
            WEEK_OVER := 320;
        ELSIF COUNT_OVER = 5 THEN
            WEEK_OVER := 410;
        END IF;
            
        EXIT WHEN DATE_NUM <= 2;
    END LOOP;
END;
/

--프로필 사진 테스트
INSERT INTO PROFILE_FILES VALUES(100,'images.jpg');

INSERT INTO APPROLINE VALUES(200, 'D0', 203,null,null,null);
INSERT INTO APPROLINE VALUES(201, 'D0', 202,null,null,null);
INSERT INTO APPROLINE VALUES(202, 'D0', 201,null,null,null);
INSERT INTO APPROLINE VALUES(203, 'D0', 200,null,null,null);

COMMIT;
