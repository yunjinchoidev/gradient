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
