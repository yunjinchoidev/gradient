package project5.output;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import project5.fileInfo.FileInfoDao;
import project5.fileInfo.FileInfoService;

@Service
public class OutputService {
	
	@Autowired
	OutputDao dao;
	
	@Autowired
	FileInfoDao dao2;
	
	
	public List<OutputVO> list(){
		return dao.list();
	}
	
	public OutputVO get(int outputkey) {
		return dao.get(outputkey);
	}
	
	public void insert(OutputVO vo) {
		dao.insert(vo);
		
		
		
	}
	
	
	
	
	
	
	public void update(OutputVO vo) {
		dao.update(vo);
	}
	
	public void delete(int outputkey) {
		dao.delete(outputkey);
	}
	
}
