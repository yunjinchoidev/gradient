package project5.output;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import project5.department.DepartmentSevice;
import project5.project.ProjectService;
import project5.workSort.WorkSortService;

@Controller
public class OutputController {
	
	@Autowired
	OutputService service;
	
	@Autowired
	ProjectService service2;
	
	@Autowired
	WorkSortService service3;
	
	@Autowired
	DepartmentSevice service4;
	
	@RequestMapping("/output.do")
	public String output(Model d) {
		d.addAttribute("list", service.list());
		d.addAttribute("pjList", service2.list());
		return "WEB-INF\\views\\output\\list.jsp";
	}

	@RequestMapping("/outputGet.do")
	public String outputGet(Model d, int outputkey) {
		d.addAttribute("get", service.get(outputkey));
		return "WEB-INF\\views\\output\\get.jsp";
	}

	@RequestMapping("/outputWriteForm.do")
	public String outputWriteForm(Model d) {
		d.addAttribute("pjList", service2.list());
		d.addAttribute("workSort", service3.list());
		d.addAttribute("dlist", service4.list());
		return "WEB-INF\\views\\output\\writeForm.jsp";
	}

	@RequestMapping("/outputWrite.do")
	public String outputWriteForm(Model d, OutputVO vo) {
		service.insert(vo);
		System.out.println("산출물 게시판에 등록완료");
		return "forward:/output.do";
	}
	
	
	@RequestMapping("/outputDelete.do")
	public String outputDelete(Model d, OutputVO vo) {
		service.delete(vo.getOutputkey());
		return "forward:/output.do";
	}
	
	@RequestMapping("/outputEvaluation.do")
	public String outputEvaluation(Model d, OutputVO vo) {
		service.outputEvaluation(vo);
		return "forward:/output.do";
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
