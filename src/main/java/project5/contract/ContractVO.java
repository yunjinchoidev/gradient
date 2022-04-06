package project5.contract;
// project5.contract.ContractVO
import java.util.Date;

/*
	contractKey NUMBER PRIMARY KEY,
	memberKey NUMBER NOT NULL,
	employerName varchar2(100),
	employeeName varchar2(100),
	termStart DATE,
	termEnd DATE,
	place varchar2(100),
	description varchar2(1000),
	whStart varchar2(100), --workingHoursStart
	whEnd varchar2(100), --workingHoursEnd사인
	phStart varchar2(100), --pecessHoursStart
	phEnd varchar2(100), --pecessHoursEnd
	holidays varchar2(1000), --checkbox
	basicPayUnit varchar2(50),
	basicPay NUMBER,
	bonus NUMBER,
	paymentDate NUMBER,
	paymentMethod varchar2(200),
	socialInsurance varchar2(200), --checkbox
	writeDate DATE,
	companyName varchar2(200),
	employerAddress varchar2(1000),
	employeeAddress varchar2(1000),
	employeeContact varchar2(100),
 */
public class ContractVO {
	private int contractKey;
	private int memberKey;
	private String employerName;
	private String employeeName;
	private Date termStart; 
	private Date termEnd; 
	private String place;
	private String description;
	private String whStart;
	private String whEnd;
	private String phStart;
	private String phEnd;
	private String holidays;
	private String basicPayUnit;
	private int basicPay;
	private int bonus;
	private int paymentDate;
	private String paymentMethod;
	private String socialInsurance;
	private Date writeDate;
	private String employerAddress;
	private String employeeAddress;
	private String employeeContact;
	public ContractVO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public int getContractKey() {
		return contractKey;
	}
	public void setContractKey(int contractKey) {
		this.contractKey = contractKey;
	}
	public int getMemberKey() {
		return memberKey;
	}
	public void setMemberKey(int memberKey) {
		this.memberKey = memberKey;
	}
	public String getEmployerName() {
		return employerName;
	}
	public void setEmployerName(String employerName) {
		this.employerName = employerName;
	}
	public String getEmployeeName() {
		return employeeName;
	}
	public void setEmployeeName(String employeeName) {
		this.employeeName = employeeName;
	}
	public Date getTermStart() {
		return termStart;
	}
	public void setTermStart(Date termStart) {
		this.termStart = termStart;
	}
	public Date getTermEnd() {
		return termEnd;
	}
	public void setTermEnd(Date termEnd) {
		this.termEnd = termEnd;
	}
	public String getPlace() {
		return place;
	}
	public void setPlace(String place) {
		this.place = place;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getWhStart() {
		return whStart;
	}
	public void setWhStart(String whStart) {
		this.whStart = whStart;
	}
	public String getWhEnd() {
		return whEnd;
	}
	public void setWhEnd(String whEnd) {
		this.whEnd = whEnd;
	}
	public String getPhStart() {
		return phStart;
	}
	public void setPhStart(String phStart) {
		this.phStart = phStart;
	}
	public String getPhEnd() {
		return phEnd;
	}
	public void setPhEnd(String phEnd) {
		this.phEnd = phEnd;
	}
	public String getHolidays() {
		return holidays;
	}
	public void setHolidays(String holidays) {
		this.holidays = holidays;
	}
	public String getBasicPayUnit() {
		return basicPayUnit;
	}
	public void setBasicPayUnit(String basicPayUnit) {
		this.basicPayUnit = basicPayUnit;
	}
	public int getBasicPay() {
		return basicPay;
	}
	public void setBasicPay(int basicPay) {
		this.basicPay = basicPay;
	}
	public int getBonus() {
		return bonus;
	}
	public void setBonus(int bonus) {
		this.bonus = bonus;
	}
	public int getPaymentDate() {
		return paymentDate;
	}
	public void setPaymentDate(int paymentDate) {
		this.paymentDate = paymentDate;
	}
	public String getPaymentMethod() {
		return paymentMethod;
	}
	public void setPaymentMethod(String paymentMethod) {
		this.paymentMethod = paymentMethod;
	}
	public String getSocialInsurance() {
		return socialInsurance;
	}
	public void setSocialInsurance(String socialInsurance) {
		this.socialInsurance = socialInsurance;
	}
	public Date getWriteDate() {
		return writeDate;
	}
	public void setWriteDate(Date writeDate) {
		this.writeDate = writeDate;
	}
	public String getEmployerAddress() {
		return employerAddress;
	}
	public void setEmployerAddress(String employerAddress) {
		this.employerAddress = employerAddress;
	}
	public String getEmployeeAddress() {
		return employeeAddress;
	}
	public void setEmployeeAddress(String employeeAddress) {
		this.employeeAddress = employeeAddress;
	}
	public String getEmployeeContact() {
		return employeeContact;
	}
	public void setEmployeeContact(String employeeContact) {
		this.employeeContact = employeeContact;
	}
	public ContractVO(int contractKey, int memberKey, String employerName, String employeeName, Date termStart,
			Date termEnd, String place, String description, String whStart, String whEnd, String phStart, String phEnd,
			String holidays, String basicPayUnit, int basicPay, int bonus, int paymentDate, String paymentMethod,
			String socialInsurance, Date writeDate, String employerAddress, String employeeAddress,
			String employeeContact) {
		super();
		this.contractKey = contractKey;
		this.memberKey = memberKey;
		this.employerName = employerName;
		this.employeeName = employeeName;
		this.termStart = termStart;
		this.termEnd = termEnd;
		this.place = place;
		this.description = description;
		this.whStart = whStart;
		this.whEnd = whEnd;
		this.phStart = phStart;
		this.phEnd = phEnd;
		this.holidays = holidays;
		this.basicPayUnit = basicPayUnit;
		this.basicPay = basicPay;
		this.bonus = bonus;
		this.paymentDate = paymentDate;
		this.paymentMethod = paymentMethod;
		this.socialInsurance = socialInsurance;
		this.writeDate = writeDate;
		this.employerAddress = employerAddress;
		this.employeeAddress = employeeAddress;
		this.employeeContact = employeeContact;
	}
	
	

}
