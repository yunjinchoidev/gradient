package project5.output;

import java.util.List;

import org.springframework.stereotype.Repository;

import project5.member.MemberSch;
import project5.member.MemberVO;

@Repository
public interface OutputDao {
	
	public List<OutputVO> list();
	public List<OutputVO> listWithPaging(OutputSch sch);
	public int totCnt(OutputSch sch);
	
	
	
	
	public OutputVO get(int outputkey);
	public void insert(OutputVO vo);
	public void update(OutputVO vo);
	public void delete(int outputkey);
	public void outputEvaluation(OutputVO vo);
}
