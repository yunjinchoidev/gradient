package project5.contract;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import project5.communication.minutesVO;

@Controller
@RequestMapping("/contract.do")
public class ContractController {

	@Autowired
	ContractService service;
	
	// http://localhost:7080/project5/contract.do?method=list
	@RequestMapping(params="method=list")
	public String attendance(Model d) {
		return "WEB-INF\\views\\contract\\contractList.jsp";
	}
	
	@RequestMapping(params="method=insertFrm")
	public String insContractFrm(Model d) {
		return "WEB-INF\\views\\contract\\contractWrite.jsp";
	}
	
	@RequestMapping(params="method=insert")
	public String insContract(ContractVO ins, Model d) {
		d.addAttribute("msg", service.insContract(ins));
		return "WEB-INF\\views\\contract\\contractWrite.jsp";
	}	
	
	
	
	
	
}
