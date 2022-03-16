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
		return "quality/list";
	}
	
	@RequestMapping("/qualityInsertFrom.do")
	public String qualityInsertFrom() {
		return "quality/insertForm";
	}
	
	@RequestMapping("/qualityUpdateFrom.do")
	public String qualityUpdateFrom() {
		return "quality/updateForm";
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
		return "/quality/get";
	}
	
	
	
	
	
	
	
	
	
	
	
	

	
	
	
	
}
