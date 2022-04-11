package project5.member;

import java.util.List;

import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;

import project5.memo.MemoSch;

@Repository
public interface MemberDao {
	
	
	public List<MemberVO> list();
	public List<MemberVO> listWithPaging(MemberSch sch);
	public int totCnt(MemberSch sch);
	public List<MemberVO> listWithPaging2(MemberSch sch);
	public int totCnt2(MemberSch sch);
	public List<MemberVO> listWithPaging3(MemberSch sch);
	public int totCnt3(MemberSch sch);
	
	
	
	public MemberVO login(MemberVO vo);
	public MemberVO logout();
	public void edit(MemberVO vo);
	public int reginum();
	public int reginumCurrvalAjax();
	public MemberVO get(int memberkey);
	public void delete(int memberkey);

	public void memberRegisterApply(MemberVO vo);
	public void memberRegisterComplete(int memberkey);
	public String 	memberIdFind(MemberVO vo);
	public MemberVO memberPassFind(MemberVO vo);
	public void newIssuePassword(MemberVO vo);
	
	public MemberVO getByNameAndEmail(MemberVO vo);
	public MemberVO read(String id);
	
	public void updateVisitCnt(int memberkey);
	public void updatePricing(MemberVO vo);
	public void insertMemberAjax(MemberVO vo);
	
	public void updateStatus(MemberVO vo);
	
	
	
	public MemberVO duplicateEmail(String email);
	public MemberVO duplicateId(String id);
	
	public MemberVO apiLogin(MemberVO vo);
	
	public int visitCount1();
	public int visitCount2();
	public int visitCount3();
	public int visitCount4();
	public List<MemberVO> authCount();
	
	
	
	
}
