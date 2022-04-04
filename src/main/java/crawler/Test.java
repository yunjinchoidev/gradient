package crawler;

import java.io.IOException;
import java.text.ParseException;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

public class Test {
	public static void main(String[] args) throws ParseException {
		String URL = "https://news.naver.com/main/list.naver?mode=LS2D&mid=shm&sid1=105&sid2=230";
		Document doc;

		try {
			doc = Jsoup.connect(URL).get();
			Elements elem = doc.select(".date");
			String[] str = elem.text().split(" ");

			Elements todaylist = doc.select("#main_content > div.list_body.newsflash_body > ul.type06_headline > li");
			int i=0;
			for (Element element : todaylist) {
				  i++;
                System.out.println(i+"::"+element);
              
            }
			
			String a =todaylist.text();
			
			
			
			
			
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}
}
