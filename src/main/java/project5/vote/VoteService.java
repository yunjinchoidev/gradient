package project5.vote;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class VoteService {

	@Autowired
	VoteDao dao;

	public List<VoteVO> list() {
		return dao.list();
	}

	public VoteVO get(int votekey) {
		return dao.get(votekey);
	}

	public void insert(VoteVO vo) {
		dao.insert(vo);
	}
	
	public void voting(VoteVO vo) {
		dao.voting(vo);
	}
}
