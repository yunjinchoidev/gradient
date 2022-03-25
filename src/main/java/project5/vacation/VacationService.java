package project5.vacation;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class VacationService {

	@Autowired
	VacationDao dao;
	
	
}
