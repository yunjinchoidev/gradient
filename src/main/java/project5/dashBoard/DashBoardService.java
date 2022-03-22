package project5.dashBoard;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;



@Service
public class DashBoardService {
	@Autowired
	private DashBoardDao dao;
	
	public List<RiskDashBoardVO> riskDashBoard(){
		return dao.riskDashBoard();
	}
	
}
