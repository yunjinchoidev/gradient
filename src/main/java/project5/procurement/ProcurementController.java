package project5.procurement;

import java.rmi.server.ServerCloneException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import project5.risk.RiskService;

@Controller
public class ProcurementController {
	
	@Autowired
	ProcurementService service;
	
	@RequestMapping("/procurementList.do")
	public String procurementList(Model d) {
		d.addAttribute("list", service.list());
		return "procurement/list";
	}
	
	@RequestMapping("/procurementInsertFrom.do")
	public String procurementInsertFrom() {
		return "procurement/insertForm";
	}
	
	@RequestMapping("/procurementUpdateFrom.do")
	public String procurementUpdateFrom() {
		return "procurement/updateForm";
	}
	
	@RequestMapping("/procurementInsert.do")
	public String procurementInsert(ProcurementVO vo){
		service.insert(vo);
		return "fprocurement/procurementList.do";
	}
	
	
	@RequestMapping("/procurementUpdate.do")
	public String procurementUpdate(ProcurementVO vo){
		service.update(vo);
		return "forward:/procurementList.do";
	}
	
	@RequestMapping("/procurementDelete.do")
	public String procurementDelete(int procurementkey){
		service.delete(procurementkey);
		return "forward:/procurementList.do";
	}
	
	@RequestMapping("/procurementGet.do")
	public String procurementGet(Model d, int procurementkey){
		d.addAttribute("get", service.get(procurementkey));
		return "/procurement/get";
	}
	
	
	
	
	
	
	
	
	
	
	
	

	
	
	
	
}