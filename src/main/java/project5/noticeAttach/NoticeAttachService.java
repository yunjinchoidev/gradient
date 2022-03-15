package project5.noticeAttach;
//project5.noticeAttach.NoticeAttachDao
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

@Service
public class NoticeAttachService {
	@Autowired
	NoticeAttachDao dao;
	
	public List<NoticeAttachVO> findByBno(int noticekey){
		return dao.findByBno(noticekey);
	}
}
