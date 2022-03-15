package project5.cost;

import java.util.List;

import org.springframework.stereotype.Repository;

@Repository
public interface CostDao {
	// 게시글 목록
	public List<CostList> getCostList();
}
