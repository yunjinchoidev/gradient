package project5.fullCalendar;

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
public class A10_FullCalService {
	@Autowired
	private A10_FullCalDao dao;
	
	@Autowired
	private FileInfoDao dao2;
	
	public List<Calendar> getCalendarList(){
		return dao.getCalendarList();
	}
	
	public List<Calendar> getCalendarIndividaulList(int memberkey){
		return dao.getCalendarIndividaulList(memberkey);
	}

	public List<Calendar> mywork(int memberkey){
		return dao.mywork(memberkey);
	}
	
	
	public Calendar get(int id) {
		return dao.get(id);
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	@Value("${upload}")
	private String uploadPath;

	public String insertCalendar(Calendar ins) {
		dao.insertCalendar(ins);
		String msg = "등록성공";
		//dao2.update(new FileInfoVO(uploadPath, "1", "일정 제목" + ins.getTitle()));
		System.out.println("여기까지는 ok");
		// 업로드 파일이 없을 때를 피하기 위해
		if (ins.getUploadFile() != null && ins.getUploadFile().length > 0) {
			try {
				for (MultipartFile mf : ins.getUploadFile()) {
					String fname = mf.getOriginalFilename();
					// 파일 이름이 없는 경우를 피하기 위해
					if (fname != null && !fname.equals("")) {
						System.out.println("경로명:" + uploadPath);
						System.out.println("첨부파일명:" + fname);
						File file = new File(uploadPath + fname);
						mf.transferTo(file);
						// 첨부파일 정보 DB에 등록..
						System.out.println("로컬 폴더에 파일 저장 완료");
						System.out.println(new FileInfoVO(uploadPath, fname, "일정 제목" + ins.getTitle()));
						dao2.insertCalendarFile(new FileInfoVO(ins.getFno(),uploadPath, fname, "일정 제목" + ins.getTitle()));
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
	
	
	
	
	
	
	public void updateCalendar(Calendar upt) {
		dao.updateCalendar(upt);
	}
	public void deleteCalendar(int id) {
		dao.deleteCalendar(id);
	}
	
}
