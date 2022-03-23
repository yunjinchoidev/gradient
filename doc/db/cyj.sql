-- 간트
DROP TABLE gantt;
CREATE TABLE gantt(
	id	NUMBER PRIMARY KEY,
	text	varchar2(4000),
	start_date	DATE,
	duration NUMBER,
	projectkey NUMBER CONSTRAINT gantte_projectkey_fk REFERENCES project(projectkey) ON DELETE CASCADE,
	memberkey NUMBER CONSTRAINT gantte_memberkey_fk REFERENCES member(memberkey) ON DELETE CASCADE
);
DELETE FROM gantt;
CREATE SEQUENCE seq_gantt;
INSERT INTO gantt VALUES (seq_gantt.nextval, '간트', sysdate, 4, 1, 1);
SELECT * FROM gantt;
SELECT id, text, to_char(start_date, 'DD-MM-YYYY') start_date, duration, projectkey, memberkey
FROM gantt;
SELECT * FROM gantt WHERE TO_CHAR(SYSDATE, 'YYYY/MM/dd') <= TO_CHAR(start_date+duration, 'YYYY/MM/dd')
AND TO_CHAR(SYSDATE, 'YYYY/MM/dd') >= TO_CHAR(start_date, 'YYYY/MM/dd');
SELECT  FROM gantt; 








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
INSERT INTO kanban VALUES(seq_kanban.nextval,'new','작업 대기', '난이도상 어려움','내용입니다ㅋㅋ','red', sysdate,sysdate,1,2,1);
INSERT INTO kanban VALUES(seq_kanban.nextval,'done','작업 중입니다.','tag1 tag2','내용입니다','red', sysdate,sysdate,1,2,1);
INSERT INTO kanban VALUES(seq_kanban.nextval,'work','작업중입니다.','tag1 tag2','내용입니다','red', sysdate,sysdate,1,2,1);
DELETE FROM kanban;
UPDATE kanban SET label='gg', tags='gg' WHERE id=53;
CREATE SEQUENCE seq_kanban;
COMMIT;
select * FROM kanban where status='work';
SELECT * FROM kanban WHERE projectkey=1;



	
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
SELECT * FROM CALENDARS c;
DELETE calendars WHERE id=20020;
SELECT sUBSTR(end1,0,10), 'YYYYMMDD'  fROM CALENDARs;
SELECT TO_CHAR(SYSDATE, 'YYYY/MM/dd'),to_char(TO_DATE(SUBSTR(end1,0, 10), 'YYYY-MM-DD'),'YYYY-MM-DD') FROM CALENDARs;
SELECT  FROM CALENDARs;
SELECT TO_CHAR(, 'YYYY-MM-DD') result1 
  FROM dual;

SELECT TO_date(SUBSTR(end1, 0, 10), 'YYYY/MM/dd')
FROM CALENDARS;

// 오늘이 껴있는 일 개수
SELECT count(*) FROM calendars WHERE TO_CHAR(SYSDATE, 'YYYY/MM/dd') <= to_char(TO_DATE(SUBSTR(end1,0, 10), 'YYYY-MM-DD'),'YYYY/MM/DD')
AND TO_CHAR(SYSDATE, 'YYYY/MM/dd') >= to_char(TO_DATE(SUBSTR(start1,0, 10), 'YYYY-MM-DD'),'YYYY/MM/DD');

// 가장 긴급한 일
SELECT * FROM (SELECT a.* FROM CALENDARS a ORDER BY end1)
WHERE TO_CHAR(SYSDATE, 'YYYY/MM/dd') <= to_char(TO_DATE(SUBSTR(end1,0, 10), 'YYYY-MM-DD'),'YYYY/MM/DD')
AND TO_CHAR(SYSDATE, 'YYYY/MM/dd') >= to_char(TO_DATE(SUBSTR(start1,0, 10), 'YYYY-MM-DD'),'YYYY/MM/DD') AND rownum=1;









----------------------------- 프로젝트 캘린더
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
SELECT cal_seq.nextval FROM dual;
SELECT * FROM calendar;















--------------------------- 품질
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







SELECT * FROM project;
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


	SELECT IMPORTANCE, count(*) count
		FROM risk
		GROUP BY IMPORTANCE;


-- 예산
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



-- 채팅
CREATE TABLE chating(
	chatKey	NUMBER PRIMARY KEY,
	memberkey NUMBER CONSTRAINT chating_memberkey_fk REFERENCES member(memberkey) ON DELETE CASCADE,
	content	varchar2(4000),
	writeDate	DATE,
	chatrommkey	NUMBER
);





-- 미팅
CREATE TABLE meeting(
	meetingkey NUMBER PRIMARY KEY,
	topic	varchar2(400),
	content	varchar2(4000),
	shorthand	varchar2(400),
	meetingDate	DATE,
	projectkey NUMBER CONSTRAINT meeting_projectkey_fk REFERENCES project(projectkey) ON DELETE CASCADE
);




-- 조달
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






-----------------------------------------------------------------
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
COMMIT;
SELECT * FROM MEMBER;
SELECT * FROM project;
select * 
from project p, client c
where p.clientkey=c.clientkey;
SELECT * FROM client;
INSERT INTO project VALUES (1, 'IT프로젝트', sysdate, 30000000, '홍길동', '초기', '상', '전국 마스크 판매 사이트 구축', 1,sysdate, sysdate);
INSERT INTO project VALUES (2, '코로나 백신 예약 사이트', sysdate, 1000000, '홍길동', '초기', '상', '코로나 백신 예약 사이트 구축', 1,sysdate, sysdate);
INSERT INTO project VALUES (3, '청년 적금 신청 사이트', sysdate, 5000000, '홍길동', '초기', '중', '청년 적금 신청 사이트 구축', 1, sysdate, sysdate);
INSERT INTO project VALUES (4, '관공서 구축 프로젝트', sysdate, 5000000, '홍길동', '초기', '중', '청년 적금 신청 사이트 구축', 1, sysdate, sysdate);
INSERT INTO project VALUES (5, '마트 재고 관리 프로젝트', sysdate, 5000000, '홍길동', '초기', '하', '청년 적금 신청 사이트 구축', 1, sysdate, sysdate);
INSERT INTO project VALUES (6, '쇼핑몰 프로젝트', sysdate, 5000000, '홍길동', '초기', '상', '청년 적금 신청 사이트 구축', 1, sysdate, sysdate);
INSERT INTO project VALUES (7, '정육 도매 구축 프로젝트', sysdate, 5000000, '홍길동', '초기', '상', '청년 적금 신청 사이트 구축', 1, sysdate, sysdate);
DROP TABLE project;
CREATE SEQUENCE seq_project START WITH 1;
SELECT m.name, m.auth, p.name projectname, p.progress, d.dname  
FROM member m, project p, department d
WHERE m.projectkey = p.projectkey
AND p.PROJECTKEY = d.PROJECTKEY;
SELECT * FROM MEMBER ORDER BY memberkey;
SELECT * FROM project;
SELECT * FROM DEPARTMENT d ;
CREATE SEQUENCE seq_project;
SELECT * FROM fileinfo ORDER BY fno;



------------------ 회원 테이블
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


SELECT * FROM MEMBER ORDER BY memberkey;
DROP TABLE MEMBER CASCADE CONSTRAINTS;
SELECT * FROM MEMBER ORDER BY MEMBERKEY; 
INSERT INTO MEMBER VALUES;
DROP SEQUENCE seq_member;
CREATE SEQUENCE seq_member;
SELECT seq_member.nextval FROM dual;
INSERT INTO MEMBER VALUES (1, 'himan', '7777','홍길동', '개발자', 1, 1, 'cyj7157@naver.com');
INSERT INTO MEMBER VALUES (2, 'admin', '7777','김철수', 'PM', 1, 1, 'cyj7157@naver.com');
INSERT INTO MEMBER VALUES 
(seq_member.nextval, 'randomid'||to_char(seq_memberid.nextval), 'randompass'||to_char(seq_memberpass.nextval), NULL, NULL, NULL, NULL, 'cyj7157@naver.com');

COMMIT;	
CREATE SEQUENCE seq_memberid START WITH 30000;
DROP SEQUENCE seq_member;
CREATE SEQUENCE seq_member;
drop SEQUENCE seq_memberid;
CREATE SEQUENCE seq_memberpass START WITH 999;
drop SEQUENCE seq_memberpass;
 
DROP SEQUENCE seq_memberregi;
CREATE SEQUENCE seq_memberregi START WITH 3;
SELECT seq_memberregi.currval FROM dual;
SELECT seq_memberregi.nextval FROM dual;
COMMIT;
SELECT * FROM MEMBER;


-- 부서
DROP TABLE department CASCADE CONSTRAINTS;
CREATE TABLE department(
	deptno NUMBER PRIMARY KEY,
	dname varchar2(400),
	dcnt NUMBER
);
DELETE FROM DEPARTMENT;
INSERT INTO department values(1,'기획', 5);
INSERT INTO department values(2,'pm', 5);
INSERT INTO department values(3, 'front', 5);
INSERT INTO department values(4, 'backend', 5);
INSERT INTO department values(5, 'custom', 5);
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
insert into notice_reply (rno, noticekey, reply,replyer) values (seq_reply_notice.nextval, 3, 'a','cyj');
select * from notice_reply WHERE rno =2;
SELECT noticekey, title, content, VIEWs, writedate, m.NAME name
FROM notice n, MEMBER m
WHERE n.MEMBERKEY = m.MEMBERKEY;

	





-- 나의 작업
CREATE TABLE mywork(
	myworkkey	NUMBER PRIMARY KEY,
	memberkey NUMBER COㅈNSTRAINT mywork_memberkey_fk REFERENCES member(memberkey) ON DELETE CASCADE,
	title	varchar2(400),
	contents	varchar2(4000),
	thedate	DATE,
	importance	number
);



-- 산출물
DROP TABLE OUTPUT;
CREATE TABLE output(
	outputkey	NUMBER PRIMARY KEY,
	title varchar2(400),
	contents varchar2(4000),
	version	NUMBER,
	status	varchar2(400),
	writedate DATE,
	workSortKey	NUMBER CONSTRAINT output_workSortKey_fk REFERENCES workSort(workSortKey) ON DELETE CASCADE ,
	projectkey	NUMBER CONSTRAINT output_projectkey_fk REFERENCES project(projectkey) ON DELETE CASCADE ,
	memberkey	NUMBER CONSTRAINT output_memberkey_fk REFERENCES member(memberkey) ON DELETE CASCADE ,
	deptno NUMBER CONSTRAINT output_deptno_fk REFERENCES department(deptno) ON DELETE CASCADE
);
drop SEQUENCE seq_output;
CREATE SEQUENCE seq_output START WITH 10005;
SELECT seq_output.nextval FROM dual;
INSERT INTO OUTPUT VALUES (seq_output.nextval, '요구사항정의저 제출합니다', '요구사항정의서 제출합니다.',
1.2,'진행중',sysdate,1,1,2,1
);

SELECT * FROM fileInfo order BY fno;
SELECT * FROM OUTPUT;
SELECT * FROM board3;

SELECT o.*
FROM OUTPUT o, MEMBER m;

select o.*, m.name mname, w.title worksortTitle, p.name pname, d.dname
FROM OUTPUT o, member m, workSort w, project p, DEPARTMENT d
		where o.memberkey = m.memberkey
		and o.worksortkey = w.worksortkey
		and o.projectkey = p.projectkey
		and o.deptno = d.deptno;

SELECT WORKSORTKEY, count(WORKSORTKEY) FROM OUTPUT
GROUP BY worksortkey
ORDER BY WORKSORTKEY;
SELECT * FROM worksort;
INSERT INTO OUTPUT values (seq_output.nextval, '1', '1', 1, 1,sysdate, 11,1,2,1);
SELECT * FROM OUTPUT;	
	


	SELECT worksortkey, count(worksortkey) count FROM OUTPUT
	WHERE memberkey=4
	GROUP BY worksortkey
	ORDER BY WORKSORTKEY;
	COMMIT;	

DROP TABLE team;
CREATE TABLE team(
	teamkey NUMBER PRIMARY KEY,
	teamname varchar2(400),
	projectkey	NUMBER CONSTRAINT team_projectkey_fk REFERENCES project(projectkey) ON DELETE CASCADE
);
CREATE SEQUENCE seq_team;
drop SEQUENCE seq_team;
INSERT INTO team VALUES (seq_team.nextval, '기획 1팀', 1);
INSERT INTO team VALUES (seq_team.nextval, '기획 2팀', 1);
INSERT INTO team VALUES (seq_team.nextval, '기획 3팀', 1);
INSERT INTO team VALUES (seq_team.nextval, '개발 1팀', 1);
INSERT INTO team VALUES (seq_team.nextval, '개발 2팀', 1);
INSERT INTO team VALUES (seq_team.nextval, '개발 3팀', 1);
INSERT INTO team VALUES (seq_team.nextval, '고객 1팀', 1);
INSERT INTO team VALUES (seq_team.nextval, '고객 2팀', 1);
INSERT INTO team VALUES (seq_team.nextval, '고객 3팀', 1);
INSERT INTO team VALUES (seq_team.nextval, '기획 1팀', 1);

SELECT * FROM team;
DROP TABLE team_member;
CREATE TABLE team_member(
	team_member_key NUMBER PRIMARY KEY,
	teamkey	NUMBER CONSTRAINT team_member_teamkey_fk REFERENCES team(teamkey) ON DELETE CASCADE,
	memberkey	NUMBER CONSTRAINT team_member_memberkey_fk REFERENCES member(memberkey) ON DELETE CASCADE
);
CREATE SEQUENCE seq_team_member;
drop SEQUENCE seq_team_member;
INSERT INTO team_member VALUES (seq_team_member.nextval, 3, 14);
SELECT * FROM team_member;



1 - 다 - 다 
pj  team memberf

CREATE TABLE team_member





SELECT * FROM OUTPUT;
SELECT * FROM MEMBER ORDER BY memberkey;




	

-- 외래키 없이 파일 정보 저장
create TABLE fileInfo(
	fno NUMBER PRIMARY KEY,
	pathInfo	varchar2(400),
	fname		varchar2(400),
	regdte	DATE,
	uptdte	DATE,
	etc	varchar2(400)
);

DROP TABLE fileInfo;
DELETE fileInfo;
SELECT * FROM fileInfo;
INSERT INTO fileinfo values(seq_fileInfo.nextval,'1','1',sysdate,sysdate,'1');
DROP SEQUENCE seq_fileInfo;
CREATE SEQUENCE seq_fileInfo;
SELECT seq_fileInfo.nextval FROM dual;	
		insert into fileInfo values
		(4, '1', '1', sysdate, sysdate, '1');
SELECT * FROM MEMBER ORDER BY memberkey;
SELECT * FROM fileinfo WHERE fno=2;
SELECT * FROM NOTICE_ATTACH;
DROP TABLE fileInfo;
create TABLE fileInfo(
	fno NUMBER,
	pathInfo varchar2(400),
	fname	varchar2(400),
	regdate	DATE,
	uptdate	DATE,
	etc	varchar2(400)
);	
COMMIT;
DROP sequence  seq_member;
CREATE sequence  seq_member;
SELECT * FROM fileInfo ORDER BY fno;
INSERT into fileInfo VALUES (seq_member.nextval,'1','1',sysdate,sysdate,'1');
SELECT * FROM MEMBER order  BY memberkey;
UPDATE 

-- 공지 파일
CREATE TABLE notice_Attach(
	uuid varchar2(100) NOT NULL PRIMARY KEY,
	uploadPath varchar2(200) NOT NULL,
	fileName varchar2(100) NOT NULL,
	fileType char(1) DEFAULT 'I',
	noticekey NUMBER CONSTRAINT notice_Attach_noticekey_fk REFERENCES notice(noticekey) ON DELETE CASCADE
);

INSERT into notice_attach VALUES ('1','1','1','1',1);




DROP TABLE member_project;
CREATE TABLE member_project(
	member_project_key NUMBER,
	memberkey NUMBER CONSTRAINT member_project_memberkey_fk REFERENCES member(memberkey) ON DELETE CASCADE,
	projectkey NUMBER CONSTRAINT member_project_project_fk REFERENCES project(projectkey) ON DELETE CASCADE
)

SELECT * FROM MEMBER;
SELECT * FROM project;
UPDATE project SET name='청소 대행 서비스 구축' WHERE projectkey=1;
UPDATE project SET progress='중기' WHERE projectkey=1;
UPDATE project SET progress='대기' WHERE projectkey=2;
UPDATE project SET progress='초기' WHERE projectkey=3;
UPDATE project SET progress='말기' WHERE projectkey=4;
UPDATE project SET progress='종료' WHERE projectkey=5;
UPDATE project SET importance='하' WHERE projectkey=2;
UPDATE project SET importance='중' WHERE projectkey=3;
UPDATE project SET importance='하' WHERE projectkey=4;
INSERT INTO member_project VALUES (1,2,4);
		select DISTINCT projectkey from member_project where memberkey=2 order by memberkey;
SELECT * FROM project WHERE projectkey IN (1,2,3);
SELECT * FROM project WHERE projectkey IN (
		select DISTINCT projectkey 
		from member_project 
		where memberkey=2 
		order by memberkey
);
SELECT * FROM fileInfo ORDER BY fno;
SELECT * FROM notice ORDER BY noticekey;
SELECT * FROM NOTICE_ATTACH;
DELETE FROM NOTICE_ATTACH WHERE noticekey = 0;


SELECT * FROM project ORDER BY PROJECTKEY;
select * from project  where projectkey=1 order by projectkey;



--------------------------------------------------
DROP TABLE projectHome;
CREATE TABLE projectHome(
	projectHomekey NUMBER PRIMARY KEY,
	title varchar2(400),
	contents varchar2(400),
	memberkey NUMBER CONSTRAINT projectHome_memberkey_fk REFERENCES member(memberkey) ON DELETE CASCADE,
	projectkey NUMBER CONSTRAINT projectHome_project_fk REFERENCES project(projectkey) ON DELETE CASCADE,
	workSortKey NUMBER CONSTRAINT projectHome_workSort_fk REFERENCES workSort(workSortKey) ON DELETE CASCADE,
	importance varchar2(400),
	writedate DATE
);
CREATE SEQUENCE seq_projectHome;
	select * from project ORDER BY projectkey;

SELECT ph.*, ws.title workSortTitle
FROM projectHome ph, worksort ws
WHERE ph.workSortKey = ws.workSortKey
AND projectkey=1;
SELECT seq_projectHome.nextval FROM dual;
INSERT INTO projectHome values(seq_projectHome.nextval, '이것 부탁합니다', '이것 부탁합니다', 2, 1, 1, 3,sysdate);
SELECT * FROM project;

CREATE TABLE workSort(
	workSortKey NUMBER PRIMARY KEY,
	title varchar2(400)
);
SELECT title FROM workSort;
SELECT name FROM project;
INSERT INTO workSort VALUES (1, '간트차트');
INSERT INTO workSort VALUES (2, '칸반보드');
INSERT INTO workSort VALUES (3, '일정관리');
INSERT INTO workSort VALUES (4, '산출물관리');
INSERT INTO workSort VALUES (5, '회의록');
INSERT INTO workSort VALUES (6, '채팅');
INSERT INTO workSort VALUES (7, '예산관리');
INSERT INTO workSort VALUES (8, '품질관리');
INSERT INTO workSort VALUES (9, '조달관리');
INSERT INTO workSort VALUES (10, '인적관리');
INSERT INTO workSort VALUES (11, '리스크관리');











---------------------------
SELECT * FROM vote;

DROP TABLE vote;
CREATE TABLE vote(
	votekey NUMBER PRIMARY KEY,
	title varchar2(400),
	contents varchar2(4000),
	writedate DATE,
	enddate DATE,
	voteoption varchar2(400),
	item1 varchar2(400),
	item2 varchar2(400),
	item3 varchar2(400),
	item4 varchar2(400),
	item5 varchar2(400),
	voteItem1 NUMBER default 0,
	voteItem2 NUMBER default 0,
	voteItem3 NUMBER default 0,
	voteItem4 NUMBER default 0,
	voteItem5 NUMBER default 0,
	memberkey NUMBER CONSTRAINT vote_memberkey_fk REFERENCES member(memberkey) ON DELETE CASCADE,
	projectkey NUMBER CONSTRAINT vote_project_fk REFERENCES project(projectkey) ON DELETE CASCADE
);
CREATE SEQUENCE seq_vote;


CREATE TABLE memo(
	memokey NUMBER PRIMARY KEY,
	title varchar2(400),
	contents varchar2(4000),
	writedate DATE,
	importance varchar2(400),
	memberkey NUMBER CONSTRAINT memo_memberkey_fk REFERENCES member(memberkey) ON DELETE CASCADE
);
DROP TABLE memo;
CREATE SEQUENCE seq_memo;
SELECT * FROM memo where memberkey=1;
DELETE FROM memo;
insert into memo values (seq_memo.nextval, '메모 하나', '3월 25일 : 3차 발표',sysdate,'하',4);

CREATE SEQUENCE cal_seq START WITH 20000;
SELECT cal_seq.currval FROM dual;
SELECT * FROM calendars;
SELECT * FROM fileInfo;
