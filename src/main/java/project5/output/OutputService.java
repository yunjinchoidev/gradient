package project5.output;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.apache.poi.util.SystemOutLogger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import project5.fileInfo.FileInfoDao;
import project5.fileInfo.FileInfoVO;

@Service
public class OutputService {

	@Autowired
	OutputDao dao;

	@Autowired
	FileInfoDao dao2;

	
	
	public List<OutputVO> listWithPaging(OutputSch sch){
		

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

		
		
		
		return dao.listWithPaging(sch);
	}
	
	public int totCnt(OutputSch sch) {
		return dao.totCnt(sch);
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	public List<OutputVO> list() {
		return dao.list();
	}

	public OutputVO get(int outputkey) {

		OutputVO vo = dao.get(outputkey);
		vo.setFnames(dao2.getFileInfoNames(outputkey));
		return vo;

	}

	@Value("${upload}")
	private String uploadPath;

	public String insert(OutputVO ins) {

		dao.insert(ins);
		dao2.insert(new FileInfoVO(uploadPath, "1", "게시물 제목:" + ins.getTitle()));
		String msg = "등록성공";

		// 파일을 업로드 했는지 안했는지 점검
		if (ins.getUploadFile() != null && ins.getUploadFile().length > 0) {
			try {
				for (MultipartFile mf : ins.getUploadFile()) {
					String fname = mf.getOriginalFilename();
					if (fname != null && !fname.equals("")) {
						System.out.println("경로명:" + uploadPath);
						System.out.println("첨부파일명:" + fname);
						File file = new File(uploadPath + fname);
						mf.transferTo(file);
						System.out.println("폴더에 저장 성공");
						// 첨부파일 정보 DB에 등록..
						dao2.insert2(new FileInfoVO(uploadPath, fname, "게시물 제목:" + ins.getTitle()));
						System.out.println("db에 저장 성공");
					}
				}
			} catch (IllegalStateException e) {
				// TODO Auto-generated catch block
				// e.printStackTrace();
				msg = e.getMessage();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				// e.printStackTrace();
				msg = "파일전송오류:" + e.getMessage();
			} catch (Exception e) {
				msg = "기타예외:" + e.getMessage();
			}
		} else {
			System.out.println("비었네요");
		}
		return msg;
	}

	public void update(OutputVO vo) {
		dao.update(vo);
	}

	public void delete(int outputkey) {
		dao.delete(outputkey);
	}

	public void outputEvaluation(OutputVO vo) {
		dao.outputEvaluation(vo);
	}

}
