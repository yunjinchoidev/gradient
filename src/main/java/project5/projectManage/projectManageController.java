package project5.projectManage;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class projectManageController {

	@Autowired
	ProjectManageService service;
	
	
	@RequestMapping("/projectManageMain.do")
	public String projectManageMain(Model d) {
		d.addAttribute("list", service.list());
		return "/projectManage/main";
	}

	@RequestMapping("/progressUpdate.do")
	public String progressUpdate(Model d, ProjectManageVO vo) {
		service.progressUpdate(vo);
		return "/projectManage/main";
	}
	

	@RequestMapping("/projectManageGet.do")
	public String projectManageGet(Model d, ProjectManageVO vo) {
		d.addAttribute("project", service.get(vo.getProjectkey()));
		return "/projectManage/get";
	}
	
	
	
	
	
	
	
	
	
	
	
}
