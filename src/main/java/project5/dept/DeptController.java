package project5.dept;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class DeptController {
	
	@Autowired
	DeptService service;
	
	@RequestMapping("/deptList.do")
	public String deptList(Model d) {
		d.addAttribute("list", service.getList());
		return "dept/list";
	}
	
	
	
}
