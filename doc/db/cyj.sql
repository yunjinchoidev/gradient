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

-- 칸반 // 작업 단위
DROP TABLE kanban CASCADE CONSTRAINTS;
CREATE TABLE kanban(
	id	NUMBER PRIMARY KEY, -- 칸반 키
	status varchar2(400), -- 위치
	text	varchar2(400),  -- 제목 
	tags varchar2(400), -- 태그 
	content	varchar2(4000), -- 내용 
	color varchar2(400), -- 색깔
	writedate DATE,  -- 작성일
	duedate DATE,
	projectkey NUMBER CONSTRAINT kanban_projectkey_fk REFERENCES project(projectkey) ON DELETE CASCADE,
	memberkey NUMBER CONSTRAINT kanban_memberkey_fk REFERENCES member(memberkey) ON DELETE CASCADE,
	deptno NUMBER CONSTRAINT kanban_deptno_fk REFERENCES department (deptno) ON DELETE CASCADE
);
SELECT * FROM kanban;
INSERT INTO kanban VALUES(seq_kanban.nextval,'new','작업 대기', '난이도상 어려움','내용입니다ㅋㅋ','red', sysdate,sysdate,1,1,1);
INSERT INTO kanban VALUES(seq_kanban.nextval,'done','작업 중입니다.','tag1 tag2','내용입니다','red', sysdate,sysdate,1,1,1);
INSERT INTO kanban VALUES(seq_kanban.nextval,'work','작업중입니다.','tag1 tag2','내용입니다','red', sysdate,sysdate,1,1,1);
DELETE FROM kanban;
UPDATE kanban SET label='gg', tags='gg' WHERE id=53;
CREATE SEQUENCE seq_kanban;
COMMIT;

	SELECT * FROM member;
	
	
SELECT cal_seq.nextval FROM dual;
SELECT * FROM calendar;
--캘린더
SELECT * FROM calendars;
DROP TABLE calendar;
CREATE TABLE calendar(
	id NUMBER PRIMARY KEY,
	title varchar2(100),
	start1 varchar2(50),
	end1 varchar2(50),
	content varchar2(500),
	bordercolor varchar2(20),
	backgroundcolor varchar2(20),
	textcolor varchar2(20),
	allday NUMBER(1.0)
);




CREATE TABLE calendars(
	id NUMBER PRIMARY KEY,
	title varchar2(100),
	start1 varchar2(50),
	end1 varchar2(50),
	content varchar2(500),
	bordercolor varchar2(20),
	backgroundcolor varchar2(20),
	textcolor varchar2(20),
	allday NUMBER(1.0),
	projectkey NUMBER CONSTRAINT calendars_projectkey_fk REFERENCES project(projectkey) ON DELETE CASCADE,
	memberkey NUMBER CONSTRAINT calendars_memberkey_fk REFERENCES member(memberkey) ON DELETE CASCADE
);
CREATE SEQUENCE CAL_SEQ START WITH 1 MINVALUE 1;
INSERT INTO calendars VALUES (cal_seq.nextval, '일정등록시작', '2022-03-27', '2022-03-27', '내용', 'navy', 'yellow', 1,1,1);
DROP TABLE calendars CASCADE CONSTRAINTS;
SELECT * FROM calendars;
















DROP TABLE quality;
CREATE TABLE quality(
	qualitykey	NUMBER PRIMARY KEY,
	projectkey NUMBER CONSTRAINT quality_projectkey_fk REFERENCES project(projectkey) ON DELETE CASCADE,
	memberkey NUMBER CONSTRAINT quality_memberkey_fk REFERENCES member(memberkey) ON DELETE CASCADE,
	qualityManagement	varchar2(400),
	writedate DATE,
	qualityEvaluation	varchar2(400)
);
CREATE sequence seq_quality;
INSERT INTO QUALITY VALUES (1, 1, 1, 'ㅁㄹ', sysdate, '11231');


-- 리스크 관리
CREATE TABLE risk(
	riskkey	NUMBER PRIMARY KEY,
	projectkey NUMBER CONSTRAINT risk_projectkey_fk REFERENCES project(projectkey) ON DELETE CASCADE,
	memberkey NUMBER CONSTRAINT risk_memberkey_fk REFERENCES member(memberkey) ON DELETE CASCADE,
	content varchar2(4000),
	progress	varchar2(400),
	writedate	DATE,
	importance	varchar2(400)
);




CREATE TABLE burget(
	budgetkey NUMBER PRIMARY KEY,
	projectkey NUMBER CONSTRAINT burget_projectkey_fk REFERENCES project(projectkey) ON DELETE CASCADE,
	memberkey NUMBER CONSTRAINT burget_memberkey_fk REFERENCES member(memberkey) ON DELETE CASCADE,
	examount	NUMBER,
	empnum	NUMBER,
	prjperiod	varchar2(400),
	buddetail	varchar2(400),
	content	varchar2(4000),
	budamount	number
);


CREATE TABLE chating(
	chatKey	NUMBER PRIMARY KEY,
	memberkey NUMBER CONSTRAINT chating_memberkey_fk REFERENCES member(memberkey) ON DELETE CASCADE,
	content	varchar2(4000),
	writeDate	DATE,
	chatrommkey	NUMBER
);



CREATE TABLE meeting(
	meetingkey NUMBER PRIMARY KEY,
	topic	varchar2(400),
	content	varchar2(4000),
	shorthand	varchar2(400),
	meetingDate	DATE,
	projectkey NUMBER CONSTRAINT meeting_projectkey_fk REFERENCES project(projectkey) ON DELETE CASCADE
);





CREATE TABLE procurement(
	procurementKey	NUMBER PRIMARY KEY,
	procurementPlan	varchar2(400),
	procurementDate	DATE,
	purchsePlan	varchar2(4000),
	procurementManagement	varchar2(400),
	selectSeller	varchar2(400),
	contractAdministration	varchar2(400),
	contractClosure	varchar2(400),
	requestSellerResponses	varchar2(400),
	contractingPlan	varchar2(400),
	purchasesPlanandAcquisitions	varchar2(400),
	projectkey NUMBER CONSTRAINT procurement_projectkey_fk REFERENCES project(projectkey) ON DELETE CASCADE
);







-- 프로젝트
DROP TABLE project CASCADE CONSTRAINTS;
CREATE TABLE project(
	projectkey	NUMBER PRIMARY KEY,
	name varchar2(400),
	term	DATE,
	take	NUMBER,
	manager	varchar2(400),
	progress	varchar2(400),
	importance	varchar2(400),
	contents	varchar2(400),
	clientkey NUMBER CONSTRAINT project_clientkey_fk REFERENCES client(clientkey) ON DELETE CASCADE,
	startdate DATE,
	lastdate DATE,
);

SELECT * FROM project;




COMMIT;
select * 
from project p, client c
where p.clientkey=c.clientkey;
SELECT * FROM client;
INSERT INTO project VALUES (1, 'IT프로젝트', sysdate, 1000000, '홍길동', '초기', '상', '전국 마스크 판매 사이트 구축', 1,sysdate, sysdate);
INSERT INTO project VALUES (2, '코로나 백신 예약 사이트', sysdate, 1000000, '홍길동', '초기', '상', '코로나 백신 예약 사이트 구축', 1,sysdate, sysdate);
INSERT INTO project VALUES (3, '청년 적금 신청 사이트', sysdate, 1000000, '홍길동', '초기', '상', '청년 적금 신청 사이트 구축', 1, sysdate, sysdate);
DROP TABLE project;
CREATE SEQUENCE seq_project START WITH 1;



SELECT m.name, m.auth, p.name projectname, p.progress, d.dname  
FROM member m, project p, department d
WHERE m.projectkey = p.projectkey
AND p.PROJECTKEY = d.PROJECTKEY;

SELECT * FROM MEMBER;
SELECT * FROM project;
SELECT * FROM DEPARTMENT d ;




DROP TABLE MEMBER CASCADE CONSTRAINTS;
CREATE TABLE member(
	memberkey NUMBER PRIMARY KEY,
	id	varchar2(400),
	pass	varchar2(400),
	name	varchar2(400),
	auth	varchar2(400),
	projectkey	NUMBER CONSTRAINT member_projectkey_fk REFERENCES project(projectkey) ON DELETE CASCADE ,
	deptno NUMBER CONSTRAINT member_deptno_fk REFERENCES department(deptno) ON DELETE CASCADE,
	email varchar2(200) DEFAULT 'test@testaaaaaaaa.com' NOT NULL
);
ALTER TABLE member ADD email VARCHAR(200) DEFAULT 'test@testaaaaaaaa.com' NOT NULL;







DROP TABLE MEMBER CASCADE CONSTRAINTS;
SELECT * FROM MEMBER ORDER BY MEMBERKEY; 
INSERT INTO MEMBER VALUES;
DROP SEQUENCE seq_member;
CREATE SEQUENCE seq_member;
INSERT INTO MEMBER VALUES (1, 'himan', '7777','홍길동', '개발자', 1, 1, 'cyj7157@naver.com');
INSERT INTO MEMBER VALUES (2, 'admin', '7777','김철수', 'PM', 1, 1, 'cyj7157@naver.com');
INSERT INTO MEMBER VALUES (seq_member.nextval, 'randomid'||to_char(seq_memberid.nextval), 'randompass'||to_char(seq_memberpass.nextval), NULL, NULL, NULL, NULL, 'cyj7157@naver.com');

COMMIT;	
CREATE SEQUENCE seq_memberid START WITH 30000;
DROP SEQUENCE seq_member;
drop SEQUENCE seq_memberid;
CREATE SEQUENCE seq_memberpass START WITH 999;
drop SEQUENCE seq_memberpass;
 
DROP SEQUENCE seq_memberregi;
CREATE SEQUENCE seq_memberregi START WITH 3;
SELECT seq_memberregi.currval FROM dual;
SELECT seq_memberregi.nextval FROM dual;
COMMIT;


-- 부서
DROP TABLE department CASCADE CONSTRAINTS;
CREATE TABLE department(
	deptno NUMBER PRIMARY KEY,
	projectkey NUMBER,
	dname varchar2(400),
	dcnt NUMBER,
	CONSTRAINT fk_projectkey FOREIGN KEY(projectkey)
         REFERENCES project(projectkey) ON DELETE CASCADE
);
DELETE FROM DEPARTMENT;
INSERT INTO department values(1, 1, '기획', 5);
INSERT INTO department values(2, 1, 'pm', 5);
INSERT INTO department values(3, 1, 'front', 5);
INSERT INTO department values(4, 1, 'backend', 5);
INSERT INTO department values(5, 1, 'custom', 5);
SELECT * FROM DEPARTMENT ORDER BY deptno;
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

----------------------------------------------------------------
SELECT * FROM notice_Attach;
SELECT n.noticekey, title,
		content, VIEWs, writedate, m.NAME name, a.uuid, a.uploadpath, a.filename, a.filetype
		FROM notice n, MEMBER m, notice_Attach a
		WHERE n.MEMBERKEY = m.MEMBERKEY
		AND n.NOTICEKEY = a.noticekey
		order by noticekey;


	
	
	
------------------------------------------------------
DROP TABLE notice CASCADE CONSTRAINTS;
CREATE TABLE notice(
	noticekey NUMBER PRIMARY KEY,
	refno NUMBER,
	title varchar2(400),
	content varchar2(4000),
	views NUMBER,
	writedate DATE,
	memberkey NUMBER CONSTRAINT notice_memberkey_fk REFERENCES member(memberkey) ON DELETE CASCADE
);
CREATE SEQUENCE seq_notice;
DROP SEQUENCE seq_notice;
SELECT * FROM notice ORDER BY noticekey;
SELECT * FROM MEMBER;
insert into notice VALUES (0, 1, 1, '1', 0, sysdate, 1);
insert into notice VALUES (seq_notice.nextval, 0, '제목입니다', '안녕하세요', 0, sysdate, 1);
SELECT * FROM MEMBER;
COMMIT;



--------------------------------------------------------
create table notice_reply (
  rno number(10,0) PRIMARY KEY, 
  noticekey NUMBER CONSTRAINT notice_reply_noticekey_fk REFERENCES notice(noticekey) ON DELETE CASCADE,
  reply varchar2(1000) not null,
  replyer varchar2(50) not null, 
  replyDate date default sysdate, 
  updateDate date default sysdate
);
create sequence seq_reply_notice;
COMMIT;
SELECT * FROM notice_reply;
	insert into notice_reply (rno, noticekey, reply,
		replyer)
		values (seq_reply_notice.nextval, 3, 'a',
		'cyj');
select * from notice_reply where
		rno =
		2;


SELECT noticekey, title, content, VIEWs, writedate, m.NAME name
FROM notice n, MEMBER m
WHERE n.MEMBERKEY = m.MEMBERKEY;

	






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

DELETE fileInfo;
SELECT * FROM fileInfo;
DROP SEQUENCE seq_fileInfo;
CREATE SEQUENCE seq_fileInfo;
	
create TABLE fileInfo(
	fno NUMBER PRIMARY KEY,
	pathInfo	varchar2(400),
	fname		varchar2(400),
	regdate	DATE,
	update	DATE,
	etc	varchar2(400)
);	
COMMIT;


CREATE TABLE notice_Attach(
	uuid varchar2(100) NOT NULL PRIMARY KEY,
	uploadPath varchar2(200) NOT NULL,
	fileName varchar2(100) NOT NULL,
	fileType char(1) DEFAULT 'I',
	noticekey NUMBER CONSTRAINT notice_Attach_noticekey_fk REFERENCES notice(noticekey) ON DELETE CASCADE
);

INSERT into notice_attach VALUES ('1','1','1','1',1);






























