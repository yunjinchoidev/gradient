package project5.cost;

import java.util.List;

public class MultiRowCost {
	private List<CostDetail> list;
	private int prjkey;
	
	
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

	public int getPrjkey() {
		return prjkey;
	}

	public void setPrjkey(int prjkey) {
		this.prjkey = prjkey;
	}
	
}
