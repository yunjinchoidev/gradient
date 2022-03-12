package project5.mail;

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
	
	
	
	public String sendMail(Mail email) {
		String msg = "메일 발송 성공";
		// 1. 멀티미디어형 메일 데이터 전송.
		MimeMessage mmsg = sender.createMimeMessage();
		// 2. 제목 설정.
		try {
			mmsg.setSubject(email.getTitle());
		
			// 3. 수신자 설정.
			mmsg.setRecipient(RecipientType.TO, new InternetAddress(email.getReciever()));
			
			
			
			// 4. 내용 설정.
			//    ex) 계정 비밀번호 입력 처리..
			
			mmsg.setText(email.getContent());

			
			
			// 5. 발송 처리.
			sender.send(mmsg);
			
		} catch (MessagingException e) {
			// TODO Auto-generated catch block
			msg="메일 발송 에러:"+e.getMessage();
			System.out.println(msg);
		} catch (Exception e) {
			msg = "일반 에러 발생:"+e.getMessage();
		}
		
		return msg;
	}
	
	
	
	
	
	
	
	
	
	public String sendidpassMail(int memberkey, String reciever) {
		String msg = "메일 발송 성공";
		
		
		
		// 1. 멀티미디어형 메일 데이터 전송.
		MimeMessage mmsg = sender.createMimeMessage();
		
		
		// 2. 제목 설정.
		try {
			mmsg.setSubject("5조 pms 가입을 대단히 환영합니다");
			
			
			// 3. 수신자 설정.
			mmsg.setRecipient(RecipientType.TO, new InternetAddress(reciever));
			
			
			
			// 4. 내용 설정.
			//    ex) 계정 비밀번호 입력 처리..
			String infomation="안녕하세요? \n5조 PMS에 가입하신 여러분을 환영합니다. \n\n\n 임시 아이디는 "+service.get(memberkey).getId() +"이고 "+
			"\n임시 비밀번호는 "+service.get(memberkey).getPass() +"입니다. \n \n 즐거운 하루 되십시오.";
			mmsg.setText(infomation);
			
			
			
			// 5. 발송 처리.
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
