package project5.myWork;

import java.util.List;

import org.springframework.stereotype.Repository;

import project5.fileInfo.FileInfoVO;

@Repository
public interface MyWorkDao {

	public List<FileInfoVO> myFileListInOutput(int memberkey);
	public List<MenubarVO> menubarList();
	public MenubarVO menubarGet(int menubarkey);
	
}
