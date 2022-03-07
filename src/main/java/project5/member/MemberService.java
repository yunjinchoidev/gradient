package project5.member;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MemberService {
	
	@Autowired
	MemberDao dao;

	public List<MemberVO> list() {
		return dao.list();
	}
	
	public MemberVO login(MemberVO vo) {
		return dao.login(vo);
	}

	public MemberVO logout() {
		return dao.logout();
	}
	
	public void register(MemberVO vo) {
		dao.register(vo);
	}
	
	
}
