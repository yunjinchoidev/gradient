package project5.vacation;

import java.util.List;

import org.springframework.stereotype.Repository;

@Repository
public interface VacationDao {
	public List<VacationVO> list();
	public void insert(VacationVO vo);
}
