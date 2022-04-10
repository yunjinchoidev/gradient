package project5.attendance;

import java.util.List;

import org.springframework.stereotype.Repository;

import project5.member.MemberSch;
import project5.member.MemberVO;

@Repository
public interface AttendanceDao {
	
	public void attendanceWrite(MemberVO vo);
	public List<MemberVO> listWithPagingNotComplte(MemberSch sch);
	public int totCnt(MemberSch sch);
	
	public List<MemberVO> listWithPagingComplete(MemberSch sch);
	public int totCntComplete(MemberSch sch);
	
	

}
