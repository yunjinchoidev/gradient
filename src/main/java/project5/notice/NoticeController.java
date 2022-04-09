package project5.notice;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import project5.member.MemberService;

@Controller
public class NoticeController {
	private static final Logger log = LoggerFactory.getLogger(NoticeController.class);

	@Autowired
	NoticeService service;

	@Autowired
	MemberService service2;

	@RequestMapping("/notice.do")
	public String notice(Model d, NoticeSch sch) {
		d.addAttribute("list", service.getList(sch));
		return "WEB-INF\\views\\notice\\list.jsp";
	}

	@RequestMapping("/noticeWriteForm.do")
	public String noticeWriteFrom() {
		return "WEB-INF\\views\\notice\\writeForm.jsp";
	}

	@RequestMapping("/noticeWrite.do")
	public String noticeWrite(Model d, NoticeVO vo) {
		service.insert(vo);
		d.addAttribute("psc", "writeSuccess");
		System.out.println("공지사항 작성 완료");
		return "WEB-INF\\views\\notice\\writeForm.jsp";
	}

	@RequestMapping("/noticeUpdateForm.do")
	public String noticeUpdateFrom(Model d, NoticeVO vo) {
		d.addAttribute("notice", service.get(vo.getNoticekey()));
		return "WEB-INF\\views\\notice\\update.jsp";
	}

	@RequestMapping("/noticeUpdate.do")
	public String noticeUpdate(Model d, NoticeVO vo) {
		service.update(vo);
		d.addAttribute("psc", "update");
		d.addAttribute("msg", "noticeUpdate");
		return "WEB-INF\\views\\notice\\list.jsp";
	}

	@RequestMapping("/noticeGet.do")
	public String noticeGet(Model d, int noticekey) {
		d.addAttribute("notice", service.get(noticekey));
		return "WEB-INF\\views\\notice\\get.jsp";
	}

	@RequestMapping("/noticeDelete.do")
	public String noticeDelete(Model d, int noticekey) {
		service.delete(noticekey);
		d.addAttribute("psc", "delete");
		System.out.println("공지사항 삭제 완료");
		return "forward:/notice.do";
	}

}
