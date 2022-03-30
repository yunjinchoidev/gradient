package project5.member;

import java.util.List;

import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;

@Repository
public interface MemberDao {
	public List<MemberVO> list();
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
	public String memberPassFind(MemberVO vo);
	public void newIssuePassword(MemberVO vo);
	
	public MemberVO getByNameAndEmail(MemberVO vo);
	public MemberVO read(String id);
	
	public void updateVisitCnt(int memberkey);
	public void updatePricing(MemberVO vo);
	public void insertMemberAjax(MemberVO vo);
	
	
}
