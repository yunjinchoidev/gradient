package project5.output;

import java.util.List;

import org.springframework.stereotype.Repository;

@Repository
public interface OutputDao {
	public List<OutputVO> list();
	public OutputVO get(int outputkey);
	public void insert(OutputVO vo);
	public void update(OutputVO vo);
	public void delete(int outputkey);
	
}
