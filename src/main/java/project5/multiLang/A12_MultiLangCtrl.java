package project5.multiLang;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class A12_MultiLangCtrl {

	@GetMapping("/multi.do")
	public String multi() {
		return "multiLanguage/a12_multiLanguage";
	}
}
