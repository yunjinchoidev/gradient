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

	public List<MemberVO> list() {
		return dao.list();
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
		dao2.update(new FileInfoVO(uploadPath, "1", "게시물 제목:" + vo.getMemberkey()));
		System.out.println("여기까지는 된다.");
		
		// 업로드 파일이 없을 때를 피하기 위해
		if (vo.getUploadFile() != null && vo.getUploadFile().length > 0) {
			try {
				for (MultipartFile mf : vo.getUploadFile()) {
					String fname = mf.getOriginalFilename();
					// 파일 이름이 없는 경우를 피하기 위해
					if (fname != null && !fname.equals("")) {
						System.out.println("경로명:" + uploadPath);
						System.out.println("첨부파일명:" + fname);
						File file = new File(uploadPath + fname);
						mf.transferTo(file);
						// 첨부파일 정보 DB에 등록..
						System.out.println("로컬 폴더에 파일 저장 완료");
						System.out.println(new FileInfoVO(uploadPath, fname, "회원 번호:" + vo.getMemberkey()));
						dao2.update(new FileInfoVO(vo.getFno(),uploadPath, fname, "회원 번호:" + vo.getMemberkey()));
						System.out.println("데이터베이스에 저장 완료");
					}
				}
			} catch (IllegalStateException e) {
				// TODO Auto-generated catch block
				// e.printStackTrace();
				msg = e.getMessage();
				msg =" ????";
				System.out.println("?>???????????");
			} catch (IOException e) {
				// TODO Auto-generated catch block
				// e.printStackTrace();
				msg = "파일전송오류:" + e.getMessage();
			} catch(Exception e) {
				msg = "기타예외:" + e.getMessage();
			}
		}
		
		System.out.println("체크");
		return msg;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	public int reginum() {
		return dao.reginum();
	}
	
	
	public MemberVO get(int memberkey) {
		
		return dao.get(memberkey);
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	public void delete(int memberkey) {
		dao.delete(memberkey);
	}

	
	
}
