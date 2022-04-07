package project5.member;

import java.io.File;
import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import project5.fileInfo.FileInfoDao;
import project5.fileInfo.FileInfoVO;

@Service
public class MemberService {

	@Autowired
	MemberDao dao;

	@Autowired
	FileInfoDao dao2;

	public int totCnt(MemberSch sch) {
		return dao.totCnt(sch);
	}

	public List<MemberVO> list() {
		return dao.list();
	}

	// 페이징 처리를 위해서!
	public List<MemberVO> listWithPaging(MemberSch sch) {

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

	public MemberVO login(MemberVO vo) {
		return dao.login(vo);
	}

	public MemberVO logout() {
		return dao.logout();
	}

	@Value("${upload}")
	private String uploadPath;

	public String edit(MemberVO vo) {
		dao.edit(vo);
		String msg = "등록성공";
		System.out.println("확인");
		if (vo.getUploadFile() != null && vo.getUploadFile().length > 0) {
			try {
				for (MultipartFile mf : vo.getUploadFile()) {
					String fname = mf.getOriginalFilename();
					if (fname != null && !fname.equals("")) {
						System.out.println("경로명:" + uploadPath);
						System.out.println("첨부파일명:" + fname);
						File file = new File(uploadPath + fname);
						mf.transferTo(file);
						System.out.println("로컬 폴더에 파일 저장 완료");
						System.out.println(new FileInfoVO(uploadPath, fname, "회원 번호:" + vo.getMemberkey()));
						dao2.update(new FileInfoVO(vo.getFno(), uploadPath, fname, "회원 번호:" + vo.getMemberkey()));
						System.out.println("데이터베이스에 저장 완료");
					}
				}
			} catch (IllegalStateException e) {
				msg = e.getMessage();
			} catch (IOException e) {
				msg = "파일전송오류:" + e.getMessage();
			} catch (Exception e) {
				msg = "기타예외:" + e.getMessage();
			}
		}

		System.out.println("체크");
		return msg;
	}

	public void memberRegisterComplete(int memberkey) {
		dao.memberRegisterComplete(memberkey);
	}

	public String memberIdFind(MemberVO vo) {
		return dao.memberIdFind(vo);
	}

	public MemberVO memberPassFind(MemberVO vo) {
		return dao.memberPassFind(vo);
	}

	public void newIssuePassword(MemberVO vo) {
		dao.newIssuePassword(vo);
	}

	public int reginum() {
		return dao.reginum();
	}

	public int reginumCurrvalAjax() {
		return dao.reginumCurrvalAjax();
	}

	public MemberVO get(int memberkey) {

		return dao.get(memberkey);
	}

	public void memberRegisterApply(MemberVO vo) {
		dao.memberRegisterApply(vo);
	}

	public MemberVO getByNameAndEmail(MemberVO vo) {
		return dao.getByNameAndEmail(vo);
	}

	public void delete(int memberkey) {
		dao.delete(memberkey);
	}

	public MemberVO read(String id) {
		return dao.read(id);
	}

	public void updateVisitCnt(int memberkey) {
		dao.updateVisitCnt(memberkey);
	}

	public void updatePricing(MemberVO vo) {
		dao.updatePricing(vo);
	}

	public void insertMemberAjax(MemberVO vo) {
		dao.insertMemberAjax(vo);
	}

	public void updateStatus(MemberVO vo) {
		dao.updateStatus(vo);
	}

	public MemberVO duplicateEmail(String email) {
		return dao.duplicateEmail(email);
	}

	public MemberVO duplicateId(String id) {
		return dao.duplicateId(id);
	}
	
	
	public MemberVO apiLogin(MemberVO vo) {
		return dao.apiLogin(vo);
	}
}