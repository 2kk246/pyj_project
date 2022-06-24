package board;

import java.util.Date;

public class BoardDto {

	//게시글 멤버변수명: num, writer, subject, content, reg_date, readCount
	private int bbsNum;
	private String bbsWriter;
	private String bbsInd; //게시판 분류
	private String bbsSubject;
	private String bbsContent;
	private Date regDate;
	private int readCount;
	private int recommend;
	
	public int getBbsNum() {
		return bbsNum;
	}
	public void setBbsNum(int bbsNum) {
		this.bbsNum = bbsNum;
	}
	public String getBbsWriter() {
		return bbsWriter;
	}
	public void setBbsWriter(String bbsWriter) {
		this.bbsWriter = bbsWriter;
	}
	public String getBbsInd() {
		return bbsInd;
	}
	public void setBbsInd(String bbsInd) {
		this.bbsInd = bbsInd;
	}
	public String getBbsSubject() {
		return bbsSubject;
	}
	public void setBbsSubject(String bbsSubject) {
		this.bbsSubject = bbsSubject;
	}
	public String getBbsContent() {
		String text = bbsContent;
		text=text.replace("\n","<br/>");
		return text;
	}
	//bbs_update.jsp에서 DB에 저장된 <br/>태그를 \n으로 변경
	public String getModifiedContent() {
		String text = bbsContent;
		text = text.replace("<br/>", "\n");
		return text;
	}
	public void setBbsContent(String bbsContent) {
		this.bbsContent = bbsContent;
	}
	public Date getRegDate() {
		return regDate;
	}
	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}
	public int getReadCount() {
		return readCount;
	}
	public void setReadCount(int readCount) {
		this.readCount = readCount;
	}
	public int getRecommend() {
		return recommend;
	}
	public void setRecommend(int recommend) {
		this.recommend = recommend;
	}
	
}
