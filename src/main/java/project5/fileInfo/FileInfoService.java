package project5.fileInfo;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class FileInfoService {
	@Autowired
	FileInfoDao dao;

	public void insert(FileInfoVO vo) {
		dao.insert(vo);
	}

	public void update(FileInfoVO vo) {
		dao.update(vo);
	}

	public  List<FileInfoVO> findbyfno(int fno) {
		return dao.findbyfno(fno);
	}
	
	
	
	
}
