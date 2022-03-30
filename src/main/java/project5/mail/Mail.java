package project5.mail;

import java.util.List;

import project5.member.MemberVO;

public class Mail {
	private String reciever;
	private String sender;
	private String title;
	private String content;

	private List<MemberVO> recievers;

	private List<String> recivers;
	private List<Mail> mails;

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

	public Mail(String reciever, String sender, String title, String content, List<MemberVO> recievers,
			List<String> recivers, List<Mail> mails) {
		super();
		this.reciever = reciever;
		this.sender = sender;
		this.title = title;
		this.content = content;
		this.recievers = recievers;
		this.recivers = recivers;
		this.mails = mails;
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

	public List<String> getRecivers() {
		return recivers;
	}

	public void setRecivers(List<String> recivers) {
		this.recivers = recivers;
	}

	public List<Mail> getMails() {
		return mails;
	}

	public void setMails(List<Mail> mails) {
		this.mails = mails;
	}

}
