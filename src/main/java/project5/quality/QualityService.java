package project5.quality;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import project5.quality.QualitySch;
import project5.quality.QualityVO;
import project5.qualityAttach.QualityAttachDao;


@Service
public class QualityService {
	
	
	@Autowired
	QualityDao dao;
	
	@Autowired
	QualityAttachDao dao2;
	
	
	
	public List<QualityVO> getList(QualitySch sch) {
		// 1. 전체 라인 수
		sch.setCount(dao.totCnt(sch));

		// 2. 페이지 사이즈(페이퍼 크기)
		if (sch.getPageSize() == 0) {
			sch.setPageSize(5);
		}

		// 3. 총 페이지 수
		double totPage1 = sch.getCount() / (double) sch.getPageSize();
		totPage1 = Math.ceil(totPage1); // 올림 처리..
		int totPage = (int) (totPage1);
		sch.setPageCount(totPage);

		// 4. 현재 페이지
		if (sch.getCurPage() == 0) {
			sch.setCurPage(1);
		}

		// 5. 한 페이지의 맨 위에 있는 라인 키
		sch.setStart((sch.getCurPage() - 1) * sch.getPageSize() + 1);

		// 6. 한 페이지 마지막 줄에 있는 라인 키
		sch.setEnd(sch.getCurPage() * sch.getPageSize());

		// 7. 블락 키
		sch.setBlockSize(5);

		int curBlockGrpNo = (int) Math.ceil(sch.getCurPage() / (double) sch.getBlockSize());

		// 8. 시작 블럭
		sch.setStartBlock((curBlockGrpNo - 1) * sch.getBlockSize() + 1);
		int endBlockGrpNo = curBlockGrpNo * sch.getBlockSize();

		// 9. 마지막 블럭
		sch.setEndBlock(endBlockGrpNo > sch.getPageCount() ? sch.getPageCount() : endBlockGrpNo);
		
		
		
		
	return dao.getList(sch);
}





@Transactional
public void insert(QualityVO vo) {
dao.insert(vo);
vo.setQualitykey(dao.current());

// 첨부파일이 없으면 종료한다.
if(vo.getAttachList()==null || vo.getAttachList().size()<=0) {
return;
}
vo.getAttachList().forEach(attach -> {
attach.setQualitykey(vo.getQualitykey());

// 첨부파일 저장
dao2.insert(attach);
});
}

	public QualityVO get(int qualitykey) {
		return dao.get(qualitykey);
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
	// 품질 평가 합격 목록
	public List<QualityVO> certiprjlist(){
		return dao.certiprjlist();
	}

}
