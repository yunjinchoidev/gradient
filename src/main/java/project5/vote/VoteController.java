package project5.vote;

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
		return "WEB-INF\\views\\vote\\Result.jsp";
	}

	@RequestMapping("/voting.do")
	@ResponseBody
	public String voting(Model d, String voteItem1) {
		System.out.println(voteItem1);
		//System.out.println(vo.getVoteItem2());
		//service.voting(vo);
		d.addAttribute("psc", "voteSuccess");
		
		return "success";
		//return "forward:/projectHome.do?projectkey=1";
	}
	
	
	
	
	
	
	
	
	
	

}
