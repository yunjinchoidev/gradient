package project5.quality;

import java.rmi.server.ServerCloneException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import project5.risk.RiskService;

@Controller
public class QualityController {
	
	@Autowired
	QualityService service;
	
	@RequestMapping("/qualityList.do")
	public String qualityList(Model d) {
		d.addAttribute("list", service.list());
		d.addAttribute("prjlist",service.prjlist());
		d.addAttribute("evallist", service.evallist());
		return "WEB-INF\\views\\quality\\list.jsp";
	}
	
	@RequestMapping("/qualityInsertFrom.do")
	public String qualityInsertFrom() {
		return "WEB-INF\\views\\quality\\insertForm.jsp";
	}
	
	@RequestMapping("/qualityUpdateFrom.do")
	public String qualityUpdateFrom() {
		return "WEB-INF\\views\\quality\\updateForm.jsp";
	}
	
	@RequestMapping("/qualityInsert.do")
	public String qualityInsert(QualityVO vo){
		service.insert(vo);
		return "forward:/qualityList.do";
	}
	
	
	@RequestMapping("/qualityUpdate.do")
	public String qualityUpdate(QualityVO vo){
		service.update(vo);
		return "forward:/qualityList.do";
	}
	
	@RequestMapping("/qualityDelete.do")
	public String qualityDelete(int qualitykey){
		service.delete(qualitykey);
		return "forward:/qualityList.do";
	}
	
	@RequestMapping("/qualityGet.do")
	public String qualityGet(Model d, int qualitykey){
		d.addAttribute("get", service.get(qualitykey));
		return "WEB-INF\\views\\quality\\get.jsp";
	}
	
	@RequestMapping("/evalitem.do")
	public String evaliten(Model d) {
		d.addAttribute("evallist", service.evallist());
		return "WEB-INF\\views\\quality\\evalitem.jsp";
	}
	
	@RequestMapping("/uptevallist.do")
	public String upteval(MultiQuality upt, Model d) {
		service.upteval(upt);
		d.addAttribute("msg","수정완료되었습니다");
		return "forward:/evalitem.do";
	}
	
	@RequestMapping("/qualitypass.do")
	public String qualitypass(QualityVO upt, Model d) {
		service.qualitypass(upt);
		d.addAttribute("msg", "합격처리되었습니다");
		return "forward:/qualityList.do";
	}
	
	
	
	
	

	
	
	
	
	

	
	
	
	
}
