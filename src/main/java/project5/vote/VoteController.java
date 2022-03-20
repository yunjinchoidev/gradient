package project5.vote;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class VoteController {

	@RequestMapping("/voteList.do")
	public String voteList() {
		return "vote/list";
	}

	@RequestMapping("/voteWriteForm.do")
	public String voteMakeForm(Model d) {
		
		return "vote/writeForm";
	}

}
