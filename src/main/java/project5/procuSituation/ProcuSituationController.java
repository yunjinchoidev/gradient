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
	
	@RequestMapping("/procuSituationList.do")
	public String procuSituationDetail(Model d, ProcuSituationSch sch, int projectkey) {
		d.addAttribute("blist", service.listWithPaging(sch));
		d.addAttribute("project", service2.get(projectkey));
		return "WEB-INF\\views\\procuSituation\\list.html";
	}
	
	
	
	
	
	@RequestMapping("/procuSituationData.do")
	public String listTEST(Model d, ProcuSituationSch sch) {
		d.addAttribute("blist", service.listWithPaging(sch));
		d.addAttribute("procuSituationSch2", sch);
		return "pageJsonReport";
	}

	
	
	@RequestMapping("/procuSituationWriteForm.do")
	public String procuSituationWriteForm(Model d, ProcuSituationVO vo) {
		d.addAttribute("projectList",service2.list());
		return "WEB-INF\\views\\procuSituation\\writeForm.jsp";
	}
	
	@RequestMapping("/procuSituationWrite.do")
	public String procuSituationWrite(Model d, ProcuSituationVO vo) {
		service.insert(vo);
		d.addAttribute("msg", "procuSituationWrite");
		d.addAttribute("project", service2.get(vo.getProjectkey()));
		return "WEB-INF\\views\\procuSituation\\writeForm.jsp";
	}
	
	
	
	
	
	
	
}
