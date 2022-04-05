package project5.vacation;

import java.io.File;
import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import project5.fileInfo.FileInfoDao;
import project5.fileInfo.FileInfoVO;
import project5.member.MemberVO;

@Service
public class VacationService {

	@Autowired
	VacationDao dao;

	@Autowired
	FileInfoDao dao2;

	@Value("${upload}")
	private String uploadPath;

	public String insert(VacationVO vo) {
		dao.insert(vo);
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
						dao2.insert4(new FileInfoVO(1, uploadPath, fname, "회원 번호:" + vo.getMemberkey()));
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
		return msg;

	}

}
