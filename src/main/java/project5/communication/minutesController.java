package project5.communication;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import project5.project.ProjectService;

@Controller
@RequestMapping("/minutes.do")
public class minutesController {
	@Autowired
	private minutesService service;
	
	@Autowired
	ProjectService service2;
	
	// http://localhost:7080/project5/main.do
	// http://localhost:7080/project5/minutes.do?method=list
	@RequestMapping(params="method=list")
	public String minutesList(minutesSch sch, Model d) {
		d.addAttribute("mList", service.minutesList(sch));
		d.addAttribute("prjList", service.selectPrjList());
		d.addAttribute("dptList", service.selectDptList());
		d.addAttribute("pjList", service2.list());
		return "WEB-INF\\views\\communication\\minutesList.jsp";
	}

	@RequestMapping(params="method=detail")
	public String minutesDetail(int minutesKey, Model d) {
		d.addAttribute("m",service.getMinutes(minutesKey));
		return "WEB-INF\\views\\communication\\minutesDetail.jsp";
	}

	// http://localhost:8080/project5/minutes.do?method=insertFrm
	@RequestMapping(params="method=insertFrm")
	public String insMinutesFrm(Model d) {
		d.addAttribute("prjList", service.selectPrjList());
		d.addAttribute("dptList", service.selectDptList());
		return "WEB-INF\\views\\communication\\minutesWrite.jsp";
	}

	@RequestMapping(params="method=insert")
	public String insMinutes(minutesVO ins, Model d) {
		d.addAttribute("msg", service.insMinutes(ins));
		return "WEB-INF\\views\\communication\\minutesWrite.jsp";
	}	

	@RequestMapping(params="method=updateFrm")
	public String uptMinutes(int minutesKey, Model d) {
		d.addAttribute("m", service.getMinutes(minutesKey));
		d.addAttribute("prjList", service.selectPrjList());
		d.addAttribute("dptList", service.selectDptList());
		return "WEB-INF\\views\\communication\\minutesUpdate.jsp";
	}

	@RequestMapping(params="method=update")
	public String uptMinutes(minutesVO upt, Model d) {
		service.uptMinutes(upt);
		d.addAttribute("msg","수정되었습니다.");
		return "forward:/minutes.do?method=detail";
	}

	@RequestMapping(params="method=delete")
	public String delMinutes(int minutesKey, Model d) {
		service.delMinutes(minutesKey);
		d.addAttribute("msg","삭제되었습니다.");
		return "forward:/minutes.do?method=list";
	}
}