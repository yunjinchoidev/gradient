package project5.notice;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import project5.fileInfo.FileInfoDao;

@Service
public class NoticeService {

	@Autowired
	NoticeDao dao;
	
	@Autowired
	FileInfoDao fileInfoDao;

	public List<NoticeVO> getList() {
		return dao.getList();
	}

	public void insert(NoticeVO vo) {
		 dao.insert(vo);
		 fileInfoDao.insert(null);
		 
	}

	public NoticeVO get(int noticekey) {
		return dao.get(noticekey);
	}
}
