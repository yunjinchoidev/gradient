package project5.z01_util;

import java.util.Arrays;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

// 
@Controller
public class PageRankStatController2 {

	
	@RequestMapping("/pagestat/rank2")
	public String pageRank(Model model) {
		List<PageRank2> pageRanks2 = Arrays.asList(
				new PageRank2("1", "/board/humor/1011"),
				new PageRank2("1", "/board/notice/12"),
				new PageRank2("1", "/board/phone/190")
				);
		model.addAttribute("pageRankList", pageRanks2);
		return "pageRank";
	}

	@RequestMapping("/pagestat/rankreport2")
	public String pageRankReport(Model model) {
		List<PageRank2> pageRanks2 = Arrays.asList(
				new PageRank2("이름", "/board/humor/1011"),
				new PageRank2("휴가 이유", "/board/notice/12"),
				new PageRank2("상세 설명", "/board/phone/190")
				);
		model.addAttribute("pageRankList", pageRanks2);
		return "pageReport";
	}
}
