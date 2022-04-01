package project5.memo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MemoController {

	@Autowired
	MemoService service;

	@RequestMapping("/memoList.do")
	public String memoInsert(Model d, MemoSch sch) {
		d.addAttribute("list", service.list(sch));
		return "WEB-INF\\views\\dashBoard\\memoList.jsp";
	}

	@RequestMapping("/memoInsert.do")
	public String memoInsert(Model d, MemoVO vo) {
		service.insert(vo);
		d.addAttribute("msg", "insertSuccess");
		return "WEB-INF\\views\\dashBoard\\memoList.jsp";
	}

	@RequestMapping("/memoDelete.do")
	public String memoDelete(Model d, int memokey) {
		d.addAttribute("psc", "memoDelete");
		service.delteMemo(memokey);
		return "forward:/memoList.do";
	}

}
