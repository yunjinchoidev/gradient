package project5.chatting;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ChattingService {

	@Autowired
	ChattingDao dao;
	
	
}
