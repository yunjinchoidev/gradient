package project5.notice;

import java.util.List;
import java.util.PrimitiveIterator.OfDouble;

import org.apache.ibatis.annotations.Param;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;import project5.upload.AttachFileDTO;
import project5.upload.UploadController;

@Controller
public class NoticeController {
	private static final Logger log = LoggerFactory.getLogger(NoticeController.class);
	
	
	
	@Autowired
	NoticeService service;

	@RequestMapping("/notice.do")
	public String unifyIndex(Model d) {
		d.addAttribute("list", service.getList());
		System.out.println("공지사항 리스트 조회 완료");
		return "notice/list";
	}

	@RequestMapping("/noticeWriteForm.do")
	public String noticeWriteFrom() {
		return "notice/writeForm";
	}

	@RequestMapping("/noticeWrite.do")
	public String noticeWrite(Model d, NoticeVO vo) {
		
		
		
		log.info("====================");
		
		
		if(vo.getAttachList() != null ) {
			System.out.println(vo.getAttachList().get(0));
		}
		
		
		
		
 		log.info("NotiveVO :"+vo);
		service.insert(vo);
		d.addAttribute("psc", "success");
		System.out.println("공지사항 작성 완료");
		return "redirect:/notice.do";
	}

	@RequestMapping("/noticeGet.do")
	public String noticeGet(Model d, int noticekey) {
		d.addAttribute("notice", service.get(noticekey));
		d.addAttribute("psc", "success");
		System.out.println("공지사항 조회 완료");
		return "notice/get";
	}

}
