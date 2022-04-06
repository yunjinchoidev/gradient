package project5.qualityAttach;
//project5.noticeAttach.NoticeAttachDao
import java.util.List;

import org.springframework.stereotype.Repository;

@Repository
public interface QualityAttachDao {
	public void insert(QualityAttachVO vo);

	public void delete(String uuid);

	public List<QualityAttachVO> findByBno(int qualitykey);

	public void deleteAll(int qualitykey);

	public List<QualityAttachVO> getOldFiles();
}
