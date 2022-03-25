package project5.vote;

import java.util.Date;

public class VoteVO {
	private int votekey;
	private String title;
	private String contents;
	private Date writedate;
	private String writedateS;
	private Date enddate;
	private String enddateS;
	private String voteoption;
	private String item1;
	private String item2;
	private String item3;
	private String item4;
	private String item5;
	private int voteItem1;
	private int voteItem2;
	private int voteItem3;
	private int voteItem4;
	private int voteItem5;
	private int memberkey;
	private int projectkey;
	private String pname;
	private String mname;

	public VoteVO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public VoteVO(int votekey, String title, String contents, Date writedate, String writedateS, Date enddate,
			String enddateS, String voteoption, String item1, String item2, String item3, String item4, String item5,
			int memberkey, int projectkey) {
		super();
		this.votekey = votekey;
		this.title = title;
		this.contents = contents;
		this.writedate = writedate;
		this.writedateS = writedateS;
		this.enddate = enddate;
		this.enddateS = enddateS;
		this.voteoption = voteoption;
		this.item1 = item1;
		this.item2 = item2;
		this.item3 = item3;
		this.item4 = item4;
		this.item5 = item5;
		this.memberkey = memberkey;
		this.projectkey = projectkey;
	}

	public VoteVO(int votekey, String title, String contents, Date writedate, String writedateS, Date enddate,
			String enddateS, String voteoption, String item1, String item2, String item3, String item4, String item5,
			int voteItem1, int voteItem2, int voteItem3, int voteItem4, int voteItem5, int memberkey, int projectkey) {
		super();
		this.votekey = votekey;
		this.title = title;
		this.contents = contents;
		this.writedate = writedate;
		this.writedateS = writedateS;
		this.enddate = enddate;
		this.enddateS = enddateS;
		this.voteoption = voteoption;
		this.item1 = item1;
		this.item2 = item2;
		this.item3 = item3;
		this.item4 = item4;
		this.item5 = item5;
		this.voteItem1 = voteItem1;
		this.voteItem2 = voteItem2;
		this.voteItem3 = voteItem3;
		this.voteItem4 = voteItem4;
		this.voteItem5 = voteItem5;
		this.memberkey = memberkey;
		this.projectkey = projectkey;
	}

	public VoteVO(int votekey, String title, String contents, Date writedate, String writedateS, Date enddate,
			String enddateS, String voteoption, String item1, String item2, String item3, String item4, String item5,
			int voteItem1, int voteItem2, int voteItem3, int voteItem4, int voteItem5, int memberkey, int projectkey,
			String pname, String mname) {
		super();
		this.votekey = votekey;
		this.title = title;
		this.contents = contents;
		this.writedate = writedate;
		this.writedateS = writedateS;
		this.enddate = enddate;
		this.enddateS = enddateS;
		this.voteoption = voteoption;
		this.item1 = item1;
		this.item2 = item2;
		this.item3 = item3;
		this.item4 = item4;
		this.item5 = item5;
		this.voteItem1 = voteItem1;
		this.voteItem2 = voteItem2;
		this.voteItem3 = voteItem3;
		this.voteItem4 = voteItem4;
		this.voteItem5 = voteItem5;
		this.memberkey = memberkey;
		this.projectkey = projectkey;
		this.pname = pname;
		this.mname = mname;
	}

	public int getVotekey() {
		return votekey;
	}

	public void setVotekey(int votekey) {
		this.votekey = votekey;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContents() {
		return contents;
	}

	public void setContents(String contents) {
		this.contents = contents;
	}

	public Date getWritedate() {
		return writedate;
	}

	public void setWritedate(Date writedate) {
		this.writedate = writedate;
	}

	public String getWritedateS() {
		return writedateS;
	}

	public void setWritedateS(String writedateS) {
		this.writedateS = writedateS;
	}

	public Date getEnddate() {
		return enddate;
	}

	public void setEnddate(Date enddate) {
		this.enddate = enddate;
	}

	public String getEnddateS() {
		return enddateS;
	}

	public void setEnddateS(String enddateS) {
		this.enddateS = enddateS;
	}

	public String getVoteoption() {
		return voteoption;
	}

	public void setVoteoption(String voteoption) {
		this.voteoption = voteoption;
	}

	public String getItem1() {
		return item1;
	}

	public void setItem1(String item1) {
		this.item1 = item1;
	}

	public String getItem2() {
		return item2;
	}

	public void setItem2(String item2) {
		this.item2 = item2;
	}

	public String getItem3() {
		return item3;
	}

	public void setItem3(String item3) {
		this.item3 = item3;
	}

	public String getItem4() {
		return item4;
	}

	public void setItem4(String item4) {
		this.item4 = item4;
	}

	public String getItem5() {
		return item5;
	}

	public void setItem5(String item5) {
		this.item5 = item5;
	}

	public int getMemberkey() {
		return memberkey;
	}

	public void setMemberkey(int memberkey) {
		this.memberkey = memberkey;
	}

	public int getProjectkey() {
		return projectkey;
	}

	public void setProjectkey(int projectkey) {
		this.projectkey = projectkey;
	}

	public int getVoteItem1() {
		return voteItem1;
	}

	public void setVoteItem1(int voteItem1) {
		this.voteItem1 = voteItem1;
	}

	public int getVoteItem2() {
		return voteItem2;
	}

	public void setVoteItem2(int voteItem2) {
		this.voteItem2 = voteItem2;
	}

	public int getVoteItem3() {
		return voteItem3;
	}

	public void setVoteItem3(int voteItem3) {
		this.voteItem3 = voteItem3;
	}

	public int getVoteItem4() {
		return voteItem4;
	}

	public void setVoteItem4(int voteItem4) {
		this.voteItem4 = voteItem4;
	}

	public int getVoteItem5() {
		return voteItem5;
	}

	public void setVoteItem5(int voteItem5) {
		this.voteItem5 = voteItem5;
	}

	public String getPname() {
		return pname;
	}

	public void setPname(String pname) {
		this.pname = pname;
	}

	public String getMname() {
		return mname;
	}

	public void setMname(String mname) {
		this.mname = mname;
	}

}
