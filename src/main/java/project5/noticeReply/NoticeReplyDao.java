package project5.noticeReply;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import project5.paging.Criteria;

@Repository
public interface NoticeReplyDao {
	public int insert(NoticeReplyVO vo);
	public NoticeReplyVO read(int noticekey);
	public int delete(int noticekey);
	public int update(NoticeReplyVO reply);

	public List<NoticeReplyVO> getListWithPaging(@Param("cri") Criteria cri, @Param("noticekey") int noticekey);

	public int getCountByBno(int noticekey);
}
