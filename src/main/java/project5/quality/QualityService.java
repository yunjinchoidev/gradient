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
		
		// 1. 전체 갯수 totCnt
		// dao.totCnt(sch);
		// 총건수를 화면에 출력하려면 BoardSch에 설정. 모델 데이터로 활용할 수 있다.
		sch.setCount(dao.totCnt());
		
		// 2. 한번에 보일 페이지 수 초기 값 설정 PageSize
		if(sch.getPageSize()==0) {
				sch.setPageSize(5);
			}
		
		// 3. 총 페이지 수 (전체갯수/한번에 보일 페이지 수)
		double totPage1 = sch.getCount()/(double)sch.getPageSize();
		totPage1 = Math.ceil(totPage1); // 올림 처리..
		int totPage = (int)(totPage1);
		sch.setPageCount( totPage );
		
		// 4. 클릭한 현재 페이지 호출
		// 현재 페이지 초기값.   0 ==> 1
			if(sch.getCurPage()==0) {
				sch.setCurPage(1);
			}
		
	/*
	현재페이지	나올 번호 리스트(5개기준) (글 번호)
	1페이지	1 2345
	2페이지	6 78910
	3페이지	11 12131415
	 * */
		
	// 5. 시작번호
	sch.setStart((sch.getCurPage()-1)*sch.getPageSize()+1);
	// 6. 마지막번호 : sql에서 없는 페이지는 로딩이 안되기에 마지막 총페이지 번호 조건을
	//    넣지 않고 처리했다.
	sch.setEnd(sch.getCurPage()*sch.getPageSize());
	
	
	// 7 하단의 페이지 block 처리
	//	1) 기본 block의 크기 지정  // 하단 페이지가 몇 단위로 보일꺼냐
	sch.setBlockSize(5);
	
	//	2) 현재 블럭 그룹 번호 : 현재 클릭한 페이지번호/블럭의 크기
	int curBlockGrpNo = (int)Math.ceil(sch.getCurPage()/(double)sch.getBlockSize());
	
	// 	3) 블럭 그룹의 시작 페이지 번호 // 수학적으로 굴리기
	sch.setStartBlock((curBlockGrpNo-1)*sch.getBlockSize()+1);
	
	//  4) 블럭 그룹의 마지막 페이지 번호 // 
	//     총페이지수 보다 크면 총 페이지수를 마지막 페이지 번호. (그렇지)
	int endBlockGrpNo = curBlockGrpNo*sch.getBlockSize(); // 사이즈 수-1 만큼 많을 것
	sch.setEndBlock(endBlockGrpNo>sch.getPageCount()?sch.getPageCount():endBlockGrpNo);
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

	public QualityVO2 get(int qualitykey) {
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
