package project5.notice;

import java.util.List;

import org.springframework.stereotype.Repository;


@Repository
public interface NoticeDao {
	
	// 전체 데이터 수 가져오는 것
	public int totCnt(NoticeSch sch);
	
	// 리스트 가져오기
	public List<NoticeVO> getList(NoticeSch sch);
	
	
	
	public void insert(NoticeVO vo);
	public NoticeVO2 get(int noticekey);
	public void delete(int noticekey);
	public void update(NoticeVO vo);
	public int current();
	public int totCnt();
}
