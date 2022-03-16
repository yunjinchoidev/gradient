package project5.quality;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


@Service
public class QualityService {
	
	
	@Autowired
	QualityDao dao;
	
	
	public List<QualityVO> list(){
		return dao.list();
	}

	public QualityVO get(int qualitykey) {
		return dao.get(qualitykey);
	}
	
	public void insert(QualityVO vo) {
		dao.insert(vo);
	}

	public void update(QualityVO vo) {
		dao.update(vo);
	}

	public void delete(int qualitykey) {
		dao.delete(qualitykey);
	}

}
