package project5.chatBot;

import java.util.List;

import org.springframework.stereotype.Repository;

@Repository
public interface ChatBotDao {
	public List<ChatBotVO> list();
	public ChatBotVO getbyInputData(String inputdata);
}
