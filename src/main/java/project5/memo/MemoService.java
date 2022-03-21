package project5.memo;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MemoService {

	@Autowired
	MemoDao dao;

	public List<MemoVO> list() {
		return dao.list();
	}

	public void insert(MemoVO vo) {
		dao.insert(vo);
	}

}
