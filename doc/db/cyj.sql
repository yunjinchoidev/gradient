-- 간트
CREATE TABLE gantte(
	ganttekey	NUMBER PRIMARY KEY,
	contents	varchar2(4000),
	finaldate	DATE,
	projectkey NUMBER CONSTRAINT gantte_projectkey_fk REFERENCES project(projectkey) ON DELETE CASCADE,
	memberkey NUMBER CONSTRAINT gantte_memberkey_fk REFERENCES member(memberkey) ON DELETE CASCADE
);



-- 프로젝트 통합(PM)
CREATE TABLE unify(
	unifykey	NUMBER PRIMARY KEY,
	progress	varchar2(400),
	outline	varchar2(4000),
	projectkey NUMBER CONSTRAINT unify_projectkey_fk REFERENCES project(projectkey) ON DELETE CASCADE,
	memberkey NUMBER CONSTRAINT unify_memberkey_fk REFERENCES member(memberkey) ON DELETE CASCADE
);
SELECT * FROM unify;


-- 요구사항
CREATE TABLE request(
	requestkey NUMBER PRIMARY KEY,
	title varchar2(400),
	contents	varchar2(4000),
	projectkey NUMBER CONSTRAINT request_projectkey_fk REFERENCES project(projectkey) ON DELETE CASCADE	
);

-- 칸반
CREATE TABLE kanban(
	kanbankey	NUMBER PRIMARY KEY,
	title	varchar2(400),
	content	varchar2(4000),
	projectkey NUMBER CONSTRAINT kanban_projectkey_fk REFERENCES project(projectkey) ON DELETE CASCADE,
	memberkey NUMBER CONSTRAINT kanban_memberkey_fk REFERENCES member(memberkey) ON DELETE CASCADE
);


--캘린더
SELECT * FROM calendars;
CREATE TABLE calendars(
	id NUMBER PRIMARY KEY,
	title varchar2(100),
	start1 varchar2(50),
	end1 varchar2(50),
	content varchar2(500),
	backgroundcolor varchar2(20),
	textcolor varchar2(20),
	allday NUMBER(1.0),
	projectkey NUMBER CONSTRAINT calendars_projectkey_fk REFERENCES project(projectkey) ON DELETE CASCADE,
	memberkey NUMBER CONSTRAINT calendars_memberkey_fk REFERENCES member(memberkey) ON DELETE CASCADE
);
CREATE SEQUENCE CAL_SEQ START WITH 1 MINVALUE 1;
INSERT INTO calendars VALUES (cal_seq.nextval, '일정등록시작', '2022-03-27', '2022-03-27', '내용', 'navy', 'yellow', 1,1,1);
DROP TABLE calendars;
































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
INSERT INTO project VALUES (1, 'IT프로젝트', sysdate, 1000000, '홍길동', '초기', '상', '전국 마스크 판매 사이트 구축', 1);
DROP TABLE project;
CREATE SEQUENCE seq_project START WITH 1;



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
DROP SEQUENCE seq_member;
CREATE SEQUENCE seq_member;
INSERT INTO MEMBER VALUES (seq_member.nextval, 'himan', '7777','홍길동', '개발자', 1, 1);
COMMIT;	








	-- 고객처
CREATE TABLE client(
	clientkey NUMBER PRIMARY KEY,
	name varchar2(400),
	repnum varchar2(400),
	repaddr varchar2(400),
	manager varchar2(400)
);
CREATE SEQUENCE seq_client;
INSERT INTO client VALUES (seq_client.nextval,'새회사', '01012345678','서울','김철수');






DROP TABLE notice;
CREATE TABLE notice(
	noticekey NUMBER PRIMARY KEY,
	title varchar2(400),
	content varchar2(4000),
	views NUMBER,
	writedate DATE,
	memberkey NUMBER CONSTRAINT notice_memberkey_fk REFERENCES member(memberkey) ON DELETE CASCADE
);
CREATE SEQUENCE seq_notice;
SELECT * FROM notice;
insert into notice VALUES (seq_notice.nextval, '1', '1', 0, sysdate, 1);



	
CREATE TABLE mywork(
	myworkkey	NUMBER PRIMARY KEY,
	memberkey NUMBER CONSTRAINT mywork_memberkey_fk REFERENCES member(memberkey) ON DELETE CASCADE,
	title	varchar2(400),
	contents	varchar2(4000),
	thedate	DATE,
	importance	number
);



CREATE TABLE output(
	outputkey	NUMBER PRIMARY KEY,
	title varchar2(400),
	version	NUMBER,
	projectkey	NUMBER CONSTRAINT output_projectkey_fk REFERENCES project(projectkey) ON DELETE CASCADE ,
	deptno NUMBER CONSTRAINT output_deptno_fk REFERENCES department(deptno) ON DELETE CASCADE
)



create TABLE fileInfo(
	fno NUMBER PRIMARY KEY,
	pathInfo	varchar2(400),
	fname		varchar2(400),
	regdate	DATE,
	update	DATE,
	etc	varchar2(400)
)
	
SELECT * FROM fileInfo;
DROP SEQUENCE seq_fileInfo;
CREATE SEQUENCE seq_fileInfo;
	
	
