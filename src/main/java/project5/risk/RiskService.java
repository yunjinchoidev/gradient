package project5.risk;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class RiskService {
	
	@Autowired
	private RiskDao dao;
	
	// 리스크 게시판 조회
	public List<RiskVO> riskboardlist(RiskSch sch){
		
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
		
		return dao.riskboardlist(sch);
	}
	// 리스크 게시글 검색
	public List<RiskVO> schRiskList(RiskSch sch){
		
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
		
		return dao.schRiskList(sch);
	}
	// 프로젝트 조회
	public List<RiskVO> selectprjlist() {
		return dao.selectprjlist();
	}
	// 리스크 게시글 조회
	public RiskVO riskDetail(int riskkey){
		return dao.riskDetail(riskkey);
	}
	// 리스크 등록
	public void insertRisk(RiskVO ins) {
		dao.insertRisk(ins);
	}	
	// 리스크 삭제
	public void delRisk(int riskkey) {
		dao.delRisk(riskkey);
	}
	// 리스크 수정
	public void uptRisk(RiskVO upt) {
		dao.uptRisk(upt);
	}
	// 댓글 등록
	public void insertcomm(InsRiskcomm ins) {
		dao.insertcomm(ins);
	}
	// 댓글 조회
	public List<Riskcomm> getCommList(int riskkey){
		return dao.getCommList(riskkey);
	}
	// 댓글 삭제
	public void delcomm(int rcommkey) {
		dao.delcomm(rcommkey);
	}
	//답글 등록
	public void insertrecomm(InsRiskcomm ins) {
		dao.insertrecomm(ins);
	}
	// 답글 삭제
	public void delrecomm(int rcommkey) {
		dao.delrecomm(rcommkey);;
	}
}
