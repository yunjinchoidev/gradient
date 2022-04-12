package project5.z01_util;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class A01_DownLoadController {
	@RequestMapping("/download.do")
	public String download(@RequestParam("fname") String fname, Model d) {
		d.addAttribute("downloadfile", fname);
		return "download";
	}
}
