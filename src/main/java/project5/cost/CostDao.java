package project5.cost;

import java.util.List;

import org.springframework.stereotype.Repository;

import project5.risk.RiskSch;
import project5.risk.RiskVO;


@Repository
public interface CostDao {
	// 게시글 목록
	public List<CostList> getCostList(CostSch sch);
	// 리스크 게시글 검색
	public List<CostList> schCostList(CostSch sch);
	// 프로젝트 목록
	public List<CostList> getPrjList();
	// 예산 구분 목록
	public List<CostList> getCostSort();
	// 프로젝트 예산
	public int getPrjCost(int prjkey);
	// 프로젝트 인덱스 최대 값
	public int getMaxIndex(int prjkey);
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
	// 총 게시글
	public int totCnt(CostSch sch);
	// 프로젝트 예산 승인
	public void costConfirm(int prjkey);
	// 프로젝트 예산 삭제
	public void delCost(int prjkey);
	public void delCostDetail(int prjkey);
	// 프로젝트 예산 수정
	public void uptPrjCost(MultiRowCost upt);
	// 프로젝트 예산 삭제
	public void delCostList(CostDetailInfo del);
}
