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
	// 프로젝트 예산 등록
	public void insPrjCost(MultiRowCost ins);
	// 프로젝트 리스트 등록
	public void insCostList(CostList ins);
	// 프로젝트 정보
	public CostDetailInfo prjDetailInfo(int prjkey);
	// 프로젝트 지출 리스트
	public List<CostDetailInfo> costDetailList(int prjkey);
	// 프로젝트 지출 금액
	public int amountPay(int prjkey);
}
