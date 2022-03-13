package project5.notice;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import project5.fileInfo.FileInfoDao;
import project5.noticeAttach.NoticeAttachDao;

@Service
public class NoticeService {

	@Autowired
	NoticeDao dao;

	@Autowired
	NoticeAttachDao dao2;

	public List<NoticeVO> getList() {
		return dao.getList();
	}

	@Transactional
	public void insert(NoticeVO vo) {
		dao.insert(vo);

		
		if(vo.getAttachList()==null || vo.getAttachList().size()<=0) {
			return;
		}
		vo.getAttachList().forEach(attach -> {
			attach.setNoticekey(vo.getNoticekey());
			dao2.insert(attach);
		});

	}

	public NoticeVO2 get(int noticekey) {
		return dao.get(noticekey);
	}
	
	public void delete(int noticekey) {
		dao.delete(noticekey);
	}
	
	
}
