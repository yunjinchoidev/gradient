package project5.procuSituation;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ProcuSituationController {

	@Autowired
	ProcuSituationService service;

	@RequestMapping("/procuSituationMain.do")
	public String procuSituationMain2(Model d, ProcuSituationSch sch) {
		d.addAttribute("blist", service.listWithPaging(sch));
		return "WEB-INF\\views\\procuSituation\\main.html";
	}
	
	@RequestMapping("/procuSituationData.do")
	public String listTEST(Model d, ProcuSituationSch sch) {
		d.addAttribute("blist", service.listWithPaging(sch));
		d.addAttribute("procuSituationSch2", sch);
		return "pageJsonReport";
	}

	@RequestMapping("procuSituationInsert.do")
	public String procuSituationInsert(Model d, ProcuSituationSch sch) {
		d.addAttribute("list", service.listWithPaging(sch));
		return "pageJsonReport";
	}
	
}
