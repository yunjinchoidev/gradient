package project5.cost;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CostService {
	@Autowired
	private CostDao dao;
	
	//게시글 목록
	public List<CostList> getCostList(){
		return dao.getCostList();
	}
	//프로젝트 목록
	public List<CostList> getPrjList(){
		return dao.getPrjList();
	}
	// 예산 구분 목록
	public List<CostList> getCostSort(){
		return dao.getCostSort();
	}
	// 프로젝트 예산
	public int getPrjCost(int prjkey) {
		return dao.getPrjCost(prjkey);
	}
}
