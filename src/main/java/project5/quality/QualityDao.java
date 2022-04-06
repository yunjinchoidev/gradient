package project5.quality;

import java.util.List;

import org.springframework.stereotype.Repository;



@Repository
public interface QualityDao {
	
		// 전체 데이터 수 가져오는 것
		public int totCnt(QualitySch sch);
		
		// 리스트 가져오기
		public List<QualityVO> getList(QualitySch sch);

		
	

	public QualityVO get(int qualitykey);

	public void insert(QualityVO vo);

	public void update(QualityVO vo);

	public void delete(int qualitykey);
	
	public int totCnt();
	
	public int current();
	
// 품질 평가
	// 프로젝트 목록
	public List<QualityVO> prjlist();
	// 품질 평가 항목 목록
	public List<QualityVO> evallist();
	// 품질 평가 항목 수정
	public void upteval(MultiQuality upt);
	// 품질 평가 합격
	public void qualitypass(QualityVO upt);
	// 품질 평가 합격 목록
	public List<QualityVO> certiprjlist();

	

}
