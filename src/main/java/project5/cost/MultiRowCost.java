package project5.cost;

import java.util.List;

public class MultiRowCost {
	private List<CostDetail> list;
	
	
	
	public MultiRowCost() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public MultiRowCost(List<CostDetail> list) {
		super();
		this.list = list;
	}

	public List<CostDetail> getList() {
		return list;
	}
	public void setList(List<CostDetail> list) {
		this.list = list;
	}
}
