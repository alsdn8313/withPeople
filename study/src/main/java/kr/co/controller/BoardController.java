package kr.co.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

import kr.co.service.BoardService;
import kr.co.vo.BoardVO;
import kr.co.vo.PageMaker;
import kr.co.vo.SearchCriteria;

@Controller
@RequestMapping("/board/*")
public class BoardController {

	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
	
	@Inject
	BoardService service;
	
	
	// 게시판 글 작성 화면
	@RequestMapping(value = "/board/writeView", method = RequestMethod.GET)
	public void writeView() throws Exception{
		logger.info("writeView");
		
	}
	
	// 게시판 글 작성
	@RequestMapping(value = "/board/write", method = RequestMethod.POST)
	public String write(BoardVO boardVO) throws Exception{
		logger.info("write");
		
		service.write(boardVO);
		
		return "redirect:/";
	}
	
	// 게시판 목록 조회
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String list(Model model, @ModelAttribute("scri") SearchCriteria scri) throws Exception{
		logger.info("list");
		
		model.addAttribute("listAll",service.listAll(scri));
		model.addAttribute("list",service.list(scri));
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(scri);
		pageMaker.setTotalCount(service.listCount(scri));
		
		model.addAttribute("pageMaker", pageMaker);
		
		return "board/list";
		
	}
	
	
	// 검색
	@RequestMapping(value = "/board/search", produces = "application/text; charset=utf8", method = RequestMethod.GET)
	@ResponseBody
	public String search(String input) throws Exception{
		logger.info("search");
		
		RestTemplate rest = new RestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.add("X-Naver-Client-Id", "q2rgNFqo261t37lqiYrf");
        headers.add("X-Naver-Client-Secret", "6WdM8Wq3mI");

        StringBuilder sb = new StringBuilder();
        String body = sb.toString();
        
        logger.info(input);
        
        //String item = "SSE-30PA";
        String item = input;
        
        Thread.sleep(30);
        
        HttpEntity<String> requestEntity = new HttpEntity<String>(body, headers);
        ResponseEntity<String> responseEntity = rest.exchange("https://openapi.naver.com/v1/search/shop.json?query="+item+"&exclue=rental:cbshop&sort=asc&display=100", HttpMethod.GET, requestEntity, String.class);
        //ResponseEntity<String> responseEntity = rest.exchange("https://openapi.naver.com/v1/search/shop.json?query="+item+"&exclue!=used&sort=asc&display=1", HttpMethod.GET, requestEntity, String.class);
        HttpStatus httpStatus = responseEntity.getStatusCode();
        int status = httpStatus.value();
        String response = responseEntity.getBody();
      
        
        System.out.println("Response status: " + status);
        System.out.println(response);

        return response;
		
	}
	
	@RequestMapping(value = "/board/excelDown")
	public void excelDownload(HttpServletResponse response, @ModelAttribute("scri") SearchCriteria scri) throws Exception{
		XSSFWorkbook wb=null;
		Sheet sheet=null;
		Row row=null;
		Cell cell=null; 
		wb = new XSSFWorkbook();
		sheet = wb.createSheet("mysheet");
		
		List<BoardVO> freeBoardList = service.excelList(scri);
		
		// row(행) 생성
		row = sheet.createRow(0); //0번째 행
		cell=row.createCell(0);
		cell.setCellValue("번호");
		cell=row.createCell(1);
		cell.setCellValue("상품명");
		cell=row.createCell(2);
		cell.setCellValue("판매처");
		cell=row.createCell(3);
		cell.setCellValue("최저가격");
		cell=row.createCell(4);
		cell.setCellValue("기존가격");
		
		for(int i=0; i < freeBoardList.size() ; i++  ) {
			row=sheet.createRow(i+1);  // '열 이름 표기'로 0번째 행 만들었으니까 1번째행부터
			int cellCount=0; //열 번호 초기화
			cell=row.createCell(cellCount++);
			cell.setCellValue(freeBoardList.get(i).getS_num());
			cell=row.createCell(cellCount++);
			cell.setCellValue(freeBoardList.get(i).getS_item());
			cell=row.createCell(cellCount++);
			cell.setCellValue(freeBoardList.get(i).getS_mall_nm());
			cell=row.createCell(cellCount++);
			cell.setCellValue(freeBoardList.get(i).getS_lprice());
			cell=row.createCell(cellCount++);
			cell.setCellValue(freeBoardList.get(i).getS_price());
			
		}
		
		//sheet.setColumnWidth(1, 3400);
		for (int i=0; i<4; i++){
			sheet.autoSizeColumn(i);
			sheet.setColumnWidth(i, (sheet.getColumnWidth(i))+(short)1024);
		}	
		
		// 컨텐츠 타입과 파일명 지정
		response.setContentType("ms-vnd/excel");
		response.setHeader("Content-Disposition", "attachment;filename=items.xlsx");  //파일이름지정.
		//response OutputStream에 엑셀 작성
		wb.write(response.getOutputStream());
	}

	
	@RequestMapping(value = "/board/insertItem", method = RequestMethod.GET)
	@ResponseBody
	public void writeItem(BoardVO boardVO) throws Exception{
		
		service.writeItem(boardVO);
	}
	
	
	@RequestMapping(value = "/board/deleteItem")
	@ResponseBody
	public void deleteItem(BoardVO boardVO) throws Exception{
		
		service.delete(boardVO);
	}
	
	
	@RequestMapping(value = "/listExcel", method = RequestMethod.GET)
	public String listExcel(Model model, @ModelAttribute("scri") SearchCriteria scri) throws Exception{
		logger.info("listExcel");
		
		model.addAttribute("listAll",service.excelList(scri));
		model.addAttribute("list",service.excelListPage(scri));
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(scri);
		pageMaker.setTotalCount(service.excelListCount(scri));
		
		model.addAttribute("pageMaker", pageMaker);
		
		return "board/searchView";
		
	}
}