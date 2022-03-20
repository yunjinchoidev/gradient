package project5.workSort;

import java.util.List;

import org.springframework.stereotype.Repository;

@Repository
public interface WorkSortDao {
	public List<WorkSortVO> list();
}
