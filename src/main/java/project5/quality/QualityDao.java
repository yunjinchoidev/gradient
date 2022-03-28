package project5.quality;

import java.util.List;

import org.springframework.stereotype.Repository;

@Repository
public interface QualityDao {

	public List<QualityVO> list();

	public QualityVO get(int qualitykey);

	public void insert(QualityVO vo);

	public void update(QualityVO vo);

	public void delete(int qualitykey);
	
// 품질 평가
	// 프로젝트 목록
	public List<QualityVO> prjlist();

}
