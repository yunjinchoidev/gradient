package project5.fileInfo;


import org.springframework.stereotype.Repository;

@Repository
public interface FileInfoDao {
	public void insert(FileInfoVO vo);
}
