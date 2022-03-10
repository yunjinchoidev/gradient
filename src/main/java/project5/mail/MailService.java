package project5.mail;

import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Service
public class MailService {
	
	@Autowired
	private JavaMailSender sender;
	
	private String sendMail(Mail email) {
		String msg = "메일 발송 성공";
		
		// 1. 멀티미디어형 메일 데이터 전송
		MimeMessage mmsg = sender.createMimeMessage();
		
		// 2. 제목 설정.
		try {
			mmsg.setSubject(email.getTitle());
			mmsg.setRecipient(RecipientType.TO, new InternetAddress(email.getReciever()));
		} catch (MessagingException e) {
			// TODO Auto-generated catch block
			msg = "일반 에러 발생:"+e.getMessage();
		}
		
		return msg;
		
		
		
	}

}
