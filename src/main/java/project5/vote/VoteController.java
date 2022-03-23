package project5.vote;

import org.aspectj.internal.lang.annotation.ajcDeclareEoW;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import oracle.net.aso.d;
import project5.project.ProjectService;

@Controller
public class VoteController {

	@Autowired
	VoteService service;

	@Autowired
	ProjectService service2;

	// 투표 리스트
	@RequestMapping("/voteList.do")
	public String voteList(Model d) {
		d.addAttribute("list", service.list());
		return "WEB-INF\\views\\vote\\list.jsp";
	}

	@RequestMapping("/voteWriteForm.do")
	public String voteWriteForm(Model d) {
		d.addAttribute("pjList", service2.list());
		return "WEB-INF\\views\\vote\\writeForm.jsp";
	}

	@RequestMapping("/voteWrite.do")
	public String voteWrite(Model d, VoteVO vo) {
		service.insert(vo);
		return "forward:/projectHome.do?projectkey=1";
	}

	@RequestMapping("/voteGet.do")
	public String voteGet(Model d, VoteVO vo) {
		d.addAttribute("get", service.get(vo.getVotekey()));
		return "WEB-INF\\views\\vote\\get.jsp";
	}

	@RequestMapping("/voteResult.do")
	public String voteResult(Model d, VoteVO vo) {
		d.addAttribute("get", service.get(vo.getVotekey()));
		return "WEB-INF\\views\\vote\\result.jsp";
	}
	
	

	
	// 투표를 하는 행위
	@RequestMapping("/voting.do")
	@ResponseBody
	public String voting(Model d, VoteVO vo) {
		System.out.println("voteItem1 : "+vo.getVoteItem1());
		System.out.println("voteItem2 : "+vo.getVoteItem2());
		System.out.println("voteItem3 : "+vo.getVoteItem3());
		System.out.println("voteItem4 : "+vo.getVoteItem4());
		System.out.println("voteItem5 : "+vo.getVoteItem5());
		service.voting(vo);
		d.addAttribute("psc", "voteSuccess");
		return "success";
		//return "forward:/projectHome.do?projectkey=1";
	}
	
	
	
	
	
	
	
	
	
	
	

}
