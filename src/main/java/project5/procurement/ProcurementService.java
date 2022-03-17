package project5.procurement;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


@Service
public class ProcurementService {
	
	
	@Autowired
	ProcurementDao dao;
	
	
	public List<ProcurementVO> list(){
		return dao.list();
	}

	public ProcurementVO get(int procurementkey) {
		return dao.get(procurementkey);
	}
	
	public void insert(ProcurementVO vo) {
		dao.insert(vo);
	}

	public void update(ProcurementVO vo) {
		dao.update(vo);
	}

	public void delete(int procurementkey) {
		dao.delete(procurementkey);
	}

}
