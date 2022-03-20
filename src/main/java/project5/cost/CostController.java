package project5.cost;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class CostController {
	
	@Autowired
	CostService service;
	
	@RequestMapping("/cost.do")
	public String getCostList(CostSch sch, Model d,
							@RequestParam(name="sch",required=false) String schS) {
		//게시글 목록
		d.addAttribute("costlist",service.getCostList(sch));
		if(schS!=null && schS!="") {
			d.addAttribute("costlist",service.schCostList(sch));
		}	
		
		return "cost/list";
	}
	
	@RequestMapping("/writecost.do")
	public String insertCost(String prjkeyS,Model d) {
		//프로젝트 목록
		d.addAttribute("prjlist",service.getPrjList());
		//예산 구분 목록
		d.addAttribute("cslist",service.getCostSort());
		//프로젝트 예산
		if(prjkeyS !=null) {
			int prjkey = Integer.parseInt(prjkeyS);
			System.out.println("프로젝트키:"+prjkey);
			d.addAttribute("prjkey",prjkey);
			d.addAttribute("prjcost",service.getPrjCost(prjkey));	
		}else {
			int prjkey = 1;
			d.addAttribute("prjkey",prjkey);
			d.addAttribute("prjcost",service.getPrjCost(prjkey));
		}
		
		return "cost/writecost";
	}
	
	@RequestMapping("/insertcost.do")
	public String insPrjCost(MultiRowCost ins,CostList clins, Model d) {
		service.insPrjCost(ins);
		service.insCostList(clins);
		d.addAttribute("msg","등록되었습니다");
		return "forward:/writecost.do";
	}
	
	@RequestMapping("/detailcost.do")
	public String detailCost(int prjkey,Model d) {
		d.addAttribute("prjInfo",service.prjDetailInfo(prjkey));
		d.addAttribute("cdlist",service.costDetailList(prjkey));
		d.addAttribute("amountpay",service.amountPay(prjkey));
		return "cost/Detail";
	}
	

	
	
	
	
}
