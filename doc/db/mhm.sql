-- 부서
CREATE TABLE department(
	deptno NUMBER PRIMARY KEY,
	dname varchar2(400),
	dcnt NUMBER,
	CONSTRAINT fk_projectkey FOREIGN KEY(projectkey)
         REFERENCES project(projectkey) ON DELETE CASCADE
);
INSERT INTO department values(1, '기획', 5);
