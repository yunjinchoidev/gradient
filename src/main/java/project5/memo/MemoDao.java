package project5.memo;

import java.util.List;

import org.springframework.stereotype.Repository;


@Repository
public interface MemoDao {
	public int totCnt(MemoSch sch);
	public List<MemoVO> list(MemoSch sch);
	public void insert(MemoVO vo);
	public void delteMemo(int memokey);
	
}
