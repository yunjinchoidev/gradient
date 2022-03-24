package project5.memo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MemoController {

	@Autowired
	MemoService service;

	@RequestMapping("/memoInsert.do")
	public String memoInsert(Model d, MemoVO vo) {
		service.insert(vo);
		return "forward:/dashBoard.do";
	}

	@RequestMapping("/memoDelete.do")
	public String memoDelete(Model d, int memokey) {
		service.delteMemo(memokey);
		return "forward:/dashBoard.do?projectkey=1";
	}
	
	
}
