package project5.feedback;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class FeedBackService {

	@Autowired
	FeedBackDao dao;
	
	
}
