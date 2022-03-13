package project5.noticeReply;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class NoticeReplyService {

	private static final Logger log = LoggerFactory.getLogger(NoticeReplyService.class);

	@Autowired
	private NoticeReplyDao mapper;

	public int register(NoticeReplyVO vo) {
		log.info("register......" + vo);
		return mapper.insert(vo);

	}

	public NoticeReplyVO get(int rno) {

		log.info("get......" + rno);

		return mapper.read(rno);

	}

	public int modify(NoticeReplyVO vo) {

		log.info("modify......" + vo);

		return mapper.update(vo);

	}

	public int remove(int rno) {

		log.info("remove...." + rno);

		return mapper.delete(rno);

	}

	/*
	 * @Override public List<NoticeReplyVO> getList(Criteria cri, Long bno) {
	 * 
	 * log.info("get Reply List of a Board " + bno);
	 * 
	 * return mapper.getListWithPaging(cri, bno);
	 * 
	 * }
	 * 
	 * @Override public ReplyPageDTO getListPage(Criteria cri, Long bno) {
	 * 
	 * return new ReplyPageDTO(mapper.getCountByBno(bno),
	 * mapper.getListWithPaging(cri, bno)); }
	 */
}
