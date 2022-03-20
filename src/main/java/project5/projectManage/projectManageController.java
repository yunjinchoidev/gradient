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
		System.out.println("변경합니다.");
		return "forward:/projectManageMain.do";
	}
	

	@RequestMapping("/projectManageGet.do")
	public String projectManageGet(Model d, ProjectManageVO vo) {
		d.addAttribute("get", service.get(vo.getProjectkey())); //프로젝트 키를 통해 프로젝트 정보 조회
		return "/projectManage/get";
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
