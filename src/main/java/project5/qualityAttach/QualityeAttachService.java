package project5.qualityAttach;
//project5.noticeAttach.NoticeAttachDao
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

@Service
public class QualityeAttachService {
	@Autowired
	QualityAttachDao dao;
	
	public List<QualityAttachVO> findByBno(int qualitykey){
		return dao.findByBno(qualitykey);
	}
}
