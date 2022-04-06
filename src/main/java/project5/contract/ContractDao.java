package project5.contract;

import java.util.List;

import org.springframework.stereotype.Repository;

@Repository
public interface ContractDao {
	public int totCnt(ContractSch sch);
	public List<ContractVO> ContractList(ContractSch sch);
	
	public ContractVO getContract(int contractKey);
	
	public void insContract(ContractVO ins);
	public void uptContract(ContractVO upt);
	public void delContract(int contractKey);
}
