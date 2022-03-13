package project5.mail;

import java.util.List;

import project5.member.MemberVO;

public class Mail {
	private String reciever;
	private String sender;
	private String title;
	private String content;

	private List<MemberVO> recievers;

	public Mail() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Mail(String reciever, String sender, String title, String content, List<MemberVO> recievers) {
		super();
		this.reciever = reciever;
		this.sender = sender;
		this.title = title;
		this.content = content;
		this.recievers = recievers;
	}

	public String getReciever() {
		return reciever;
	}

	public void setReciever(String reciever) {
		this.reciever = reciever;
	}

	public String getSender() {
		return sender;
	}

	public void setSender(String sender) {
		this.sender = sender;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public List<MemberVO> getRecievers() {
		return recievers;
	}

	public void setRecievers(List<MemberVO> recievers) {
		this.recievers = recievers;
	}


}
