package project5.procuSituation;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import project5.project.ProjectService;

@Controller
public class ProcuSituationController {

	@Autowired
	ProcuSituationService service;

	@Autowired
	ProjectService service2;
	
	@RequestMapping("/procuSituationMain.do")
	public String procuSituationMain(Model d, ProcuSituationSch sch, int projectkey) {
		d.addAttribute("blist", service.listWithPaging(sch));
		d.addAttribute("project", service2.get(projectkey));
		return "WEB-INF\\views\\procuSituation\\main.jsp";
	}

	@RequestMapping("/procuSituationMain2.do")
	public String procuSituationMain2(Model d, ProcuSituationSch sch, int projectkey) {
		d.addAttribute("blist", service.listWithPaging(sch));
		d.addAttribute("project", service2.get(projectkey));
		return "WEB-INF\\views\\procuSituation\\main2.jsp";
	}
	
	
	@RequestMapping("/procuSituationDetail.do")
	public String procuSituationDetail(Model d, ProcuSituationSch sch, int projectkey) {
		d.addAttribute("blist", service.listWithPaging(sch));
		d.addAttribute("project", service2.get(projectkey));
		return "WEB-INF\\views\\procuSituation\\detail.html";
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
