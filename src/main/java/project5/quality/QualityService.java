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

// 품질 평가
	// 프로젝트 목록
	public List<QualityVO> prjlist(){
		return dao.prjlist();
	}
	// 품질 평가 항목 목록
	public List<QualityVO> evallist(){
		return dao.evallist();
	}
	// 품질 평가 항목 수정
	public void upteval(MultiQuality upt){
		dao.upteval(upt);
	}
	// 품질 평가 합격
	public void qualitypass(QualityVO upt) {
		dao.qualitypass(upt);
	}

}
