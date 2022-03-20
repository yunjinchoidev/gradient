package project5.member_project;

import java.util.List;

import org.springframework.stereotype.Repository;

@Repository
public interface Member_ProjectDao {
	public List<Member_ProjectVO> list();
	public List<Member_ProjectVO> get(int memberkey);
	public List<Integer> getProjectkey(int memberkey);
	
}
