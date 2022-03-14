package project5.risk;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import project5.member.MemberVO;

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
		//게시글 정보
		d.addAttribute("rdlist",service.riskDetail(riskkey));
		//댓글 정보
		d.addAttribute("commlist",service.getCommList(riskkey));
		//리스크 키
		d.addAttribute("riskkey",riskkey);
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
	
	// 댓글 등록
	@RequestMapping("/insertcomm.do")
	public String insertComm(InsRiskcomm ins, Model d) {
		d.addAttribute("commmsg","댓글이 작성되었습니다");
		service.insertcomm(ins);
		return "risk/detail";
	}
	
	// 답글 등록
	@RequestMapping("/insertrecomm.do")
	public String insertreComm(InsRiskcomm ins, Model d) {
		d.addAttribute("commmsg","답글이 작성되었습니다");
		service.insertrecomm(ins);
		return "risk/detail";
	}
	
	// 댓글 삭제
	@RequestMapping("/delriskcomm.do")
	public String delcomm(int rcommkey, Model d) {
		d.addAttribute("commmsg","댓글이 삭제되었습니다");
		service.delcomm(rcommkey);
		return "risk/detail";
	}
	
	//답글 삭제
	@RequestMapping("/delriskrecomm.do")
	public String delrecomm(int rrecommkey, Model d) {
		d.addAttribute("commmsg","답글이 삭제되었습니다");
		service.delrecomm(rrecommkey);
		return "risk/detail";
	}
}
