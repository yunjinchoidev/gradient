package project5.procurement;

import java.util.List;

import org.springframework.stereotype.Repository;

@Repository
public interface ProcurementDao {

	public List<ProcurementVO> list();

	public ProcurementVO get(int procurementkey);

	public void insert(ProcurementVO vo);

	public void update(ProcurementVO vo);

	public void delete(int procurementkey);

}
