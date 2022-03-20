package project5.member_project;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

@Service
public class Member_ProjectService {
	@Autowired
	Member_ProjectDao dao;
	
	public List<Member_ProjectVO> list(){
		return dao.list();
	}

	public List<Member_ProjectVO> get(int memberkey){
		return dao.get(memberkey);
	}
	
	public List<Integer> getProjectkey(int memberkey){
		return dao.getProjectkey(memberkey);
	}
	
	
}
