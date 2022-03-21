package project5.project;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import project5.fileInfo.FileInfoDao;
import project5.fileInfo.FileInfoVO;
import project5.member.MemberVO;

@Service
public class ProjectService {

	@Autowired
	ProjectDao dao;

	@Autowired
	FileInfoDao dao2;
	
	public List<ProjectVO> list() {
		return dao.list();
	}
	
	public ProjectVO get(int projectkey) {
		return dao.get(projectkey);
	}
	
	public List<ProjectVO> get2(List<Integer> list){
		return dao.get2(list);
	}
	public void insert(ProjectVO vo) {
		dao.insert(vo);
	}
	

	@Value("${upload}")
	private String uploadPath;

	public String update(ProjectVO vo) {
		dao.update(vo);
		String msg = "등록성공";
		System.out.println("projectkey:"+vo.getProjectkey());
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
						dao2.update(new FileInfoVO(vo.getProjectkey(),uploadPath, fname, "프로젝트 번호:" + vo.getProjectkey()));
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
	
	
	
	
	
	
	
	
	
	public void progressUpdate(ProjectVO vo) {
		dao.progressUpdate(vo);
	}
	
	public void delete(int projectkey) {
		dao.delete(projectkey);
	}
	
	

}
