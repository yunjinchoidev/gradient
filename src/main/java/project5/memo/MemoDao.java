package project5.memo;

import java.util.List;

import org.springframework.stereotype.Repository;


@Repository
public interface MemoDao {
	public List<MemoVO> list();
	public void insert(MemoVO vo);
}
