package project5.favorite;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Repository;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import project5.myWork.MenubarVO;
import project5.myWork.MyWorkService;

@Controller
public class FavoriteController {

	
	@Autowired
	FavoriteService service;
	
	@Autowired
	MyWorkService service2;
	
	
	@RequestMapping("/favoriteList.do")
	public String favoriteList(Model d) {
		d.addAttribute("list", service.list());
		return "pageJsonReport";
	}

	@RequestMapping("/favoriteInsert.do")
	public String favoriteAdd(Model d, String menubar) {
		service.insert(menubar);
		d.addAttribute("psc","favoriteInsertSuccess");
		return "pageJsonReport";
	}
	
	
	
	@RequestMapping("/favoriteDelete.do")
	public String favoriteDelete(Model d, String menubar) {
		service.delete(menubar);
		d.addAttribute("psc","favoriteDeleteSuccess");
		return "pageJsonReport";
	}
	
	
	
	
	
	
	
}
