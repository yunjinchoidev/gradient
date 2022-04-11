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














--------------------------- 품질
DROP TABLE quality;
CREATE TABLE quality(
	qualitykey	NUMBER PRIMARY KEY,
	projectkey NUMBER CONSTRAINT quality_projectkey_fk REFERENCES project(projectkey) ON DELETE CASCADE,
	memberkey NUMBER CONSTRAINT quality_memberkey_fk REFERENCES member(memberkey) ON DELETE CASCADE,
	writedate DATE,
	title varchar2(400),
	contents varchar2(400)
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





-- 채팅
CREATE TABLE chating(
	chatKey	NUMBER PRIMARY KEY,
	memberkey NUMBER CONSTRAINT chating_memberkey_fk REFERENCES member(memberkey) ON DELETE CASCADE,
	content	varchar2(4000),
	writeDate	DATE,
	chatrommkey	NUMBER
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
CREATE SEQUENCE seq_project START WITH 1;



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
	status NUMBER,
	pricing NUMBER,
	visitcnt NUMBER,
	score NUMBER
);
UPDATE MEMBER
SET score=0
WHERE memberkey BETWEEN 1 AND 100;

ALTER TABLE member ADD status NUMBER;
ALTER TABLE member ADD pricing NUMBER;
ALTER TABLE member ADD visitcnt NUMBER;
ALTER TABLE member ADD score NUMBER;
CREATE profile(
	profile NUMBER PRIMARY KEY, 
	memberkey	NUMBER CONSTRAINT profile_memberkey_fk REFERENCES member(memberkey) ON DELETE CASCADE,
	pricing NUMBER,
	ACCESS NUMBER,
	
)


		
CREATE SEQUENCE seq_auth;
	
CREATE TABLE auth(
	memberkey NUMBER CONSTRAINT auth_memberkey_fk REFERENCES member(memberkey) ON DELETE CASCADE,
	auth varchar2(400)
);
select * FROM auth;

CREATE SEQUENCE seq_member;
CREATE SEQUENCE seq_memberid START WITH 30000;
CREATE SEQUENCE seq_member;
CREATE SEQUENCE seq_memberpass START WITH 999;
CREATE SEQUENCE seq_memberregi START WITH 3;


-- 부서
DROP TABLE department CASCADE CONSTRAINTS;
CREATE TABLE department(
	deptno NUMBER PRIMARY KEY,
	dname varchar2(400),
	dcnt NUMBER
);
DELETE FROM DEPARTMENT;
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
	deptno NUMBER CONSTRAINT output_deptno_fk REFERENCES department(deptno) ON DELETE CASCADE,
	evaluation NUMBER
);
ALTER TABLE output ADD evaluation number;

CREATE SEQUENCE seq_output START WITH 10005;

CREATE TABLE favorite (
	favoritekey NUMBER PRIMARY KEY,
	menubar varchar2(400),
	status number
);

DROP TABLE team;
CREATE TABLE team(
	teamkey NUMBER PRIMARY KEY,
	teamname varchar2(400),
	projectkey	NUMBER CONSTRAINT team_projectkey_fk REFERENCES project(projectkey) ON DELETE CASCADE
);
CREATE SEQUENCE seq_team;


CREATE TABLE team_member(
	team_member_key NUMBER PRIMARY KEY,
	teamkey	NUMBER CONSTRAINT team_member_teamkey_fk REFERENCES team(teamkey) ON DELETE CASCADE,
	memberkey	NUMBER CONSTRAINT team_member_memberkey_fk REFERENCES member(memberkey) ON DELETE CASCADE
);
CREATE SEQUENCE seq_team_member;
drop SEQUENCE seq_team_member;


	

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
INSERT INTO fileinfo values(seq_fileInfo.nextval,'1','1',sysdate,sysdate,'1');
DROP SEQUENCE seq_fileInfo;
CREATE SEQUENCE seq_fileInfo;
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

---------------------------------------------------------------------------


CREATE TABLE warning (
	warningkey NUMBER,
	WRITEdate DATE,
	memberkey NUMBER CONSTRAINT warning_memberkey_fk REFERENCES member(memberkey) ON DELETE CASCADE
);
CREATE SEQUENCE seq_warning;



------------------------------------------------------------------------------



CREATE SEQUENCE seq_attendance;
INSERT into attendance VALUES (seq_attendance.nextval, 1, 1);
DELETE FROM ATTENDANCE WHERE score=1;
		select m.*, a.score
		from member m, attendance a
		where m.memberkey = a.memberkey;


INSERT into FAVORITE VALUES (seq_FAVORITE.nextval, '일정 전체 조회', 1);
CREATE SEQUENCE seq_FAVORITE;



CREATE TABLE workSort(
	workSortKey NUMBER PRIMARY KEY,
	title varchar2(400)
);



CREATE TABLE menubar(
	menubarkey NUMBER PRIMARY KEY,
	title varchar2(400)
);





---------------------------

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
CREATE SEQUENCE cal_seq START WITH 20000;



--------------------------------------------------------------------
--------------------------------------------------------------------









--------------------------------------------------------------------
--------------------------------------------------------------------
--------------------------------------------------------------------
DROP TABLE CustoChatRoom CASCADE CONSTRAINTS; 
CREATE TABLE CustoChatRoom(
	RoomKey NUMBER PRIMARY KEY,
	name varchar2(400)
	createdate DAte
);
ALTER TABLE CustoChatRoom ADD(createdate DAte); 
CREATE SEQUENCE seq_CustoChatRoom;
INSERT INTO custochatroom VALUES (seq_CustoChatRoom.nextval);
UPDATE custochatroom SET createdate = sysdate;

DROP TABLE custoChatMessage CASCADE CONSTRAINTS; 
CREATE TABLE custoChatMessage(
	messagekey NUMBER PRIMARY KEY,
	message varchar2(4000),
	writedate DATE,
	memberkey NUMBER CONSTRAINT custoChatMessage_memberkey_fk REFERENCES member(memberkey) ON DELETE CASCADE,
	RoomKey NUMBER CONSTRAINT custoChatMessage_RoomKey_fk REFERENCES CustoChatRoom(RoomKey) ON DELETE CASCADE,
	likecnt number
);

CREATE SEQUENCE seq_custoChatMessage START WITH 40000;
drop SEQUENCE seq_custoChatMessage; 

	
-- 방 입장
DROP TABLE custoChatRoomJoin CASCADE CONSTRAINTS; 
CREATE TABLE custoChatRoomJoin(
	roomjoinkey NUMBER PRIMARY KEY,
	memberkey NUMBER CONSTRAINT custoChatRoomJoin_memberkey_fk REFERENCES member(memberkey) ON DELETE CASCADE,
	RoomKey NUMBER CONSTRAINT custoChatRoomJoin_RoomKey_fk REFERENCES CustoChatRoom(RoomKey) ON DELETE CASCADE
);
INSERT INTO custoChatRoomJoin VALUES (seq_custoChatRoomJoin.nextval, 1, 1);
CREATE SEQUENCE seq_custoChatRoomJoin;
---------------------------------------------------------------------
---------------------------------------------------------------------
CREATE TABLE chatBot(
	chatbotkey NUMBER,
	inputdata varchar2(400),
	contents varchar2(4000)
);



------------------------------------------------------------------------
DROP TABLE vacation;
CREATE TABLE vacation(
	vacationkey NUMBER PRIMARY KEY,
	memberkey NUMBER CONSTRAINT vacation_memberkey_fk REFERENCES MEMBER(memberkey) ON DELETE CASCADE,
	projectkey NUMBER CONSTRAINT vacation_project_fk REFERENCES project(projectkey) ON DELETE CASCADE,
	title varchar2(400),
	startdate DATE,
	duration NUMBER,
	contents varchar2(4000)
);
CREATE SEQUENCE seq_vacation START WITH 60001; 
drop SEQUENCE seq_vacation;



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
DELETE FROM kanban;
CREATE SEQUENCE seq_kanban;
COMMIT;



	
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
	writedate DATE,
	title varchar2(400),
	contents varchar2(400)
);
CREATE sequence seq_quality;
INSERT INTO QUALITY VALUES (1, 1, 1, 'ㅁㄹ', sysdate, '11231');

SELECT * FROM MEMBER;





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
	status NUMBER,
	pricing NUMBER,
	visitcnt NUMBER
);
ALTER TABLE member ADD status NUMBER;
ALTER TABLE member ADD pricing NUMBER;
ALTER TABLE member ADD visitcnt NUMBER;
UPDATE MEMBER SET pricing =1 	 WHERE memberkey=2;
SELECT * FROM MEMBER WHERE memberkey=2;
SELECT * FROM MEMBER ORDER BY memberkey;
SELECT seq_member.nextval FROM dual;
		insert into MEMBER   (memberkey, name, email) values
		(seq_member.nextval, 'gg', 'gg@gmail.com');
CREATE profile(
	profile NUMBER PRIMARY KEY, 
	memberkey	NUMBER CONSTRAINT profile_memberkey_fk REFERENCES member(memberkey) ON DELETE CASCADE,
	pricing NUMBER,
	ACCESS NUMBER,
	
)


SELECT * FROM member_project;
SELECT * FROM MEMBER;  -- 
SELECT * FROM project; -- 1~7 






	SELECT
		m.memberkey, m.id, m.pass, m.email, auth.auth
		FROM
		member m LEFT OUTER JOIN auth auth on m.memberkey = auth.memberkey
		WHERE m.id ='himan';

		
	SELECT * from MEMBER ORDER BY memberkey;
UPDATE MEMBER SET auth = 'ROLE_USER' WHERE memberkey BETWEEN 221 AND 300;

INSERT INTO AUTH VALUS VALUES (1, 'ROLE_MEMBER');
CREATE SEQUENCE seq_auth;
SELECT SEQ_AUTH.NEXTVAL FROM DUAL;
	UPDATE 
	
CREATE TABLE auth(
	memberkey NUMBER CONSTRAINT auth_memberkey_fk REFERENCES member(memberkey) ON DELETE CASCADE,
	auth varchar2(400)
);
select * FROM auth;



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
	deptno NUMBER CONSTRAINT output_deptno_fk REFERENCES department(deptno) ON DELETE CASCADE,
	evaluation NUMBER
);
ALTER TABLE output ADD evaluation number;

drop SEQUENCE seq_output;
CREATE SEQUENCE seq_output START WITH 10005;
SELECT seq_output.nextval FROM dual;
INSERT INTO OUTPUT VALUES (seq_output.nextval, '제출합니다', '제출합니다.',
1.2,'진행중',sysdate
,12,1,2,1);

SELECT IMPORTANCE, count(*) count
		FROM risk
		GROUP BY
		IMPORTANCE;
	
	SELECT * FROM project;
	SELECT * FROM COSTDETAIL;
UPDATE COSTDETAIL SET costex = 130000000 WHERE NO=1 AND costex=8000000;
	
SELECT * FROM MEMBER;

CREATE TABLE favorite (
	favoritekey NUMBER PRIMARY KEY,
	menubar varchar2(400),
	status number
);
INSERT INTO favorite VALUES (1, '전체일정조회', 1);
INSERT INTO favorite VALUES (2, 'ㄴ', 1);
INSERT INTO favorite VALUES (3, 'ㅁ, 1);
INSERT INTO favorite VALUES (4, 'ㄷ, 1);
INSERT INTO favorite VALUES (5, 'ㄱ', 1);
INSERT INTO favorite VALUES (6, 'ㅎ', 1);


SELECT * FROM COSTDETAIL c ;
SELECT * FROM fileInfo order BY fno;
SELECT * FROM OUTPUT;
SELECT * FROM board3;

SELECT worksortkey, count(worksortkey) count
		FROM OUTPUT
		WHERE memberkey=2
		GROUP BY worksortkey
		ORDER BY
		WORKSORTKEY;

SELECT * FROM QUALITY q 


SELECT o.*
FROM OUTPUT o, MEMBER m;

select o.*, m.name mname, w.title worksortTitle, p.name pname, d.dname
FROM OUTPUT o, member m, workSort w, project p, DEPARTMENT d
		where o.memberkey = m.memberkey
		and o.worksortkey = w.worksortkey
		and o.projectkey = p.projectkey
		and o.deptno = d.deptno;



DROP TABLE team;
CREATE TABLE team(
	teamkey NUMBER PRIMARY KEY,
	teamname varchar2(400),
	projectkey	NUMBER CONSTRAINT team_projectkey_fk REFERENCES project(projectkey) ON DELETE CASCADE
);
CREATE SEQUENCE seq_team;
drop SEQUENCE seq_team;
COMMIT;
	SELECT count(*) count FROM team WHERE projectkey=1;
		

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



CREATE TABLE team_member







	

-- 외래키 없이 파일 정보 저장
create TABLE fileInfo(
	fno NUMBER PRIMARY KEY,
	pathInfo	varchar2(400),
	fname		varchar2(400),
	regdte	DATE,
	uptdte	DATE,
	etc	varchar2(400)
);

CREATE SEQUENCE seq_fileInfo;
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


SELECT * FROM DEPARTMENT d;

DROP TABLE member_project;
CREATE TABLE member_project(
	member_project_key NUMBER,
	memberkey NUMBER CONSTRAINT member_project_memberkey_fk REFERENCES member(memberkey) ON DELETE CASCADE,
	projectkey NUMBER CONSTRAINT member_project_project_fk REFERENCES project(projectkey) ON DELETE CASCADE
)





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


SELECT * FROM MEMBER ORDER BY memberkey;

SELECT * FROM project ORDER BY PROJECTKEY;
select * from project  where projectkey=1 order by projectkey;


SELECT * FROM MEMBER ORDER BY memberkey;
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


SELECT * FROM project;


---------------------------------------------------------------------------
DROP TABLE hashtag;
CREATE TABLE hashtag(
	hashtagkey NUMBER PRIMARY KEY,
	title varchar2(400)
)

INSERT INTO hashtag VALUES (1, 'excel');
INSERT INTO hashtag VALUES (2, 'pdf');
INSERT INTO hashtag VALUES (3, 'png');
INSERT INTO hashtag VALUES (4, 'jpg');
INSERT INTO hashtag VALUES (5, 'pptx');


SELECT 
    TO_CHAR(writedate, 'yyyy-mm-dd') writedate,
      avg(evaluation) evaluation
FROM output
WHERE to_char(writedate, 'yyyymmdd') 
BETWEEN TO_CHAR(ADD_MONTHS(LAST_DAY(SYSDATE)+1,-1),'YYYYMMDD')
AND  TO_CHAR(LAST_DAY(SYSDATE),'YYYYMMDD')
GROUP BY TO_CHAR(writedate, 'yyyy-mm-dd')
ORDER BY writedate;

SELECT seq_CustoChatRoom.currval FROM dual;
SELECT * FROM custochatroom;
		INSERT INTO custochatroom VALUES
		(seq_CustoChatRoom.nextval, '새상담'||seq_CustoChatRoom.nextval, sysdate);
	
	SELECT last_number FROM seq_CustoChatRoom WHERE ;
	DELETE custochat
SELECT * FROM CUSTOCHATROOM ORDER BY roomkey;
	SELECT roomkey, name, to_char(createdate,'YYYY/MM/DD hh mm dd')
		createDateS
		FROM custochatroom ORDER BY Createdate;
	update custoChatroom
	SET name = name plus '아아'
	where roomkey = 1;

	update custoChatroom
	set name= name||'dkdk'
	where roomkey = 1;
	SELECT max(roomkey) max
		FROM CUSTOCHATROOM c
		
		SELECT * FROM CUSTOCHATROOM c ;
	SELECT * FROM CUSTOCHATROOMJOIN c ;
			update custoChatroom
	set name= name||'gg'
	where roomkey = 46;

	

SELECT * FROM CUSTOCHATMESSAGE c;
DELETE custoChatMessage WHERE roomkey=1;



	INSERT INTO custoChatMessage VALUES
		(seq_custoChatMessage.nextval,3, sysdate, 1,2,0);

	SELECT * FROM custoChatMessage
		ORDER BY messagekey;


	SELECT o.MEMBERKEY  FROM OUTPUT o WHERE o.memberkey=1
	UNION SELECT n.NOTICEKEY , n.CONTENT FROM notice n WHERE n.MEMBERKEY=2;
	OR n.MEMBERKEY =1;

SELECT * FROM attendance;

SELECT * FROM MEMBER_PROJECT mp WHERE projectkey=1;

CREATE TABLE warning (
	warningkey NUMBER,
	WRITEdate DATE,
	memberkey NUMBER CONSTRAINT warning_memberkey_fk REFERENCES member(memberkey) ON DELETE CASCADE
);
CREATE SEQUENCE seq_warning;

SELECT * FROM warning;
INSERT INTO warning VALUES (seq_warning.nextval, sysdate, 1);

SELECT * FROM MEMBER;

	UPDATE MEMBER
		SET
		id='qq',
		pass='qq'
		WHERE memberkey=6;
SELECT * FROM MEMBER order BY memberkey;

INSERT INTO output VALUES (seq_output.nextval, '제출합니다','제출합니다',1.3,1,sysdate+7,6,1,1,1,1);
SELECT * FROM OUTPUT;

SELECT * FROM PROCUREMENT p;
INSERT INTO PROCUREMENT VALUES (1, '조달요구서제출합니다', sysdate,  '조달요구서제출합니다',
 '조달요구서제출합니다',  '조달요구서제출합니다', '조달요구서제출합니다', '조달요구서제출합니다',
  '조달요구서제출합니다', '조달요구서제출합니다','조달요구서제출합니다',1);
DELETE FROM PROCUREMENT; 

SELECT * FROM VACAT

COMMIT;

SELECT max(roomkey)
FROM CUSTOCHATROOM c ;

SELECT * FROM project;

UPDATE OUTPUT
SET EVALUATION =5
WHERE TO_CHAR(WRITEdate,'yyyymmdd') = '20220325' 

SELECT * FROM MEMBER ORDER BY MEMBERkey;

SELECT * FROM CUSTOCHATROOMJOIN;
CREATE SEQUENCE seq_CUSTOCHATROOMJOIN;
INSERT INTO CUSTOCHATROOMJOIN VALUES (seq_CUSTOCHATROOMJOIN.nextval, 1,2);


CREATE SEQUENCE seq_hashtag2;
INSERT INTO ;

SELECT to_char(writedate, 'yyyy-mm-dd')
FROM OUTPUT
GROUP BY WRITEdate;

SELECT avg(EVALUATION), to_char(writedate,'yyyy-mm-dd') 
FROM OUTPUT;

FROM (SELECT evaluation, to_char(writedate, 'yyyy-mm-dd') FROM OUTPUT)
GROUP BY writedate;

------------------------------------------------------------------------------

UPDATE MEMBER
SET status = 0;

SELECT * FROM MEMBER ORDER BY memberkey;

	update member
		set status = 2
		where memberkey BETWEEN 1 AND 10;
		
		IN
	SELECT seq_memberregi.nextval FROM dual);



SELECT seq_memberregi.nextVAL FROM dual;
		SELECT seq_memberregi.currval
		FROM dual;

SELECT id
from MEMBER
WHERE name='김민수'
AND email='gildong1@gmail.com';

UPDATE MEMBER
SET 
pass = 'newissuedpassword'||seq_memberpass.nextval
WHERE memberkey=99;

SELECT 'newissuedpassword'||seq_memberpass.nextval FROM dual;

SELECT * FROM Attendance;
CREATE SEQUENCE seq_attendance;
INSERT into attendance VALUES (seq_attendance.nextval, 1, 1);
DELETE FROM ATTENDANCE WHERE score=1;
		select m.*, a.score
		from member m, attendance a
		where m.memberkey = a.memberkey;


SELECT * FROM FAVORITE f ;
INSERT into FAVORITE VALUES (seq_FAVORITE.nextval, '일정 전체 조회', 1);
CREATE SEQUENCE seq_FAVORITE;


delete ]FROM FAVORITE f;
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



CREATE TABLE menubar(
	menubarkey NUMBER PRIMARY KEY,
	title varchar2(400)
);

INSERT INTO menubar VALUES (1,'일정 전체 조회');
INSERT INTO menubar VALUES (2,'진행 중인 칸반');
INSERT INTO menubar VALUES (3,'진행 중인 간트');
INSERT INTO menubar VALUES (4,'마감 7일전 업무');
INSERT INTO menubar VALUES (5,'마감 3일전 업무');
INSERT INTO menubar VALUES (6,'마감 1일전 업무');
INSERT INTO menubar VALUES (7,'중요');
INSERT INTO menubar VALUES (8,'완료된 업무');
INSERT INTO menubar VALUES (9,'파일함');
INSERT INTO menubar VALUES (10,'이미지 모아 보기');
INSERT INTO menubar VALUES (11,'내 글에 달리 댓글');
SELECT * FROM menubar ORDER BY menubarkey;
SELECT * FROM FAVORITE f;





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



--------------------------------------------------------------------
--------------------------------------------------------------------









--------------------------------------------------------------------
--------------------------------------------------------------------
--------------------------------------------------------------------
DROP TABLE CustoChatRoom CASCADE CONSTRAINTS; 
CREATE TABLE CustoChatRoom(
	RoomKey NUMBER PRIMARY KEY,
	name varchar2(400)
	createdate DAte
);
ALTER TABLE CustoChatRoom ADD(createdate DAte); 
CREATE SEQUENCE seq_CustoChatRoom;
INSERT INTO custochatroom VALUES (seq_CustoChatRoom.nextval);
SELECT roomkey, name, to_char(createdate,'YYYY/MM/DD') createdateS FROM custochatroom ORDER BY createdate;
UPDATE custochatroom SET createdate = sysdate;

DROP TABLE custoChatMessage CASCADE CONSTRAINTS; 
CREATE TABLE custoChatMessage(
	messagekey NUMBER PRIMARY KEY,
	message varchar2(4000),
	writedate DATE,
	memberkey NUMBER CONSTRAINT custoChatMessage_memberkey_fk REFERENCES member(memberkey) ON DELETE CASCADE,
	RoomKey NUMBER CONSTRAINT custoChatMessage_RoomKey_fk REFERENCES CustoChatRoom(RoomKey) ON DELETE CASCADE,
	likecnt number
);

SELECT * FROM custoChatMessage order BY messagekey;
UPDATE custoChatMessage SET likecnt = 0; 
	UPDATE custoChatMessage SET likecnt = likecnt+1 where messagekey =1;
CREATE SEQUENCE seq_custoChatMessage START WITH 40000;
drop SEQUENCE seq_custoChatMessage; 

INSERT INTO custoChatMessage VALUES (seq_custoChatMessage.nextval, '안녕하세요?', sysdate, 1, 2);
INSERT INTO custoChatMessage VALUES (seq_custoChatMessage.nextval, '무엇을 도와드릴까요', sysdate, 2, 2);
SELECT * FROM custoChatMessage WHERE roomkey=1 ORDER BY messagekey;
	INSERT INTO custochatroom VALUES (seq_CustoChatRoom.nextval, '새상담'||seq_CustoChatRoom.nextval);
SELECT * FROM custochatroom;

	SELECT * FROM custoChatMessage WHERE roomkey=1
		ORDER BY messagekey;

		SELECT * FROM custoChatMessage
		ORDER BY messagekey;
	
	SELECT * FROM MEMBER order BY memberkey;
-- 방 입장
DROP TABLE custoChatRoomJoin CASCADE CONSTRAINTS; 
CREATE TABLE custoChatRoomJoin(
	roomjoinkey NUMBER PRIMARY KEY,
	memberkey NUMBER CONSTRAINT custoChatRoomJoin_memberkey_fk REFERENCES member(memberkey) ON DELETE CASCADE,
	RoomKey NUMBER CONSTRAINT custoChatRoomJoin_RoomKey_fk REFERENCES CustoChatRoom(RoomKey) ON DELETE CASCADE
);
SELECT roomjoinkey FROM custoChatRoomJoin WHERE roomkey=1 AND memberkey=1;
INSERT INTO custoChatRoomJoin VALUES (seq_custoChatRoomJoin.nextval, 1, 1);
CREATE SEQUENCE seq_custoChatRoomJoin;
---------------------------------------------------------------------
---------------------------------------------------------------------
CREATE TABLE chatBot(
	chatbotkey NUMBER,
	inputdata varchar2(400),
	contents varchar2(4000)
);
INSERT INTO chatbot VALUES (1, '그래디언트', '그래디언트는 여러분의 프로젝트 진행을 돕는 플랫폼입니다. 효율적인 작업 환경을 마련하였으니 잘 사용하시길 바랍니다.');
INSERT INTO chatbot VALUES (2, '회원탈퇴', '회원탈퇴는 마이페이지에서 탈퇴 버튼을 누르면 됩니다.');        
INSERT INTO chatbot VALUES (3, '파일첨부','파일 첨부는 게시판에 들어가 파일 선택을 누르면 됩니다.');                   
SELECT * FROM chatbot WHERE inputdata = '그래디언트';
SELECT * FROM chatbot;
---------------------------------------------------------------------
------------------------------------   ---------------------------------
COMMIT;
SELECT * FROM MEMBER ORDER BY MEMBERKEY;
SELECT * FROM chatting;
---------------------------------------------------------------------
---------------------------------------------------------------------
		SELECT m.name name, m.auth auth, m.email email, d.dname dname, d.deptno deptno
		FROM MEMBER m, DEPARTMENT d
		WHERE m.deptno =d.deptno;
---------------------------------------------------------------------
---------------------------------------------------------------------

---------------------------------------------------------------------




1. 부서번호 수정
UPDATE MEMBER
SET
deptno = 1
WHERE memberkey = 2;

2. 프로젝트에 팀 배정
INSERT INTO team VALUES (seq_team.nextval, '기획', 1);

3. 팀에 회원 배정;
INSERT INTO team_member VALUES (seq_team_member.nextval, 1, 2);



------------------------------------------------------------------------
CREATE TABLE vacation(
	vacationkey NUMBER PRIMARY KEY,
	memberkey NUMBER CONSTRAINT vacation_memberkey_fk REFERENCES MEMBER(memberkey) ON DELETE CASCADE,
	projectkey NUMBER CONSTRAINT vacation_project_fk REFERENCES project(projectkey) ON DELETE CASCADE,
	title varchar2(400),
	startdate DATE,
	duration NUMBER,
	applydate DATE
);
CREATE SEQUENCE seq_vacation;
INSERT INTO vacation VALUES (seq_vacation.nextval, 1, 1, '정기휴가7', '2022/3/26', 0, sysdate);

SELECT * FROM team_member;

SELECT * FROM OUTPUT;


INSERT INTO OUTPUT VALUES (seq_output.nextval, '제출합니다', '제출합니다.', 1.2,'진행중',to_date('20220326','YYYY/MM/DD'),
11,1,2,1);


--하루하루 작업량
		SELECT WRITEdate, count(*) FROM OUTPUT WHERE
		to_char(writedate,'yymmdd') IN ('220326') GROUP BY writedate;

		
SELECT to_char(writedate,'yyyymmdd') WRITEdate, count(*) count FROM OUTPUT WHERE
projectkey=1 and
		to_char(writedate,'yymmdd') IN		
		(SELECT DISTINCT A.DD
FROM (
   SELECT TO_CHAR( TO_DATE( '220101','yymmdd') - 1 + LEVEL, 'YYMMdd' ) AS DD
   FROM DUAL
   CONNECT BY LEVEL <= TO_DATE( '230101','yymmdd' ) - TO_DATE( '220101','yymmdd') + 1
  ) A) GROUP BY to_char(writedate,'yyyymmdd') ORDER BY WRITEDATE;
		
		
 
 SELECT deptno, count(deptno) FROM emp WHERE empno>1000 GROUP BY deptno;
 
		(SELECT to_char(STARTDATE+1,'YYYY/MM/DD') FROM project WHERE projectkey=1);
	

SELECT DISTINCT A.DD
FROM (
   SELECT TO_CHAR( TO_DATE( '220101','yymmdd') - 1 + LEVEL, 'YYMMdd' ) AS DD
   FROM DUAL
   CONNECT BY LEVEL <= TO_DATE( '230101','yymmdd' ) - TO_DATE( '220101','yymmdd') + 1
  ) A




SELECT DISTINCT A.DD
FROM (
   SELECT TO_CHAR( TO_DATE( '220101','yyyymm') - 1 + LEVEL, 'YYYYMM' ) AS DD
   FROM DUAL
   CONNECT BY LEVEL <= TO_DATE( '231001','yyyymm' ) - TO_DATE( '220101','yyyymm') + 1
  ) A




  
SELECT * FROM FILEInfo WHERE fno IN (
SELECT OUTPUTKEY FROM OUTPUT WHERE memberkey =2);





SELECT *
FROM project p, MEMBER m, team t
WHERE p.PROJECTKEY = t.PROJECTKEY ;


SELECT * FROM team; -- 프로젝트에 할당된 팀 찾기
SELECT * FROM team_member; -- 팀에 배정된 회원 찾기
DELETE FROM team_member;
INSERT INTO team_member VALUES (seq_team_member.nextval,47,48);

SELECT count(*) FROM team_member WHERE teamkey IN(
SELECT teamkey FROM team WHERE projectkey=1); // 프로젝트 할당된 인원

SELECT * FROM vacation;


// 오늘이 껴있는 일 개수
SELECT count(*) FROM vacation WHERE TO_CHAR(SYSDATE, 'YYYY/MM/dd') <= to_char(startdate+duration,'YYYY/MM/DD');

AND TO_CHAR(SYSDATE, 'YYYY/MM/dd') >= to_char(TO_DATE(SUBSTR(start1,0, 10), 'YYYY-MM-DD'),'YYYY/MM/DD');

SELECT count(*) FROM vacation WHERE TO_CHAR(SYSDATE, 'YYYY/MM/dd') <= TO_CHAR(startdate+duration, 'YYYY/MM/DD')
AND TO_CHAR(SYSDATE, 'YYYY/MM/dd') >= TO_CHAR(startdate, 'YYYY/MM/dd') AND projectkey=1;







INSERT INTO vacation VALUES (seq_vacation.nextval, 1, 1, '정기', sysdate-4, 4, sysdate); 



	SELECT count(*) FROM vacation WHERE TO_CHAR(SYSDATE-1, 'YYYY/MM/dd') <=
		TO_CHAR(startdate+duration, 'YYYY/MM/DD')
		AND TO_CHAR(SYSDATE,
		'YYYY/MM/dd') >=
		TO_CHAR(startdate, 'YYYY/MM/dd')
		AND projectkey=1;


SELECT * FROM chattingroom;
DROP TABLE chattingroom CASCADE CONSTRAINTS;
CREATE SEQUENCE seq_chattingroom;
DROP TABLE chattingroom;
CREATE TABLE chattingroom(
	roomkey NUMBER PRIMARY KEY,
	name varchar2(4000),
	makedate DATE
);


COMMIT;


DROP TABLE chattingMessage;
CREATE TABLE chattingMessage(
	messagekey NUMBER PRIMARY KEY,
	contents varchar2(4000),
	WRITEdate DATE,
	roomkey NUMBER CONSTRAINT chattingMessage_roomkey_fk REFERENCES chattingroom(roomkey) ON DELETE CASCADE,
	memberkey NUMBER CONSTRAINT chattingMessage_memberkey_fk REFERENCES MEMBER(memberkey) ON DELETE CASCADE,
	likecnt number
);




CREATE SEQUENCE seq_chat_memroom_join;
CREATE TABLE chat_memroom_join(
chat_memroom_join_key NUMBER PRIMARY KEY,
	roomkey NUMBER CONSTRAINT chat_memroom_join_roomkey_fk REFERENCES chattingroom(roomkey) ON DELETE CASCADE,
	memberkey NUMBER CONSTRAINT chat_memroom_join_memberkey_fk REFERENCES MEMBER(memberkey) ON DELETE CASCADE
);







CREATE TABLE procusituation(
	procusituationKey NUMBER PRIMARY KEY,
	title varchar2(400),
	contents varchar2(4000),
	writedate DATE,
	memberkey NUMBER CONSTRAINT procusituation_memberkey_fk REFERENCES MEMBER(memberkey) ON DELETE CASCADE,
	projectkey NUMBER CONSTRAINT procusituation_project_fk REFERENCES project(projectkey) ON DELETE CASCADE,
	plandate DATE
);
CREATE SEQUENCE seq_procusituation;

create table users(
	username varchar2(50) not null primary key,
	password varchar2(100) not null,
	enabled number(1) not null
);

DROP TABLE authorities CASCADE CONSTRAINTS;
create table authorities (
	username varchar2(50) not null,
	authority varchar2(50) not null
);



