package project5.cost;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import project5.risk.RiskSch;
import project5.risk.RiskVO;

@Service
public class CostService {
	@Autowired
	private CostDao dao;
	
	//게시글 목록
	public List<CostList> getCostList(CostSch sch){
		
		sch.setCount(dao.totCnt(sch));
		
		if(sch.getPageSize()==0) {
			sch.setPageSize(5);
		}
		
		double totPage1 = sch.getCount()/(double)sch.getPageSize();
		totPage1 = Math.ceil(totPage1); // 올림 처리..
		int totPage = (int)(totPage1);
		sch.setPageCount( totPage );
		
		if(sch.getCurPage()==0) {
			sch.setCurPage(1);
		}
		
		sch.setStart((sch.getCurPage()-1)*sch.getPageSize()+1);
		sch.setEnd(sch.getCurPage()*sch.getPageSize());
		sch.setBlockSize(5);
	
		int curBlockGrpNo = (int)Math.ceil(sch.getCurPage()/(double)sch.getBlockSize());
		sch.setStartBlock((curBlockGrpNo-1)*sch.getBlockSize()+1);
		
		int endBlockGrpNo = curBlockGrpNo*sch.getBlockSize();
		sch.setEndBlock(endBlockGrpNo>sch.getPageCount()?sch.getPageCount():endBlockGrpNo);
		
		return dao.getCostList(sch);
	}
	// 예산 게시글 검색
		public List<CostList> schCostList(CostSch sch){
			
			sch.setCount(dao.totCnt(sch));
			
			if(sch.getPageSize()==0) {
				sch.setPageSize(5);
			}
			
			double totPage1 = sch.getCount()/(double)sch.getPageSize();
			totPage1 = Math.ceil(totPage1); // 올림 처리..
			int totPage = (int)(totPage1);
			sch.setPageCount( totPage );
			
			if(sch.getCurPage()==0) {
				sch.setCurPage(1);
			}
			
			sch.setStart((sch.getCurPage()-1)*sch.getPageSize()+1);
			sch.setEnd(sch.getCurPage()*sch.getPageSize());
			sch.setBlockSize(5);
		
			int curBlockGrpNo = (int)Math.ceil(sch.getCurPage()/(double)sch.getBlockSize());
			sch.setStartBlock((curBlockGrpNo-1)*sch.getBlockSize()+1);
			
			int endBlockGrpNo = curBlockGrpNo*sch.getBlockSize();
			sch.setEndBlock(endBlockGrpNo>sch.getPageCount()?sch.getPageCount():endBlockGrpNo);
			
			return dao.schCostList(sch);
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
	// 프로젝트 정보
	public CostDetailInfo prjDetailInfo(int prjkey) {
		return dao.prjDetailInfo(prjkey);
	}
	// 프로젝트 지출 리스트
	List<CostDetailInfo> costDetailList(int prjkey){
		return dao.costDetailList(prjkey);
	}
	// 프로젝트 지출 금액
	public int amountPay(int prjkey) {
		return dao.amountPay(prjkey);
	}
	// 프로젝트 예산 승인
	public void costConfirm(int prjkey) {
		dao.costConfirm(prjkey);
	}
	// 프로젝트 예산 삭제
	public void delCost(int prjkey) {
		dao.delCost(prjkey);
		dao.delCostDetail(prjkey);
	}
	
}
