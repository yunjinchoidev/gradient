package project5.fileInfo;


import java.util.List;

import org.springframework.stereotype.Repository;

@Repository
public interface FileInfoDao {
	public void insert(FileInfoVO vo);
	public void update(FileInfoVO vo);
	public List<FileInfoVO> findbyfno(int fno);
}
