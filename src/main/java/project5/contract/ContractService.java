package project5.contract;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ContractService {

	@Autowired
	ContractDao dao;
	
public List<ContractVO> ContractList(ContractSch sch){
		
		sch.setCount(dao.totCnt(sch));
		
		if(sch.getPageSize()==0) {
			sch.setPageSize(5);
		}
		
		double totPage1 = sch.getCount()/(double)sch.getPageSize();
		totPage1 = Math.ceil(totPage1); 
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
	
		return dao.ContractList(sch);
	}
	
	public ContractVO getContract(int contractKey) {
		return dao.getContract(contractKey);
	}
	
	public String insContract(ContractVO ins) {
		dao.insContract(ins);
		String msg="등록성공";
		return msg;
	}
	public void uptContract(ContractVO upt) {
		dao.uptContract(upt);
	}
	public void delContract(int contractKey) {
		dao.delContract(contractKey);
	}
}
