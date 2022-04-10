package project5.multiLang;

import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.LocaleResolver;

@Controller
public class A12_MultiLangCtrl {
	// 컨테이너에 선언된 언어선택 객체..
	@Autowired(required=false)
	private LocaleResolver localeResolver;
	
	// 1. 초기화면 호출.
	@GetMapping("multi.do")
	public String multi() {
		return "WEB-INF\\views\\member\\a12_multiLanguage.jsp";
	}
	
	
	
	// 2. 언어 선택에 따른 변환처리.
	@GetMapping("choiceLan.do")
	public String choide(@RequestParam("lang") String lang,
			HttpServletRequest request,
			HttpServletResponse response) {
		System.out.println("선택한 언어:"+lang);
		Locale locale = new Locale(lang);
		localeResolver.setLocale(request, response, locale);
		return "WEB-INF\\views\\member\\login.jsp";
	}

	// 2. 언어 선택에 따른 변환처리.
	@GetMapping("choiceLan2.do")
	public String choiceLan2(@RequestParam("lang") String lang,
			HttpServletRequest request,
			HttpServletResponse response) {
		System.out.println("선택한 언어:"+lang);
		Locale locale = new Locale(lang);
		localeResolver.setLocale(request, response, locale);
		return "WEB-INF\\views\\main.jsp";
	}
}
