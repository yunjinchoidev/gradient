package project5.chatBot;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ChatBotService {
	@Autowired
	ChatBotDao dao;
	
	public List<ChatBotVO> list(){
		return dao.list();
	}
	
	public ChatBotVO getbyInputData(String inputdata) {
		return dao.getbyInputData(inputdata);
	}
}
