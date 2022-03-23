-- 부서
CREATE TABLE department(
	deptno NUMBER PRIMARY KEY,
	dname varchar2(400),
	dcnt NUMBER,
	CONSTRAINT fk_projectkey FOREIGN KEY(projectkey)
         REFERENCES project(projectkey) ON DELETE CASCADE
);
INSERT INTO department values(1, '기획', 5);



DROP TABLE member_project;
CREATE TABLE member_project(
	member_project_key NUMBER,
	memberkey NUMBER CONSTRAINT member_project_memberkey_fk REFERENCES member(memberkey) ON DELETE CASCADE,
	projectkey NUMBER CONSTRAINT member_project_project_fk REFERENCES project(projectkey) ON DELETE CASCADE
)



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





