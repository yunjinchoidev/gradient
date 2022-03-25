package project5.z01_util;

import java.util.Date;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;


@Component("chatHandler")
public class A02_ChattingHandler extends TextWebSocketHandler{
	private Map<String, WebSocketSession> users = new ConcurrentHashMap();
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		users.put(session.getId(), session);
		log(session.getId()+"님 접속합니다!! 현재 접속자 수:"+users.size());
	}
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		log(session.getId()+"에서 온 메시지:"+message.getPayload());
		for(WebSocketSession ws:users.values()) {
			ws.sendMessage(message);
			log(ws.getId()+"에게 전달 메시지:"+message.getPayload());
		}
	}
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		users.remove(session.getId());
		log(session.getId()+" 접속 종료합니다.");
	}
	@Override
	public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
		 log(session.getId()+"에러 발생! 에러내용"+exception.getMessage());
		 //session.sendMessage( "에러 발생! 에러내용"+exception.getMessage());
	}
	// # 기본 로그 처리
	private void log(String logMsg) {
		System.out.println(new Date()+":"+logMsg);
	}
}
