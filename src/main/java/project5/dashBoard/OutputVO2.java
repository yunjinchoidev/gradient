package project5.dashBoard;

public class OutputVO2 {
	private String writedate;
	private int evaluation;

	public OutputVO2() {
		super();
		// TODO Auto-generated constructor stub
	}

	public OutputVO2(String writedate, int evaluation) {
		super();
		this.writedate = writedate;
		this.evaluation = evaluation;
	}

	public String getWritedate() {
		return writedate;
	}

	public void setWritedate(String writedate) {
		this.writedate = writedate;
	}

	public int getEvaluation() {
		return evaluation;
	}

	public void setEvaluation(int evaluation) {
		this.evaluation = evaluation;
	}

}
