DROP TABLE JOB CASCADE CONSTRAINTS;
DROP TABLE DEPARTMENT CASCADE CONSTRAINTS;
DROP TABLE EMPLOYEE CASCADE CONSTRAINTS;
DROP TABLE WT_TYPE CASCADE CONSTRAINTS;
DROP TABLE WORKTIME CASCADE CONSTRAINTS;
DROP TABLE BOARD_NOTICE CASCADE CONSTRAINTS;
DROP TABLE BOARD_NORMAL CASCADE CONSTRAINTS;
DROP TABLE BOARD_NORMAL_COMMENT CASCADE CONSTRAINTS;
DROP TABLE CALENDAR CASCADE CONSTRAINTS;
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
DROP SEQUENCE SEQ_NNO;
DROP SEQUENCE SEQ_BNO;
DROP SEQUENCE SEQ_EMP;


--부서
CREATE TABLE DEPARTMENT(
  DEPT_ID CHAR(3) PRIMARY KEY,
  DEPT_TITLE VARCHAR2(20) NOT NULL UNIQUE
 );

--직급
 CREATE TABLE JOB(
  JOB_CODE CHAR(3) PRIMARY KEY,
  JOB_NAME VARCHAR2(20) NOT NULL UNIQUE
  );


--사원
CREATE TABLE EMPLOYEE(
  EMP_ID VARCHAR2(50) NOT NULL UNIQUE,
  EMP_CODE NUMBER(3) PRIMARY KEY,
  PWD VARCHAR2(500) NOT NULL,
  EMP_NAME VARCHAR2(20) NOT NULL,
  PERSONAL_ID CHAR(14) NOT NULL UNIQUE,
  EMAIL VARCHAR2(25) NOT NULL UNIQUE,
  GENDER CHAR(1 BYTE) CHECK(GENDER IN('M','F')),
  AGE NUMBER(2) NOT NULL,
  SALARY NUMBER(10) DEFAULT 0,
  PHONE VARCHAR2(13) NOT NULL,
  ADDRESS VARCHAR2(500) NOT NULL,
  DEPT_CODE CHAR(3),
  JOB_CODE CHAR(3),
  MANAGER_YN VARCHAR2(1) CHECK(MANAGER_YN IN('Y','N')),
  HIRE_DATE DATE DEFAULT SYSDATE,
  ETC VARCHAR2(300),
  SUB_DEPT CHAR(2),
  
  CONSTRAINT EMPDEPT FOREIGN KEY (DEPT_CODE) REFERENCES DEPARTMENT ,
  CONSTRAINT EMPJOB FOREIGN KEY (JOB_CODE) REFERENCES JOB
  
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

-- EMPLOYEE 시퀀스
 CREATE SEQUENCE SEQ_EMP
 START WITH 206
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
  
  CONSTRAINT FK_BTYPE FOREIGN KEY(BTYPE) REFERENCES BOARD_CATEGORY
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
  CREATE TABLE CALENDAR(
  EMP_CODE NUMBER(3),
  CDATE DATE,
  TO_DO VARCHAR2(50),
  DDATE NUMBER
  );
  
  
--결제문서파일
 CREATE TABLE APPROVAL_FILES(
  DOC_NUMBER VARCHAR2(300),
  DOC_FILES VARCHAR2(500)
);

--프로필 사진 파일
 CREATE TABLE PROFILE_FILES(
 EMP_CODE NUMBER(3),
 PIC VARCHAR2(500)
 );

--결제게시판
  CREATE TABLE APPROVAL(
 DOC_NUMBER NUMBER CONSTRAINT APPDOC_PK PRIMARY KEY,
 ATITLE VARCHAR2(500) NOT NULL,
 AWRITER VARCHAR2(15) NOT NULL,
 DOC_TYPE VARCHAR2(50) NOT NULL,
 ASTATUS NUMBER CHECK(ASTATUS IN(0,1,2,3)),
 APPROVER VARCHAR2(200) NOT NULL,
 DEPT_CODE VARCHAR2(4) NOT NULL,
 INPEOPLE VARCHAR2(500)NOT NULL,
 INSTATUS VARCHAR2(500),
 COL_DEPT VARCHAR2(30),
 COL_PEOPLE VARCHAR2(1000),
 COL_STATUS VARCHAR2(500),
 END_PERSON VARCHAR2(40),
 VIEW_PEOPLE VARCHAR2(1000),
 DOC_DATE DATE DEFAULT SYSDATE,
 RETURNCOMMENT VARCHAR2(1000),
 DELETE_YN VARCHAR2(3) DEFAULT 'N' CHECK(DELETE_YN IN('Y','N'))
 );

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
  LEAVE_CODE CHAR(2) NOT NULL, -- L1 : 연차 / L2 : 월차 / L3 : 반차
  START_DATE DATE NOT NULL,
  END_DATE DATE NOT NULL,
  DAYOFF_MA CHAR(1) DEFAULT 'N' CHECK(DAYOFF_MA IN ('A','P','N')),  --  N : NULL / A : 오전 / P : 오후
  VCONTENT VARCHAR2(2000),
  
  FOREIGN KEY (DOC_NUMBER) REFERENCES APPROVAL,
  FOREIGN KEY (LEAVE_CODE) REFERENCES LEAVE
);

 CREATE TABLE LEAVE_COUNT(
 EMP_CODE NUMBER(3) NOT NULL,
 LEAVE_CODE CHAR(2) NOT NULL,
 LCOUNT NUMBER(3),
 
 FOREIGN KEY (EMP_CODE) REFERENCES EMPLOYEE,
 FOREIGN KEY (LEAVE_CODE) REFERENCES LEAVE
 );
 
CREATE TABLE WORKTIME(
    EMP_CODE NUMBER(3),
    WT_DATE DATE DEFAULT SYSDATE,
    TA_TYPE_CODE CHAR(2),
    WT_TIME NUMBER(10) NOT NULL,
    
    FOREIGN KEY (EMP_CODE) REFERENCES EMPLOYEE,
    FOREIGN KEY (TA_TYPE_CODE) REFERENCES WT_TYPE
);

CREATE TABLE WEEK_OVERTIME(
	EMP_CODE NUMBER(3) NOT NULL,            --SESSION
	TODAY_DATE DATE DEFAULT SYSDATE,
	TODAY_OVERTIME NUMBER(10),
	WEEK_OF_YEAR NUMBER(2) NOT NULL,
	THE_WEEK NUMBER(10) NOT NULL,

	FOREIGN KEY (EMP_CODE) REFERENCES EMPLOYEE
);
-- 수정예정
CREATE TABLE TA_DATA(
  EMP_CODE NUMBER(3) NOT NULL,
  LATE_COUNT NUMBER(2),
  ABSENT_COUNT NUMBER(2),
  WORKDAY_COUNT NUMBER(2),
  
  FOREIGN KEY (EMP_CODE) REFERENCES EMPLOYEE
);
--  근태 끝


CREATE TABLE ROUNDTABLE(
  DOC_NUMBER NUMBER NOT NULL UNIQUE,
  RCONTENT VARCHAR2(2000),
  
  FOREIGN KEY (DOC_NUMBER) REFERENCES APPROVAL
);

CREATE TABLE PAYTABLE(
  DOC_NUMBER NUMBER NOT NULL UNIQUE,
  PAID NUMBER NOT NULL,
  PCONTENT VARCHAR2(2000),
  
  FOREIGN KEY (DOC_NUMBER) REFERENCES APPROVAL
);



CREATE TABLE STAMP(
 EMP_CODE VARCHAR2(3),
 STAMP_FILE VARCHAR2(100)
);


------------------------------------------------------------------------
--  INSERT  ------------------------------------------------------------
--  DEPARTMENT
INSERT INTO DEPARTMENT VALUES ('D0', '임원');
INSERT INTO DEPARTMENT VALUES ('D1', '인사부서');
INSERT INTO DEPARTMENT VALUES ('D2', '영업부서');
INSERT INTO DEPARTMENT VALUES ('D3', '기획부서');
INSERT INTO DEPARTMENT VALUES ('D4', '연구부서');

--  JOB
INSERT INTO JOB VALUES ('J1', '사장');
INSERT INTO JOB VALUES ('J2', '부사장');
INSERT INTO JOB VALUES ('J3', '상무');
INSERT INTO JOB VALUES ('J4', '부장');
INSERT INTO JOB VALUES ('J5', '차장');
INSERT INTO JOB VALUES ('J6', '과장');
INSERT INTO JOB VALUES ('J7', '대리');
INSERT INTO JOB VALUES ('J8', '사원');

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
INSERT INTO EMPLOYEE VALUES('admin',100,
        'x61Ey612Kl2gpFL56FT9weDnpSo4AV8j8+qx2AuTHdRyY036xxzTTrw10Wq3+4qQyB+XURPWx1ONxp3Y3pB37A==','관리자','111111-1111111',
        'admin@COO.com','M',20,3000000,'010-2222-2222','서울시 강남구'
        ,'D0','J3','Y',SYSDATE,'관리자',NULL);
INSERT INTO EMPLOYEE VALUES('USER01',200,
        'x61Ey612Kl2gpFL56FT9weDnpSo4AV8j8+qx2AuTHdRyY036xxzTTrw10Wq3+4qQyB+XURPWx1ONxp3Y3pB37A==',
        '유저1','111111-1111112',
        'USER01@COO.com','M',20,3000000,'010-2222-2222','서울시 강남구'
        ,'D1','J4','N',SYSDATE,NULL,NULL);
INSERT INTO EMPLOYEE VALUES('USER02',201,
        'x61Ey612Kl2gpFL56FT9weDnpSo4AV8j8+qx2AuTHdRyY036xxzTTrw10Wq3+4qQyB+XURPWx1ONxp3Y3pB37A==',
        '유저2','111111-1111113',
        'USER02@COO.com','M',20,3000000,'010-2222-2222','서울시 강남구'
        ,'D3','J2','N',SYSDATE,NULL,NULL);
INSERT INTO EMPLOYEE VALUES('USER03',202,
        'x61Ey612Kl2gpFL56FT9weDnpSo4AV8j8+qx2AuTHdRyY036xxzTTrw10Wq3+4qQyB+XURPWx1ONxp3Y3pB37A==',
        '유저3','111111-1111114',
        'USER03@COO.com','F',20,3000000,'010-2222-2222','서울시 강남구'
        ,'D4','J2','N',SYSDATE,NULL,NULL);
INSERT INTO EMPLOYEE VALUES('USER04',203,
        'x61Ey612Kl2gpFL56FT9weDnpSo4AV8j8+qx2AuTHdRyY036xxzTTrw10Wq3+4qQyB+XURPWx1ONxp3Y3pB37A==',
        '유저4','111111-1111115',
        'USER04@COO.com','F',20,3000000,'010-2222-2222','서울시 강남구'
        ,'D2','J6','N',SYSDATE,NULL,NULL);
INSERT INTO EMPLOYEE VALUES('USER05',204,
        'x61Ey612Kl2gpFL56FT9weDnpSo4AV8j8+qx2AuTHdRyY036xxzTTrw10Wq3+4qQyB+XURPWx1ONxp3Y3pB37A==',
        '유저5','111111-1111116',
        'USER05@COO.com','M',20,3000000,'010-2222-2222','서울시 강남구'
        ,'D0','J2','N',SYSDATE,NULL,NULL);
INSERT INTO EMPLOYEE VALUES('USER06',205,
        'x61Ey612Kl2gpFL56FT9weDnpSo4AV8j8+qx2AuTHdRyY036xxzTTrw10Wq3+4qQyB+XURPWx1ONxp3Y3pB37A==',
        '유저6','111111-1111117',
        'USER06@COO.com','F',20,3000000,'010-2222-2222','서울시 강남구'
        ,'D4','J8','N',SYSDATE,NULL,NULL);



COMMIT;