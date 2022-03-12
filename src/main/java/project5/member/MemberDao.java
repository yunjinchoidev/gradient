package project5.member;

import java.util.List;

import org.springframework.stereotype.Repository;

@Repository
public interface MemberDao {
	public List<MemberVO> list();
	public MemberVO login(MemberVO vo);
	public MemberVO logout();
	public void edit(MemberVO vo);
	public int reginum();
	public MemberVO get(int memberkey);
	public void delete(int memberkey);
	
}
