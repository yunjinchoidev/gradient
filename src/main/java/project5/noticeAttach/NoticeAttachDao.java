package project5.noticeAttach;
//project5.noticeAttach.NoticeAttachDao
import java.util.List;

import org.springframework.stereotype.Repository;

@Repository
public interface NoticeAttachDao {
	public void insert(NoticeAttachVO vo);

	public void delete(String uuid);

	public List<NoticeAttachVO> findByBno(int noticekey);

	public void deleteAll(int noticekey);

	public List<NoticeAttachVO> getOldFiles();
}
