package project5.cost;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class CostController {
	
	@Autowired
	CostService service;
	
	@RequestMapping("/cost.do")
	public String getCostList(Model d) {
		//게시글 목록
		d.addAttribute("costlist",service.getCostList());
		
		return "cost/list";
	}
	@RequestMapping("/writecost.do")
	public String insertCost(Model d) {
		//프로젝트 목록
		d.addAttribute("prjlist",service.getPrjList());
		return "cost/writecost";
	}

	
	
	
	
}
