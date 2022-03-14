package project5.notice;

import java.util.List;

import org.springframework.stereotype.Repository;

@Repository
public interface NoticeDao {
	public List<NoticeVO> getList(NoticeSch sch);
	public void insert(NoticeVO vo);
	public NoticeVO2 get(int noticekey);
	public void delete(int noticekey);
	public void update(NoticeVO vo);
	
	public int totCnt();
}
