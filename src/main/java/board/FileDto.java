package board;

public class FileDto {

	//댓글 멤버변수명: bbsFNum, bbsFWriter, bbsFRoute, bbsNum(외래키)
	private int bbsFNum; //primary key
	private String bbsFWriter;
	private String bbsFRoute;
	private String bbsFRoute2;
	private int bbsNum;
	
	public int getBbsFNum() {
		return bbsFNum;
	}
	public void setBbsFNum(int bbsFNum) {
		this.bbsFNum = bbsFNum;
	}
	public String getBbsFWriter() {
		return bbsFWriter;
	}
	public void setBbsFWriter(String bbsFWriter) {
		this.bbsFWriter = bbsFWriter;
	}
	public String getBbsFRoute() {
		return bbsFRoute;
	}
	public void setBbsFRoute(String bbsFRoute) {
		this.bbsFRoute = bbsFRoute;
	}
	public String getBbsFRoute2() {
		return bbsFRoute2;
	}
	public void setBbsFRoute2(String bbsFRoute2) {
		this.bbsFRoute2 = bbsFRoute2;
	}
	public int getBbsNum() {
		return bbsNum;
	}
	public void setBbsNum(int bbsNum) {
		this.bbsNum = bbsNum;
	}
}
