package project5.memo;

import java.util.Date;

import org.apache.ibatis.ognl.InappropriateExpressionException;

public class MemoVO {
	private int memokey;
	private String title;
	private String contents;
	private Date writedate;
	private String writedateS;
	private String importance;
	private int memberkey;
	private int cnt;
	
	
	
	public MemoVO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public MemoVO(int memokey, String title, String contents, Date writedate, String writedateS, String importance,
			int memberkey) {
		super();
		this.memokey = memokey;
		this.title = title;
		this.contents = contents;
		this.writedate = writedate;
		this.writedateS = writedateS;
		this.importance = importance;
		this.memberkey = memberkey;
	}

	
	
	
	
	
	public MemoVO(int memokey, String title, String contents, Date writedate, String writedateS, String importance,
			int memberkey, int cnt) {
		super();
		this.memokey = memokey;
		this.title = title;
		this.contents = contents;
		this.writedate = writedate;
		this.writedateS = writedateS;
		this.importance = importance;
		this.memberkey = memberkey;
		this.cnt = cnt;
	}

	public int getMemokey() {
		return memokey;
	}

	public void setMemokey(int memokey) {
		this.memokey = memokey;
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

	public String getImportance() {
		return importance;
	}

	public void setImportance(String importance) {
		this.importance = importance;
	}

	public int getMemberkey() {
		return memberkey;
	}

	public void setMemberkey(int memberkey) {
		this.memberkey = memberkey;
	}

	public int getCnt() {
		return cnt;
	}

	public void setCnt(int cnt) {
		this.cnt = cnt;
	}

	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
