package project5.fileInfo;


import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Repository;

@Repository
public interface FileInfoDao {
	public void insert(FileInfoVO vo);
	public void insert2(FileInfoVO vo);
	public void insert4(FileInfoVO vo);
	public void insertCalendarFile(FileInfoVO vo);
	public void update(FileInfoVO vo);
	public void update1(FileInfoVO vo);    // 회원 이미지 바꾸기
	public List<FileInfoVO> findbyfno(int fno);
	
	public ArrayList<String> getFileInfoNames(int fno);
	

}
