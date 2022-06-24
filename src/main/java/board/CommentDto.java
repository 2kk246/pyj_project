package board;

import java.util.Date;

public class CommentDto {

	//댓글 멤버변수명: bbs_Num, bbsCNum, bbsCContent, CregDate
	private int bbsCNum; //primary key
	private String bbsCContent;
	private Date CregDate;
	private int bbsNum;
	private String bbsCWriter;
	
	public int getBbsCNum() {
		return bbsCNum;
	}
	public void setBbsCNum(int bbsCNum) {
		this.bbsCNum = bbsCNum;
	}
	public String getBbsCContent() {
		return bbsCContent;
	}
	public void setBbsCContent(String bbsCContent) {
		this.bbsCContent = bbsCContent;
	}
	public Date getCregDate() {
		return CregDate;
	}
	public void setCregDate(Date cregDate) {
		CregDate = cregDate;
	}
	public int getBbsNum() {
		return bbsNum;
	}
	public void setBbsNum(int bbsNum) {
		this.bbsNum = bbsNum;
	}
	public String getBbsCWriter() {
		return bbsCWriter;
	}
	public void setBbsCWriter(String bbsCWriter) {
		this.bbsCWriter = bbsCWriter;
	}
}
