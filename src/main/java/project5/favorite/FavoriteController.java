package project5.favorite;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Repository;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class FavoriteController {

	
	@Autowired
	FavoriteService service;
	
	
	@RequestMapping("/favoriteList.do")
	public String favoriteList(Model d) {
		d.addAttribute("list", service.list());
		return "pageJsonReport";
	}

	@RequestMapping("/favoriteAdd.do")
	public String favoriteAdd(Model d, FavoriteVO vo) {
		return "pageJsonReport";
	}
	
	
	
	
	
	
	
}
