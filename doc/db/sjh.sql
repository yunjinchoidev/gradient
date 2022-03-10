CREATE TABLE quality(
	qualitykey	NUMBER PRIMARY KEY,
	projectkey NUMBER CONSTRAINT quality_projectkey_fk REFERENCES project(projectkey) ON DELETE CASCADE,
	memberkey NUMBER CONSTRAINT quality_memberkey_fk REFERENCES member(memberkey) ON DELETE CASCADE,
	qualityManagement	varchar2(400),
	qualityEvaluation	varchar2(400)
)