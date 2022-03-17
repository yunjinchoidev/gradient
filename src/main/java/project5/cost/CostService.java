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
	// 프로젝트 예산 등록
	public void insPrjCost(MultiRowCost ins) {
		dao.insPrjCost(ins);
	}
	// 프로젝트 예산 리스트 등록
	public void insCostList(CostList ins) {
		dao.insCostList(ins);
	}
}
