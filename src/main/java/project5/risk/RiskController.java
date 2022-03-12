package project5.risk;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class RiskController {
	
	@Autowired
	private RiskService service;
	
	//리스크 메인
	@RequestMapping("/risk.do")
	public String riskFrm(RiskSch sch, Model d,
						  @RequestParam(name="sch",required=false) String schS) {
		//리스크 게시판 목록
		d.addAttribute("risklist",service.riskboardlist(sch));
		if(schS!=null && schS!="") {
			d.addAttribute("risklist",service.schRiskList(sch));
		}		
	//리스크 등록 - 프로젝트 목록
		d.addAttribute("prjlist",service.selectprjlist());
		return "risk/list";
	}
	
	//리스크 상세화면
	@RequestMapping("/riskdetail.do")
	public String riskdetail(int riskkey, Model d) {
		System.out.println(riskkey);
		d.addAttribute("rdlist",service.riskDetail(riskkey));
		return "risk/detail";
	}
	
	//리스크 등록
	@RequestMapping("/insertrisk.do")
	public String riskinsert(RiskVO ins, Model d) {
		d.addAttribute("msg","등록되었습니다");
		service.insertRisk(ins);
		return "risk/list";
	}
	
	//리스크 삭제
	@RequestMapping("/delrisk.do")
	public String riskdel(int riskkey, Model d) {
		d.addAttribute("msg","삭제되었습니다");
		service.delRisk(riskkey);
		return "risk/detail";
	}
	
	//리스크 수정화면
		@RequestMapping("/riskuptdetail.do")
		public String riskuptForm(int riskkey, Model d) {
			System.out.println(riskkey);
			d.addAttribute("rdlist",service.riskDetail(riskkey));
			//리스크 등록 - 프로젝트 목록
			d.addAttribute("prjlist",service.selectprjlist());
			return "risk/uptdetail";
		}

	//리스크 수정
	@RequestMapping("/uptrisk.do")
	public String riskupt(RiskVO upt, int riskkey, Model d) {
		d.addAttribute("msg","수정되었습니다");
		service.uptRisk(upt);
		return "risk/uptdetail";
	}
	
	
	
}
