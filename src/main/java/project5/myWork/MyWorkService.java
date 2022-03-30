package project5.myWork;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import project5.fileInfo.FileInfoVO;

@Service
public class MyWorkService {

	@Autowired
	MyWorkDao dao;
	
	public List<FileInfoVO> myFileListInOutput(int memberkey){
		return dao.myFileListInOutput(memberkey);
	}
	
	public List<MenubarVO> menubarList(){
		return dao.menubarList();
	}

	public MenubarVO menubarGet(int menubarkey) {
		return dao.menubarGet(menubarkey);
	}
}
