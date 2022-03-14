package project5.noticeReply;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import lombok.AllArgsConstructor;
import project5.paging.Criteria;



@RestController
@AllArgsConstructor
public class NoticeReplyContoller {
	private static final Logger log = LoggerFactory.getLogger(NoticeReplyContoller.class);

	@Autowired
	private NoticeReplyService service;

	@PostMapping(value = "/NoticeReplyNew.do", consumes = "application/json", produces = { MediaType.TEXT_PLAIN_VALUE })
	public ResponseEntity<String> create(@RequestBody NoticeReplyVO vo) {

		log.info("ReplyVO: " + vo);
		log.info("NoticeKey: " + vo.getNoticekey());
		log.info("Reply: " + vo.getReply());
		log.info("Replyer " + vo.getReplyer());

		int insertCount = service.register(vo);

		log.info("Reply INSERT COUNT: " + insertCount);

		return insertCount == 1 ? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}

	
	
	
	
	
	
	
	
	
	@GetMapping(value = "/{rno}.do", produces = { MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE })
	public String get(@PathVariable("rno") int rno, Model d) {
		log.info("get: " + rno);
		System.out.println("대기");
		System.out.println("대기");
		System.out.println("대기");
		System.out.println("대기");
		System.out.println("대기");
		System.out.println("대기");
		System.out.println("대기");
		System.out.println("대기");
		System.out.println("대기");
		System.out.println("대기");
		System.out.println(service.get(rno));
		System.out.println("===================================");
		d.addAttribute("get",service.get(rno));
		return "pageJsonReport";
	}
	
	
	
	
	
	

	@RequestMapping(method = { RequestMethod.PUT,
			RequestMethod.PATCH }, value = "/{rno}.do", consumes = "application/json", produces = {
					MediaType.TEXT_PLAIN_VALUE })
	public ResponseEntity<String> modify(@RequestBody NoticeReplyVO vo, @PathVariable("rno") int rno) {

		vo.setRno(rno);

		log.info("rno: " + rno);
		log.info("modify: " + vo);

		return service.modify(vo) == 1 ? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);

	}

	
	
	
	
	
	
	
	@DeleteMapping(value = "/{rno}.do", produces = { MediaType.TEXT_PLAIN_VALUE })
	public ResponseEntity<String> remove(@PathVariable("rno") int rno) {

		log.info("remove: " + rno);

		return service.remove(rno) == 1 ? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);

	}

	
	
	
	
	
	
	
	 @GetMapping(value = "/pages/{noticekey}/{page}.do", 
			 produces = {
					 MediaType.APPLICATION_XML_VALUE,
					 MediaType.APPLICATION_JSON_UTF8_VALUE })
	 public ResponseEntity<List<NoticeReplyVO>> getList(
			 @PathVariable("page") int page,
			 @PathVariable("noticekey") int noticekey) {
	
		 
		 log.info("getList.................");
		 Criteria cri = new Criteria(page,10);
		// log.info(cri);
	
	 return new ResponseEntity<>(service.getList(cri, noticekey), HttpStatus.OK);
	 }

	 
	 
	 
	 
//	@GetMapping(value = "/pages/{bno}/{page}", produces = { MediaType.APPLICATION_XML_VALUE,
//			MediaType.APPLICATION_JSON_UTF8_VALUE })
//	public ResponseEntity<NoticeReplyPageDTO> getList(@PathVariable("page") int page, @PathVariable("noticekey") int noticekey) {
//
//		Criteria cri = new Criteria(page, 10);
//
//		log.info("get Reply List bno: " + bno);
//
//		log.info("cri:" + cri);
//
//		return new ResponseEntity<>(service.getListPage(cri, bno), HttpStatus.OK);
//	}

}
