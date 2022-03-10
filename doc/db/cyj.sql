--스케쥴
CREATE TABLE schedule(
	name varchar2(100),
	title varchar2(400),
	contents varchar2(4000)
	);
SELECT * FROM  schedule;

--캘린더
SELECT * FROM calendar;
CREATE TABLE calendar(
	id NUMBER PRIMARY KEY,
	title varchar2(100),
	start1 varchar2(50),
	end1 varchar2(50),
	content varchar2(500),
	backgroundcolor varchar2(20),
	textcolor varchar2(20),
	allday NUMBER(1.0)
);
CREATE SEQUENCE CAL_SEQ START WITH 1 MINVALUE 1;
INSERT INTO calendar VALUES (cal_seq.nextval, '일정등록시작', '2022-03-27', '2022-03-27', '내용', 'navy', 'yellow', 1);
DROP TABLE calendar;

	
-- 고객처
CREATE TABLE client(
	clientkey NUMBER PRIMARY KEY,
	name varchar2(400),
	repnum varchar2(400),
	repaddr varchar2(400),
	manager varchar2(400)
)

-- 프로젝트
CREATE TABLE project(
	projectkey	NUMBER PRIMARY KEY,
	name varchar2(400),
	term	DATE,
	take	NUMBER,
	manager	varchar2(400),
	progress	varchar2(400),
	importance	varchar2(400),
	contents	varchar2(400),
	clientkey	NUMBER,
	CONSTRAINT fk_clientkey FOREIGN KEY(clientkey)
         REFERENCES client(clientkey) ON DELETE CASCADE
);
DROP TABLE project;


-- 부서
CREATE TABLE department(
	deptno NUMBER PRIMARY KEY,
	projectkey NUMBER,
	dname varchar2(400),
	dcnt NUMBER,
	CONSTRAINT fk_projectkey FOREIGN KEY(projectkey)
         REFERENCES project(projectkey) ON DELETE CASCADE
)


--회원테이블
DROP TABLE MEMBER;
CREATE TABLE member(
	memberkey NUMBER PRIMARY KEY,
	id	varchar2(400),
	pass	varchar2(400),
	name	varchar2(400),
	auth	varchar2(400),
	projectkey	NUMBER CONSTRAINT member_projectkey_fk REFERENCES project(projectkey) ON DELETE CASCADE ,
	deptno NUMBER CONSTRAINT member_deptno_fk REFERENCES department(deptno) ON DELETE CASCADE
);
COMMIT;	
	
	
	
	
	
	
	
	