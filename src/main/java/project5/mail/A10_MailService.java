package project5.mail;

import java.util.List;

import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import project5.member.MemberDao;
import project5.member.MemberService;


@Service
public class A10_MailService {
	// 컨테이너에 있는  객체 호출.
	@Autowired
	private JavaMailSender sender;	
	
	
	@Autowired
	private MemberService service;
	
	
	
	
	// 내 마음대로 메일 발송하기
	public String sendMail(Mail email) {
		String msg = "메일 발송 성공";
		MimeMessage mmsg = sender.createMimeMessage();
		try {
			mmsg.setSubject(email.getTitle());
			mmsg.setRecipient(RecipientType.TO, new InternetAddress(email.getReciever()));
			mmsg.setText(email.getContent());
			sender.send(mmsg);
		} catch (MessagingException e) {
			msg="메일 발송 에러:"+e.getMessage();
			System.out.println(msg);
		} catch (Exception e) {
			msg = "일반 에러 발생:"+e.getMessage();
		}
		return msg;
	}
	

	// 내 마음대로 메일 발송하기
	public String sendArrays(List<String> reciever,Mail email ) {
		String msg = "메일 발송 성공";
		MimeMessage mmsg = sender.createMimeMessage();
		try {
			for(int i=0; i<reciever.size(); i++) {
				
					mmsg.setSubject(email.getTitle());
					mmsg.setRecipient(RecipientType.TO, new InternetAddress(reciever.get(i)));
					mmsg.setText(email.getContent());
					sender.send(mmsg);
			}
		} catch (MessagingException e) {
			msg="메일 발송 에러:"+e.getMessage();
			System.out.println(msg);
		} catch (Exception e) {
			msg = "일반 에러 발생:"+e.getMessage();
		}
		return msg;
	}
	
	
	
	
	
	// 임시 아이디/비밀번호 발급해주는 것
	public String sendidpassMail(int memberkey, String reciever) {
		String msg = "메일 발송 성공";
		MimeMessage mmsg = sender.createMimeMessage();
		try {
			mmsg.setSubject("Gradient 가입을 대단히 환영합니다");
			mmsg.setRecipient(RecipientType.TO, new InternetAddress(reciever));
			String infomation="안녕하세요? \n\n Gradient 가입을 환영합니다. \n\n\n 임시 아이디는 "
			+service.get(memberkey).getId() +"이고 "+
			"\n임시 비밀번호는 "+service.get(memberkey).getPass() +"입니다. \n \n 즐거운 하루 되십시오.";
			mmsg.setText(infomation);
			sender.send(mmsg);
			System.out.println("이메일 발송되었습니다.");
			System.out.println("수신자"+reciever);
		} catch (MessagingException e) {
			// TODO Auto-generated catch block
			msg="메일 발송 에러:"+e.getMessage();
			System.out.println(msg);
		} catch (Exception e) {
			msg = "일반 에러 발생:"+e.getMessage();
		}
		return msg;
	}
	
	// 비밀번호만 새로 발급
	public String sendpassIssueMail(int memberkey, String reciever) {
		String msg = "메일 발송 성공";
		MimeMessage mmsg = sender.createMimeMessage();
		try {
			mmsg.setSubject("비밀번호가 새로 발급되었습니다.");
			mmsg.setRecipient(RecipientType.TO, new InternetAddress(reciever));
			String infomation="안녕하세요? Gradient 입니다. \n\n\n새로 발급된  임시 비밀번호는"
					+service.get(memberkey).getPass() +" 입니다. \n  비밀번호는 다시 바꾸는 걸 추천드립니다. \n\n 그러면 즐거운 하루 되십시오.";
			mmsg.setText(infomation);
			sender.send(mmsg);
			System.out.println("이메일 발송되었습니다.");
			System.out.println("수신자"+reciever);
		} catch (MessagingException e) {
			// TODO Auto-generated catch block
			msg="메일 발송 에러:"+e.getMessage();
			System.out.println(msg);
		} catch (Exception e) {
			msg = "일반 에러 발생:"+e.getMessage();
		}
		return msg;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
