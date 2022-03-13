package project5.noticeReply;

import org.springframework.stereotype.Repository;

@Repository
public interface NoticeReplyDao {
	public int insert(NoticeReplyVO vo);
	public NoticeReplyVO read(int noticekey);
	public int delete(int noticekey);
	public int update(NoticeReplyVO reply);

	//public List<NoticeReplyVO> getListWithPaging(@Param("cri") Criteria cri, @Param("bno") int noticekey);

	public int getCountByBno(int noticekey);
}
