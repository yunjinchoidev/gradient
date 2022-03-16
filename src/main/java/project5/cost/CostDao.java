package project5.cost;

import java.util.List;

import org.springframework.stereotype.Repository;

@Repository
public interface CostDao {
	// 게시글 목록
	public List<CostList> getCostList();
	// 프로젝트 목록
	public List<CostList> getPrjList();
	// 예산 구분 목록
	public List<CostList> getCostSort();
	// 프로젝트 예산
	public int getPrjCost(int prjkey);
}
