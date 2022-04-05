package project5.crawling;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.forwardedUrl;

import java.io.IOException;

import org.aspectj.apache.bcel.generic.ReturnaddressType;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import oracle.net.aso.p;

@Controller
public class CrawlingController {

	@RequestMapping("/crawling.do")
	public String crawling(Model d) {


		String URL = "https://news.naver.com/main/list.naver?mode=LS2D&mid=shm&sid1=105&sid2=230";
		Document doc;

		try {
			doc = Jsoup.connect(URL).get();
			Elements elem = doc.select(".lede");
			Elements elem2 = doc.getElementsByAttributeValue("class", "lede");
			
			
			
			System.out.println(elem);
			d.addAttribute("elem", elem.text());		
			
			int i=0;
			for(Element e :elem ) {
				i++; 
				d.addAttribute(i+"st", e.text());
			}
			
			
			
			
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		
		return "pageJsonReport";
	}

}
