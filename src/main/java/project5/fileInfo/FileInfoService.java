package project5.fileInfo;

import java.util.ArrayList;
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
	
	public void insert2(FileInfoVO vo) {
		dao.insert(vo);
	}
	
	public void insertCalendarFile(FileInfoVO vo) {
		dao.insertCalendarFile(vo);
	}

	public void update(FileInfoVO vo) {
		dao.update(vo);
	}
	
	// 회원 이미지 바꾸기
	public void update1(FileInfoVO vo) {
		dao.update1(vo);
	}
	
	public  List<FileInfoVO> findbyfno(int fno) {
		return dao.findbyfno(fno);
	}
	
	public ArrayList<String> getFileInfoNames(int fno){
		return dao.getFileInfoNames(fno);
	}
	
	
	
	
}
