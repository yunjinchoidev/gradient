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


