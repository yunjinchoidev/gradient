package project5.dashBoard;

import java.util.List;

import org.springframework.stereotype.Repository;


@Repository
public interface DashBoardDao {
	
	public List<RiskDashBoardVO> riskDashBoard();

	
	
	
}
