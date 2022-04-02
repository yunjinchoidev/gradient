package project5.procuSituation;

import java.util.List;

import org.springframework.stereotype.Repository;

@Repository
public interface ProcuSituationDao {

	public List<ProcuSituationVO> listWithPaging(ProcuSituationSch sch);
	public int totCnt(ProcuSituationSch sch);
	public void insert(ProcuSituationVO vo);
}
