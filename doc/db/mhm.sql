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



