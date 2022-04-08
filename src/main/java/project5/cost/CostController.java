package project5.cost;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import project5.project.ProjectService;

@Controller
public class CostController {
	
	@Autowired
	CostService service;
	
	@Autowired
	ProjectService service2;
	
	@RequestMapping("/cost.do")
	public String getCostList(CostSch sch, Model d,
							@RequestParam(name="sch",required=false) String schS) {
		//게시글 목록
		d.addAttribute("costlist",service.getCostList(sch));
		if(schS!=null && schS!="") {
			d.addAttribute("costlist",service.schCostList(sch));
		}	
		
		return "WEB-INF\\views\\cost\\list.jsp";
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
			int prjkey = 30001;
			int prjkey2 = 0;
			d.addAttribute("prjkey",prjkey);
			d.addAttribute("prjkey2",prjkey2);
			d.addAttribute("prjcost",service.getPrjCost(prjkey));
		}
		
		return "WEB-INF\\views\\cost\\writecost.jsp";
	}
	
	@RequestMapping("/insertcost.do")
	public String insPrjCost(MultiRowCost ins,CostList clins, Model d) {
		service.insPrjCost(ins);
		service.insCostList(clins);
		d.addAttribute("msg","등록되었습니다");
		return "forward:/cost.do";
	}
	
	@RequestMapping("/detailcost.do")
	public String detailCost(int prjkey,Model d) {
		d.addAttribute("prjInfo",service.prjDetailInfo(prjkey));
		d.addAttribute("cdlist",service.costDetailList(prjkey));
		d.addAttribute("amountpay",service.amountPay(prjkey));
		return "WEB-INF\\views\\cost\\Detail.jsp";
	}
	
	@RequestMapping("/uptcostassign.do")
	public String costConfirm(int prjkey, Model d) {
		service.costConfirm(prjkey);
		d.addAttribute("msg","승인되었습니다");
		return "WEB-INF\\views\\cost\\Detail.jsp";
	}
	
	@RequestMapping("/delCost.do")
	public String delCost(int prjkey, Model d) {
		service.delCost(prjkey);
		d.addAttribute("msg","삭제되었습니다");
		return "WEB-INF\\views\\cost\\Detail.jsp";
	}
	
	@RequestMapping("/uptcostfrm.do")
	public String uptCostFrm(int prjkey, Model d) {
		//프로젝트 정보
		d.addAttribute("prjInfo",service.prjDetailInfo(prjkey));
		//예산 구분 목록
		d.addAttribute("cslist",service.getCostSort());
		// 프로젝트 예산 정보
		d.addAttribute("cdlist",service.costDetailList(prjkey));
		// 프로젝트 예산 금액
		d.addAttribute("prjkey",prjkey);
		// 프로젝트 최대 인덱스
		d.addAttribute("maxindex",service.getMaxIndex(prjkey));
		d.addAttribute("prjcost",service.getPrjCost(prjkey));
		return "WEB-INF\\views\\cost\\uptcost.jsp";
	}
	
	@RequestMapping("/uptcost.do")
	public String uptPrjCost(MultiRowCost upt, Model d) {
		d.addAttribute("msg","수정되었습니다");
		service.uptPrjCost(upt);
		return "forward:/uptcostfrm.do";
	}
	
	@RequestMapping("/delcostdetail.do")
	public String delCostList(CostDetailInfo del, Model d) {
		service.delCostList(del);
		d.addAttribute("msg","삭제되었습니다");
		return "forward:/uptcostfrm.do";
	}
	

	
	
	
	
}
