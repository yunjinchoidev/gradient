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


--예산
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

