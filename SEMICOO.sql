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
  PERSONAL_ID CHAR(14) NOT NULL UNIQUE,
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
			       
 ALTER TABLE BOARD_NOTICE MODIFY NDATE DEFAULT SYSDATE;
			       
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
  BDEPT_CODE VARCHAR2(15),
  
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
 EMP_CODE NUMBER(3),
 PIC VARCHAR2(500)
 );

--결제게시판
  CREATE TABLE APPROVAL(
 DOC_NUMBER NUMBER CONSTRAINT APPDOC_PK PRIMARY KEY,  -- 문서번호, 트리거
 ATITLE VARCHAR2(500) NOT NULL,  -- 제목
 AWRITER NUMBER(15) NOT NULL, -- 작성자 코드
 DOC_TYPE VARCHAR2(50) NOT NULL, -- 문서 타입
 ASTATUS NUMBER CHECK(ASTATUS IN(0,1,2,3,4)), -- 문서 진행상황 0: 내부결재 진행, 1: 합의 부서 진행, 2: 최종결재 진행  3: 결재 완료 4: 반려
 APPROVER VARCHAR2(200) NOT NULL, -- 해당 결재자
 DEPT_CODE VARCHAR2(4) NOT NULL, -- 결재 부서 
 DEPT_TITLE VARCHAR2(20) NOT NULL, --결재명
 INPEOPLE VARCHAR2(500)NOT NULL, --결재인원 
 INSTATUS VARCHAR2(500),  --결재인원당 결재상태
 COL_DEPT VARCHAR2(4), -- 합의 부서 코드
 COL_DEPTNAME  VARCHAR2(20), -- 합의 부서명
 COL_PEOPLE VARCHAR2(1000), -- 합의 부서 인원 코드
 COL_STATUS VARCHAR2(500), -- 합의부서당 결재 상태
 END_DEPTC VARCHAR2(4),  --최종 결재부서 코드
 END_DEPTN VARCHAR2(20), -- 최종 인원부서명
 END_PERSON VARCHAR2(40), --최종 결재원
 VIEW_PEOPLE VARCHAR2(1000), -- 참조 인원
 DOC_DATE DATE DEFAULT SYSDATE, -- 문서 날짜
 RETURNCOMMENT VARCHAR2(1000), -- 반려 코멘트
 DELETE_YN VARCHAR2(3) DEFAULT 'N' CHECK(DELETE_YN IN('Y','N')) -- 삭제여부
 );
				
--정/부/결제라인저장 테이블
CREATE TABLE APPROLINE( --결제 정/부 결제 라인 저장 테이블
    EMP_CODE NUMBER CONSTRAINT APPROLINE_EMP_ERROR REFERENCES EMPLOYEE,
    DEPT_CODE VARCHAR2(3),
    SUB_CODE NUMBER CONSTRAINT APPROLINE_SUB_ERROR REFERENCES EMPLOYEE,
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
  WORKDAY_COUNT NUMBER(2),
  
  FOREIGN KEY (EMP_CODE) REFERENCES EMPLOYEE
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
        'x61Ey612Kl2gpFL56FT9weDnpSo4AV8j8+qx2AuTHdRyY036xxzTTrw10Wq3+4qQyB+XURPWx1ONxp3Y3pB37A==','관리자',
        'yo','111111-1111111','admin@COO.com','M',20,3000000,'010-2222-2222','010-2222-2222','서울시 강남구'
        ,'D0','J3','Y',SYSDATE,'관리자',NULL);
INSERT INTO EMPLOYEE VALUES('USER01',200,
        'x61Ey612Kl2gpFL56FT9weDnpSo4AV8j8+qx2AuTHdRyY036xxzTTrw10Wq3+4qQyB+XURPWx1ONxp3Y3pB37A==',
        '유저1','whatsup','111111-1111112',
        'USER01@COO.com','M',20,3000000,'010-2222-2222','010-2222-2222','서울시 강남구'
        ,'D1','J4','N',SYSDATE,NULL,NULL);
INSERT INTO EMPLOYEE VALUES('USER02',201,
        'x61Ey612Kl2gpFL56FT9weDnpSo4AV8j8+qx2AuTHdRyY036xxzTTrw10Wq3+4qQyB+XURPWx1ONxp3Y3pB37A==',
        '유저2','hey','111111-1111113',
        'USER02@COO.com','M',20,3000000,'010-2222-2222','010-2222-2222','서울시 강남구'
        ,'D3','J2','N',SYSDATE,NULL,NULL);
INSERT INTO EMPLOYEE VALUES('USER03',202,
        'x61Ey612Kl2gpFL56FT9weDnpSo4AV8j8+qx2AuTHdRyY036xxzTTrw10Wq3+4qQyB+XURPWx1ONxp3Y3pB37A==',
        '유저3','bro','111111-1111114',
        'USER03@COO.com','F',20,3000000,'010-2222-2222','010-2222-2222','서울시 강남구'
        ,'D4','J2','N',SYSDATE,NULL,NULL);
INSERT INTO EMPLOYEE VALUES('USER04',203,
        'x61Ey612Kl2gpFL56FT9weDnpSo4AV8j8+qx2AuTHdRyY036xxzTTrw10Wq3+4qQyB+XURPWx1ONxp3Y3pB37A==',
        '유저4','long','111111-1111115',
        'USER04@COO.com','F',20,3000000,'010-2222-2222','010-2222-2222','서울시 강남구'
        ,'D2','J6','N',SYSDATE,NULL,NULL);
INSERT INTO EMPLOYEE VALUES('USER05',204,
        'x61Ey612Kl2gpFL56FT9weDnpSo4AV8j8+qx2AuTHdRyY036xxzTTrw10Wq3+4qQyB+XURPWx1ONxp3Y3pB37A==',
        '유저5','time','111111-1111116',
        'USER05@COO.com','M',20,3000000,'010-2222-2222','010-2222-2222','서울시 강남구'
        ,'D0','J2','N',SYSDATE,NULL,NULL);
INSERT INTO EMPLOYEE VALUES('USER06',205,
        'x61Ey612Kl2gpFL56FT9weDnpSo4AV8j8+qx2AuTHdRyY036xxzTTrw10Wq3+4qQyB+XURPWx1ONxp3Y3pB37A==',
        '유저6','nffo','111111-1111117',
        'USER06@COO.com','F',20,3000000,'010-2222-2222','010-2222-2222','서울시 강남구'
        ,'D4','J8','N',SYSDATE,NULL,NULL);
        
--- 부서별 검색을 위한 코드
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 1, '전체 공지', '연습용 전체 공지 입니다.', 'admin', DEFAULT, sysdate, DEFAULT, 1, 'D0');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 1, '전체 게시판', '연습용 전체 게시판 입니다.', 'admin', DEFAULT, sysdate, DEFAULT, 1, 'D0');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 2, '일반 게시판', '연습용 일반 게시판 입니다.', 'admin', DEFAULT, sysdate, DEFAULT, 2, 'D0');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 2, '일반 공지', '연습용 일반 공지 입니다.', 'admin', DEFAULT, sysdate, DEFAULT, 2, 'D0');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 3, '업무 게시판', '연습용 업무 게시판 입니다.', 'admin', DEFAULT, sysdate, DEFAULT, 3, 'D0');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 3, '업무 공지', '연습용 업무 공지 입니다.', 'admin', DEFAULT, sysdate, DEFAULT, 3, 'D0');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 4, '부서 게시판', '연습용 부서 게시판 입니다.', 'admin', DEFAULT, sysdate, DEFAULT, 4, 'D0');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 4, '부서 공지', '연습용 부서 공지 입니다.', 'admin', DEFAULT, sysdate, DEFAULT, 1, 'D0');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 1, '전체 공지', '연습용 전체 공지 입니다.', 'USER01', DEFAULT, sysdate, DEFAULT, 1, 'D1');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 2, '일반 공지', '연습용  일반 공지 입니다.', 'USER01', DEFAULT, sysdate, DEFAULT, 2, 'D1');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 3, '업무 공지', '연습용  업무 공지 입니다.', 'USER01', DEFAULT, sysdate, DEFAULT, 3, 'D1');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 4, '부서 공지', '연습용  부서 공지 입니다.', 'USER01', DEFAULT, sysdate, DEFAULT, 4, 'D1');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 1, '전체 게시판', '연습용 게시판 입니다.', 'USER01', DEFAULT, sysdate, DEFAULT, 1, 'D1');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 2, '일반 게시판', '연습용 게시판 입니다.', 'USER01', DEFAULT, sysdate, DEFAULT, 2, 'D1');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 3, '업무 게시판', '연습용 게시판 입니다.', 'USER01', DEFAULT, sysdate, DEFAULT, 3, 'D1');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 4, '부서 게시판', '연습용 게시판 입니다.', 'USER01', DEFAULT, sysdate, DEFAULT, 4, 'D1');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 1, '전체 공지', '연습용 전체 공지 입니다.', 'USER02', DEFAULT, sysdate, DEFAULT, 1, 'D3');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 2, '일반 공지', '연습용  일반 공지 입니다.', 'USER02', DEFAULT, sysdate, DEFAULT, 2, 'D3');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 3, '업무 공지', '연습용  업무 공지 입니다.', 'USER02', DEFAULT, sysdate, DEFAULT, 3, 'D3');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 4, '부서 공지', '연습용  부서 공지 입니다.', 'USER02', DEFAULT, sysdate, DEFAULT, 4, 'D3');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 1, '전체 게시판', '연습용 전체 게시판 입니다.', 'USER02', DEFAULT, sysdate, DEFAULT, 1, 'D3');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 2, '일반 게시판', '연습용 일반 게시판 입니다.', 'USER02', DEFAULT, sysdate, DEFAULT, 2, 'D3');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 3, '업무 게시판', '연습용 업무 게시판 입니다.', 'USER02', DEFAULT, sysdate, DEFAULT, 3, 'D3');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 4, '부서 게시판', '연습용 부서 게시판 입니다.', 'USER02', DEFAULT, sysdate, DEFAULT, 4, 'D3');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 1, '전체 공지', '연습용 전체 공지 입니다.', 'USER03', DEFAULT, sysdate, DEFAULT, 1, 'D4');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 2, '일반 공지', '연습용  일반 공지 입니다.', 'USER03', DEFAULT, sysdate, DEFAULT, 2, 'D4');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 3, '업무 공지', '연습용  업무 공지 입니다.', 'USER03', DEFAULT, sysdate, DEFAULT, 3, 'D4');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 4, '부서 공지', '연습용  부서 공지 입니다.', 'USER03', DEFAULT, sysdate, DEFAULT, 4, 'D4');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 1, '전체 게시판', '연습용 전체 게시판 입니다.', 'USER03', DEFAULT, sysdate, DEFAULT, 1, 'D4');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 2, '일반 게시판', '연습용 일반 게시판 입니다.', 'USER03', DEFAULT, sysdate, DEFAULT, 2, 'D4');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 3, '업무 게시판', '연습용 업무 게시판 입니다.', 'USER03', DEFAULT, sysdate, DEFAULT, 3, 'D4');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 4, '부서 게시판', '연습용 부서 게시판 입니다.', 'USER03', DEFAULT, sysdate, DEFAULT, 4, 'D4');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 1, '전체 공지', '연습용 전체 공지 입니다.', 'USER04', DEFAULT, sysdate, DEFAULT, 1, 'D2');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 2, '일반 공지', '연습용  일반 공지 입니다.', 'USER04', DEFAULT, sysdate, DEFAULT, 2, 'D2');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 3, '업무 공지', '연습용  업무 공지 입니다.', 'USER04', DEFAULT, sysdate, DEFAULT, 3, 'D2');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 4, '부서 공지', '연습용  부서 공지 입니다.', 'USER04', DEFAULT, sysdate, DEFAULT, 4, 'D2');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 1, '전체 게시판', '연습용 전체 게시판 입니다.', 'USER04', DEFAULT, sysdate, DEFAULT, 1, 'D2');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 2, '일반 게시판', '연습용 일반 게시판 입니다.', 'USER04', DEFAULT, sysdate, DEFAULT, 2, 'D2');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 3, '업무 게시판', '연습용 업무 게시판 입니다.', 'USER04', DEFAULT, sysdate, DEFAULT, 3, 'D2');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 4, '부서 게시판', '연습용 부서 게시판 입니다.', 'USER04', DEFAULT, sysdate, DEFAULT, 4, 'D2');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 1, '전체 공지', '연습용 전체 공지 입니다.', 'USER05', DEFAULT, sysdate, DEFAULT, 1, 'D0');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 2, '일반 공지', '연습용  일반 공지 입니다.', 'USER05', DEFAULT, sysdate, DEFAULT, 2, 'D0');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 3, '업무 공지', '연습용  업무 공지 입니다.', 'USER05', DEFAULT, sysdate, DEFAULT, 3, 'D0');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 4, '부서 공지', '연습용  부서 공지 입니다.', 'USER05', DEFAULT, sysdate, DEFAULT, 4, 'D0');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 1, '전체 게시판', '연습용 게시판 입니다.', 'USER05', DEFAULT, sysdate, DEFAULT, 1, 'D0');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 2, '일반 게시판', '연습용 게시판 입니다.', 'USER05', DEFAULT, sysdate, DEFAULT, 2, 'D0');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 3, '업무 게시판', '연습용 게시판 입니다.', 'USER05', DEFAULT, sysdate, DEFAULT, 3, 'D0');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 4, '부서 게시판', '연습용 게시판 입니다.', 'USER05', DEFAULT, sysdate, DEFAULT, 4, 'D0');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 1, '전체 공지', '연습용 전체 공지 입니다.', 'USER06', DEFAULT, sysdate, DEFAULT, 1, 'D4');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 2, '일반 공지', '연습용 일반 공지 입니다.', 'USER06', DEFAULT, sysdate, DEFAULT, 2, 'D4');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 3, '업무 공지', '연습용 업무 공지 입니다.', 'USER06', DEFAULT, sysdate, DEFAULT, 3, 'D4');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 4, '부서 공지', '연습용 부서 공지 입니다.', 'USER06', DEFAULT, sysdate, DEFAULT, 4, 'D4');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 1, '전체 게시판', '연습용 전체 게시판 입니다.', 'USER06', DEFAULT, sysdate, DEFAULT, 1, 'D4');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 2, '일반 게시판', '연습용 일반 게시판 입니다.', 'USER06', DEFAULT, sysdate, DEFAULT, 2, 'D4');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 3, '업무 게시판', '연습용 업무 게시판 입니다.', 'USER06', DEFAULT, sysdate, DEFAULT, 3, 'D4');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 4, '부서 게시판', '연습용 부서 게시판 입니다.', 'USER06', DEFAULT, sysdate, DEFAULT, 4, 'D4');
-- 추가 더미 데이터
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 1, '전체 공지', '더미 데이터 찾기 용 이것이 삶인가 그렇다면 다시 한번더 : 니체', 'admin', DEFAULT, TO_DATE('02/02/11','yy/mm/dd'), DEFAULT, 1, 'D0 ');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 1, '전체 공지', '더미 데이터 찾기 용 오늘날 프로그래밍은 바보도 문제없이 쓸 수 있는 프로그램을 더 거대하고 더 낫게 구축하려 애쓰는  소프트웨어 기술자와 더 거대한 하고 더 나은 바보를 만들려는 우주의 경쟁이다. 지금까지는 우주가 이기고 있다.', 'admin', DEFAULT, TO_DATE('2020-02-12','YYYY-MM-DD', DEFAULT, 1, 'D0 ');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 1, '전체 공지', '더미 데이터 찾기 용 물 위를 걷는 것과 명세서로 소프트웨어를 개발하는 것은 쉽다. 둘다  동결되었다면…… ', 'USER04', DEFAULT, TO_DATE('2020-02-11','YYYY-MM-DD', DEFAULT, 1, 'D0 ');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 1, '전체 공지', '더미 데이터 찾기 용 코드 실행 "위 코드의 버그를 조심하라. 나는 코드가 올바르다는 것만 증명했을 뿐, 실행해보지는 않았다." -도널드크누스- ', 'admin', DEFAULT, TO_DATE('2020-02-11','YYYY-MM-DD'), DEFAULT, 1, 'D0 ');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 2, '전체 공지', '컴퓨터 시스템 분석은 아이를 키우는 것과 같다. 극심한 상처를 줄 수는 있지만 성공을 보장해줄 수는 없다.', 'USER06', DEFAULT, TO_DATE('2020-02-11','YYYY-MM-DD'), DEFAULT, 1, 'D4 ');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 2, '전체 공지', '프로그램-프로그래밍 : PHP가 무능한 아마추어들이 구상하고 만든 소소한 악이라면, 펄은 유능하지만 변태적인 프로들이 구상하고 만든 거대하고 교활한 악이다.', 'USER01', DEFAULT, TO_DATE('2020-02-13','YYYY-MM-DD'), DEFAULT, 2, 'D1');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 2, '전체 공지', '프로그램-프로그래밍 : 나는 진정한 프로그래머가 아니다. 될 때까지 이것저것 마구 시도해보고 되면 다음으로 넘어간다. 진정한 프로그래머는 “네, 되긴 하지만 여기저기서 메모리 누수가 발생합니다. 아마 수정해야겠지요”라고 말한다. 나는 그냥 요청이 10번 들어올 때마다 아파치를 재시작한다. -라스무스 러도프(1968년 11월 22일 ).-', 'USER01', DEFAULT, TO_DATE('2020-02-12','YYYY-MM-DD'), DEFAULT, 1, 'D1');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 2, '전체 공지', '프로그램-프로그래밍 : 쓰레기가 들어가면 무엇이 나오는가? “두 차례나, 그것도 국회의원들에게 이런 질문을 받았다. ‘배비지씨, 기계에 틀린 수치를 입력해도 올바른 답이 나옵니까?’ 나는 어떤 개념의 혼란에 빠져야 그러한 질문이 나오는지 도무지 이해할 수 없다.', 'USER01', DEFAULT, TO_DATE('2020-02-11','YYYY-MM-DD'), DEFAULT, 1, 'D1');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 1, '전체 공지', '프로그램-프로그래밍 : 자신이 컴퓨터를 싫어한다고 생각하는 사람들을 보면, 사실은 형편없는 프로그래머를 싫어하는 것이다.', 'USER03', DEFAULT, sysdate, DEFAULT, 1, 'D4');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 1, '전체 공지', '프로그램-프로그래밍 : 올바로 동작하지 않더라도 걱정말아라. 모든 것이 그랬다면, 넌 직업을 잃었을테니까. -소프트웨어 공학에서의 모셔의 법칙(Mosher’s Law)-', 'USER03', DEFAULT, sysdate, DEFAULT, 1, 'D4');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 2, '일반 공지', '프로그램-프로그래밍 : 그래, 자바가 프로그래밍 언어가 따라야 할 전형일 수는 있다. 하지만, 자바 애플리케이션은 애플리케이션이라면 반드시 피해야할 전형이다. -pixadel', 'USER01', DEFAULT, TO_DATE('2020-02-14','YYYY-MM-DD'), DEFAULT, 2, 'D1');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 3, '업무 공지', '프로그램-프로그래밍 : 유일한 진실을 말하자면, 객체 지향 판 ‘스파게티 코드’는, 당연히, 라쟈냐 코드’이다. (과하게 많은 계층) -로버트 월트만(Roberto Waltman)', 'USER01', DEFAULT, sysdate, DEFAULT, 3, 'D1');  
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 4, '부서 공지', '프로그램-프로그래밍 : 오랜 시간 나는 그토록 비싸고, 그토록 첨단인 무엇이 그토록 쓸모 없을 수 있는지 이해하지 못했다. 그러다가 컴퓨터는 놀랍도록 똑똑한 것을 할 수 있는 멍청한 기계이고, 컴퓨터 프로그래머는 놀랍도록 멍청한 짓을 할 수 있는 똑똑한 사람이라는 생각이 들었다.  즉, 둘은 완벽한 한 쌍이다.', 'USER02', DEFAULT, sysdate, DEFAULT, 4, 'D3');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 1, '전체 게시판', '프로그램-프로그래밍 : 말은 쉽지, 코드를 보여줘. -리누스 토르발스(Linus Torvalds)', 'USER02', DEFAULT, sysdate, DEFAULT, 1, 'D3');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 2, '일반 게시판', '프로그램-프로그래밍 : 완벽함은 아무것도 더할 것이 없을 때가 아닌, 아무것도 제거할 것이 남지 않았을 때 달성된다.', 'USER02', DEFAULT, sysdate, DEFAULT, 2, 'D3');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 1, '전체 게시판', '프로그램-프로그래밍 : 이론상, 이론과 실제는 같다. 실제로는, 그렇지 않다.', 'USER02', DEFAULT, sysdate, DEFAULT, 1, 'D3');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 1, '전체 공지', '프로그램-프로그래밍 : 사람들은 컴퓨터 과학이 천재들의 기예이라고 생각하지만 사실 현실은 반대로, 단지 많은 사람이, 작은 돌로 된 담처럼, 다른 사람의 작업 위에 쌓아 올릴 뿐이다.', 'admin', DEFAULT, TO_DATE('02/02/11','yy/mm/dd'), DEFAULT, 1, 'D0 ');
INSERT INTO BOARD_NORMAL VALUES(SEQ_BNO.NEXTVAL, 3, '업무 게시판', '아모르파티 , 니체', 'USER02', DEFAULT, sysdate, DEFAULT, 3, 'D3');

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
COMMIT;