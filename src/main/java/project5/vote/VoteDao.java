package project5.vote;

import java.util.List;

import org.springframework.stereotype.Repository;

@Repository
public interface VoteDao {

	public List<VoteVO> list();

	public VoteVO get(int votekey);

	public void insert(VoteVO vo);
	
	public void voting(VoteVO vo);

}
