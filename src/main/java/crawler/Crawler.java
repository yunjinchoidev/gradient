package crawler;

import java.io.IOException;

import org.jsoup.Connection;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

public class Crawler {
	 public static void main(String args[]){
	        // 1. 수집 대상 URL
	        String URL = "https://heodolf.tistory.com/18";
	 
	        try {
	            // 2. Connection 생성
	            Connection conn = Jsoup.connect(URL);
	 
	            // 3. HTML 파싱.
	            Document html = conn.get(); // conn.post();
	            
	            // 4. 요소 탐색
	            // 4-1. Attribute 탐색
	            System.out.println("[Attribute 탐색]");
	            Elements fileblocks = html.getElementsByClass("fileblock");
	            for( Element fileblock : fileblocks ) {
	                
	                Elements files = fileblock.getElementsByTag("a");
	                for( Element elm : files ) {
	                String text = elm.text();
	                String href = elm.attr("href");
	                
	                System.out.println( text+" > "+href );
	                }
	            }
	            
	            // 4-2. CSS Selector 탐색
	            System.out.println("\n[CSS Selector 탐색]");
	            Elements files = html.select(".fileblock a");
	            for( Element elm : files ) {
	                String text = elm.text();
	                String href = elm.attr("href");
	                
	                System.out.println( text+" > "+href );
	            }
	        } catch (IOException e) {
	            e.printStackTrace();
	        }
	    }
}
