package project5.quality;

import java.rmi.server.ServerCloneException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.type.WhenNoDataTypeEnum;

import project5.risk.RiskService;

@Controller
public class QualityController {
	
	@Autowired
	QualityService service;
	
	
	@RequestMapping("/qualityList.do")
	public String qualityList(Model d, QualitySch sch) {
		d.addAttribute("list", service.getList(sch));
		// 품질 리스트 - 장훈주 start
		d.addAttribute("prjlist",service.prjlist());
		d.addAttribute("evallist", service.evallist());
		// 품질 리스트 - 장훈주 end
		return "WEB-INF\\views\\quality\\list.jsp";
	}
	
	@RequestMapping("/qualityInsertFrom.do")
	public String qualityInsertFrom() {
		return "WEB-INF\\views\\quality\\insertForm.jsp";
	}
	
	@RequestMapping("/qualityUpdateFrom.do")
	public String qualityUpdateFrom(Model d, int qualitykey) {
		d.addAttribute("get", service.get(qualitykey));
		return "WEB-INF\\views\\quality\\update.jsp";
	}
	
	@RequestMapping("/qualityInsert.do")
	public String qualityInsert(QualityVO vo){
		service.insert(vo);
		return "forward:/qualityList.do";
	}
	
	
	@RequestMapping("/qualityUpdate.do")
	public String qualityUpdate(QualityVO vo){
		service.update(vo);
		return "forward:/qualityList.do";
	}
	
	@RequestMapping("/qualityDelete.do")
	public String qualityDelete(int qualitykey){
		service.delete(qualitykey);
		return "forward:/qualityList.do";
	}
	
	@RequestMapping("/qualityGet.do")
	public String qualityGet(Model d, int qualitykey){
		d.addAttribute("get", service.get(qualitykey));
		return "WEB-INF\\views\\quality\\get.jsp";
	}
	// 품질 장훈주 start
		// 품질 평가 
		@RequestMapping("/evalitem.do")
		public String evaliten(Model d) {
			d.addAttribute("evallist", service.evallist());
			return "WEB-INF\\views\\quality\\evalitem.jsp";
		}
		
		// 품질 평가 수정
		@RequestMapping("/uptevallist.do")
		public String upteval(MultiQuality upt, Model d) {
			service.upteval(upt);
			d.addAttribute("msg","수정완료되었습니다");
			return "forward:/evalitem.do";
		}
		
		// 품질 합격
		@RequestMapping("/qualitypass.do")
		public String qualitypass(QualityVO upt, Model d) {
			service.qualitypass(upt);
			d.addAttribute("msg", "합격처리되었습니다");
			return "forward:/qualityList.do";
		}
		
		// 인증서(PDF) 출력 -> JasperReport
		@RequestMapping(value = "/jasper.do", method = RequestMethod.GET)
		public String home(Model model, HttpServletRequest request, HttpServletResponse response,
							String prjkeyS) {
		
		String reportPath = request.getSession().getServletContext().getRealPath("/report/");
	    String folderPath = reportPath;
	    String tempath = "C:\\Users\\yunji\\git\\project5\\src\\main\\webapp\\report\\";
	    int prjkey = 0;
	    
	    if(prjkeyS != null || prjkeyS != "" ) {
	    	prjkey = Integer.parseInt(prjkeyS);
	    }
	    
			Connection conn = null;
			try {
				Class.forName("oracle.jdbc.driver.OracleDriver");
				conn = DriverManager.getConnection("jdbc:oracle:thin:@106.10.16.155:1521:xe", "scott", "tiger");
				JasperReport jasperReport = JasperCompileManager.compileReport(folderPath+"project5.jrxml");
				
				Map<String, Object> parameters = new HashMap<String, Object>();
				parameters.put("prjkey", prjkey);
				JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReport, parameters, conn);
				jasperReport.setWhenNoDataType(WhenNoDataTypeEnum.ALL_SECTIONS_NO_DETAIL);
				
	      /* html 파일로 변환합니다, 
	      JasperViewer.viewReport(jasperPrint, false);
	      를 통해 자체적으로 출력할 수 도있습니다.
	      대신 client가아닌 server에서만 jasper reports화면이 출력
	      */
				//JasperExportManager.exportReportToHtmlFile(jasperPrint, folderPath+"project5.html");
				System.out.println("폴더패스:"+folderPath);
			    System.out.println("저장패스:"+tempath);   
				//JasperExportManager.exportReportToPdfFile(jasperPrint, folderPath+"/project5.pdf");
				JasperExportManager.exportReportToPdfFile(jasperPrint, tempath+"project55.pdf");
				
			
				conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}		
		    model.addAttribute("folderPath", folderPath);
			return "forward:/jasperloading.do";
		}
		
		@RequestMapping("/certiprj.do")
		public String certiprj(Model d) {
			d.addAttribute("prjlist",service.certiprjlist());
			return "WEB-INF\\views\\quality\\certiprj.jsp";
		}
		
		@RequestMapping("/pdfview.do")
		public String pdfview() {
			
			return "WEB-INF\\views\\quality\\pdfview.jsp";
		}
		
		@RequestMapping("/jasperloading.do")
		public String loading() {
			return "WEB-INF\\views\\quality\\loading.jsp";
		}
		// 품질 장훈주 end
	
	
	
	
	

	
	
	
	
	

	
	
	
	
}
