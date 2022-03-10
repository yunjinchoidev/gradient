package project5.risk;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class RiskController {
	
	@Autowired
	private RiskService service;
	
	@RequestMapping("/risk.do")
	public String riskFrm(Model d) {
		d.addAttribute("risklist",service.riskboardlist());
		d.addAttribute("prjlist",service.selectprjlist());
		return "risk/list";
	}
		
	@RequestMapping("/insertrisk.do")
	public String riskinsert(RiskVO ins, Model d) {
		d.addAttribute("msg","등록되었습니다");
		service.insertRisk(ins);
		return "risk/list";
	}

	
	
	
	
}
