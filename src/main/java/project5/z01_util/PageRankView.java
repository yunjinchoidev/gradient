package project5.z01_util;

import java.io.IOException;
import java.io.OutputStream;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.web.servlet.view.document.AbstractXlsView;




public class PageRankView extends AbstractXlsView {

	@Override
	protected void buildExcelDocument(Map<String, Object> model,Workbook workbook,
			HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		response.setHeader("Content-Disposition", "attachment; filename=\"pagerank.xls\";");
		Sheet sheet = createFirstSheet( workbook);
		createColumnLabel(sheet);
		List<PageRank> pageRanks = (List<PageRank>) model.get("pageRankList");
		int rowNum = 1;
		for (PageRank rank : pageRanks) {
			createPageRankRow(sheet, rank, rowNum++);
		}		

	}	
	


	@Override
	protected void renderWorkbook(Workbook workbook, HttpServletResponse response) throws IOException {
		// TODO Auto-generated method stub
		ServletOutputStream out = response.getOutputStream();
		workbook.write(out);
		out.close();
		
		
	}



	private Sheet createFirstSheet(Workbook workbook) {
		//workbook.createSheet()
		Sheet sheet = workbook.createSheet();
		workbook.setSheetName(0, "페이지 순위");
		sheet.setColumnWidth(1, 256 * 20);
		return sheet;
	}

	private void createColumnLabel(Sheet sheet) {
		Row firstRow = sheet.createRow(0);
		Cell cell = firstRow.createCell(0);
		cell.setCellValue("순위");

		cell = firstRow.createCell(1);
		cell.setCellValue("페이지");
	}

	private void createPageRankRow(Sheet sheet, PageRank rank,
			int rowNum) {
		Row row = sheet.createRow(rowNum);
		Cell cell = row.createCell(0);
		cell.setCellValue(rank.getRank());

		cell = row.createCell(1);
		cell.setCellValue(rank.getPage());

	}





}
