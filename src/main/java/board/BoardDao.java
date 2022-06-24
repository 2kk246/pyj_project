package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class BoardDao {
//DBCP를 이용한 데이터베이스 연결객체 얻기
	public Connection getConnection() throws Exception{
		Context initCtx = new InitialContext();//톰캣 자체의 Context정보를 얻어오는 부분
		Context envCtx = (Context)initCtx.lookup("java:comp/env");//java:comp/env: Resource정의 Context까지 접근하는 정해진 이름(JNDI)
		DataSource ds = (DataSource)envCtx.lookup("jdbc/OracleDB");//context.xml에 정의한 DataSource객체를 얻어오는 부분
		Connection conn = ds.getConnection();//ConnectionPool에서 Connection객체를 얻어오는 부분
		return conn;
	}
//글 추가 -> bbsNum 반환
	public int insert(BoardDto dto,String id){
		int result = 0;//0:게시글 입력 실패 
		String sql="insert into bbsTb"
				+ "(bbsNum, bbsWriter, bbsInd, bbsSubject, bbsContent) "
				+ "values(bbsSeq.nextval,?,?,?,?)";//게시글을 입력하는 SQL문을 작성하시오.
		try(Connection con = getConnection();
			PreparedStatement pstmt	= con.prepareStatement(sql)){

			pstmt.setString(1, id);
			pstmt.setString(2, dto.getBbsInd());
			pstmt.setString(3, dto.getBbsSubject());
			pstmt.setString(4, dto.getBbsContent());
			
			pstmt.executeUpdate();
			result=1;//1: 입력성공 
			
			PreparedStatement psmt2 = null;
			ResultSet rs2 = null;
			
			psmt2 = con.prepareStatement("SELECT * FROM bbsTb WHERE BBSNUM=(SELECT MAX(bbsNum) FROM bbsTb)");
			rs2 = psmt2.executeQuery();
			
			while(rs2.next()) {
				result=rs2.getInt("bbsNum");
			}
			
		}catch(Exception e){ e.printStackTrace(); }
        return result;
	}
//글 업데이트
	public void update(BoardDto dto, String id){
		String sql = "update bbsTb set bbsWriter=?, bbsSubject=?, bbsContent=? where bbsNum =?";//글번호에 대한 게시글을 업데이트하는 SQL문을 작성하시오.
		try(Connection con = getConnection();
			PreparedStatement pstmt	= con.prepareStatement(sql)){
		
			pstmt.setString(1, id);
			pstmt.setString(2, dto.getBbsSubject());
			pstmt.setString(3, dto.getBbsContent());
			pstmt.setInt(4, dto.getBbsNum());
			
        pstmt.executeUpdate();
        
		}catch(Exception e){e.printStackTrace();}
	}
//글 삭제
	public void delete(int bbsNum){
		String sql = "delete from bbsTb where bbsNum =?";//글번호에 대한 게시글을 삭제하는 SQL문을 작성하시오.
		try(Connection con = getConnection();
			PreparedStatement pstmt	= con.prepareStatement(sql)){
		
			pstmt.setInt(1, bbsNum);
	        pstmt.executeUpdate();
	        
		}catch(Exception e){e.printStackTrace();}
	}
	
//글의 개수 세는 메소드
	public int countArticles(String board){
		int count=0;
		String sql="";
		//게시판의 총 게시글 수를 조회하는 SQL문
		if(board=="전체") {
			sql = "select count(bbsNum) from bbsTb WHERE BBSIND='전체' OR BBSIND='힐링' OR BBSIND='공포' OR BBSIND='협동'";
		}else {
			sql = "select count(bbsNum) from bbsTb where bbsInd='"+board+"'";//게시판의 총 게시글 수를 조회하는 SQL문을 작성하시오.
		}
		try(Connection con = getConnection();
				PreparedStatement pstmt	= con.prepareStatement(sql);
				ResultSet rs= pstmt.executeQuery()){
				
				if(rs != null) 
					rs.next();

				count=rs.getInt(1);
				
			}catch(Exception e){ e.printStackTrace(); }
		
		return count;
	}
//검색한 글의 개수 세는 메소드
	public int searchArticles(String board, String select, String searchFor){
		System.out.println("게시판 : "+board+", 선택자 : "+select+", 검색어 : "+searchFor);
		int count=0;
		String sql="";
		if(board=="전체") {
			if(select.equals("전체")) {
				sql = "select count(bbsNum) from (SELECT * FROM bbsTb WHERE bbsInd='전체' OR bbsInd='힐링' OR bbsInd='공포' OR bbsInd='협동') "
						+ "where bbsSubject LIKE '%"+searchFor+"%' OR BBSWRITER LIKE '%"+searchFor+"%' OR BBSCONTENT LIKE '%"+searchFor+"%' AND bbsInd='"+board+"'";
			}else if(select.equals("작성자")) {
				sql = "select count(bbsNum) from (SELECT * FROM bbsTb WHERE bbsInd='전체' OR bbsInd='힐링' OR bbsInd='공포' OR bbsInd='협동') "
						+ "where BBSWRITER LIKE '%"+searchFor+"%'";
			}else if(select.equals("내용")) {
				sql = "select count(bbsNum) from (SELECT * FROM bbsTb WHERE bbsInd='전체' OR bbsInd='힐링' OR bbsInd='공포' OR bbsInd='협동') "
						+ "where BBSCONTENT LIKE '%"+searchFor+"%'";
			}else if(select.equals("제목")) {
				sql = "select count(bbsNum) from (SELECT * FROM bbsTb WHERE bbsInd='전체' OR bbsInd='힐링' OR bbsInd='공포' OR bbsInd='협동') "
						+ "where BBSSUBJECT LIKE '%"+searchFor+"%'";
			}
		}else {//board가 전체가 아닌 경우
			if(select.equals("전체")) {
				sql = "select count(bbsNum) from (SELECT * FROM bbsTb WHERE bbsInd='"+board+"') "
					+ "where bbsSubject LIKE '%"+searchFor+"%' OR BBSWRITER LIKE '%"+searchFor+"%' OR BBSCONTENT LIKE '%"+searchFor+"%' AND bbsInd='"+board+"'";		
			}else if(select.equals("작성자")) {
				sql = "select count(bbsNum) from (SELECT * FROM bbsTb WHERE bbsInd='"+board+"') "
						+ "where BBSWRITER LIKE '%"+searchFor+"%'";
			}else if(select.equals("내용")) {
				sql = "select count(bbsNum) from (SELECT * FROM bbsTb WHERE bbsInd='"+board+"') "
						+ "where BBSCONTENT LIKE '%"+searchFor+"%'";
			}else if(select.equals("제목")) {
				sql = "select count(bbsNum) from (SELECT * FROM bbsTb WHERE bbsInd='"+board+"') "
						+ "where bbsSubject LIKE '%"+searchFor+"%'";
			}
		}
		try(Connection con = getConnection();
				PreparedStatement pstmt	=con.prepareStatement(sql);
				ResultSet rs= pstmt.executeQuery()){
				
				if(rs != null) 
					rs.next();

				count=rs.getInt(1);
				
			}catch(Exception e){ e.printStackTrace(); }
		
		return count;
	}
//게시글에서 정보 빼오는 메소드
	public List<BoardDto> getArticles(int start, int end, String board){
		List<BoardDto> articleList=null;
		String sql="";
		if(board=="전체") {
			sql = "SELECT * FROM (SELECT ROW_NUMBER() OVER(ORDER BY regdate DESC) r,bbsNum, bbsWriter, bbsInd, bbsSubject, bbsContent, regDate, readCount, recommend "
					+ "FROM bbsTb WHERE bbsInd='전체' OR BBSIND='힐링' OR BBSIND='공포' OR BBSIND='협동')WHERE r BETWEEN ? AND ?";
		}else {
			sql = "SELECT * FROM (SELECT ROW_NUMBER() OVER(ORDER BY regdate DESC) r,bbsNum, bbsWriter, bbsInd, bbsSubject, bbsContent, regDate, readCount, recommend "
					+ "FROM bbsTb WHERE bbsInd='"+board+"')WHERE r BETWEEN ? AND ?";
		}
		
		try(Connection con = getConnection();
			PreparedStatement pstmt	=con.prepareStatement(sql)){
			
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			
			ResultSet rs= pstmt.executeQuery();
			
			if(rs != null) 
				articleList = new ArrayList<BoardDto>();
			
			while(rs.next()){
				BoardDto dto = new BoardDto();	
				dto.setBbsNum(rs.getInt("bbsNum"));
				dto.setBbsWriter(rs.getString("bbsWriter"));
				dto.setBbsInd(rs.getString("bbsInd"));
				dto.setBbsSubject(rs.getString("bbsSubject"));
				dto.setBbsContent(rs.getString("bbsContent"));
				dto.setRegDate(rs.getDate("regDate"));
				dto.setReadCount(rs.getInt("readCount"));
				dto.setRecommend(rs.getInt("recommend"));
				articleList.add(dto);
			}
			
			rs.close();
		}catch(Exception e){
			e.printStackTrace();
		}
		return articleList;
	}
//내가 쓴 글의 개수 세는 메소드
	public int countMyArticles(String nick){
		int count=0;
		String sql="select count(bbsNum) from bbsTb WHERE bbsWriter=?";
		try(Connection con = getConnection();
				PreparedStatement pstmt	= con.prepareStatement(sql)){
				pstmt.setString(1, nick);
				ResultSet rs= pstmt.executeQuery();
				if(rs != null) 
					rs.next();

				count=rs.getInt(1);
				rs.close();
			}catch(Exception e){ e.printStackTrace(); }
		
		return count;
	}
//내가 쓴 댓글의 개수 세는 메소드
	public int countMyComments(String nick){
		int count=0;
		String sql="SELECT COUNT(BBSCNUM) FROM BBSCOMMENT WHERE BBSCWRITER=?";
		try(Connection con = getConnection();
				PreparedStatement pstmt	= con.prepareStatement(sql)){
				pstmt.setString(1, nick);
				ResultSet rs= pstmt.executeQuery();
				if(rs != null) 
					rs.next();

				count=rs.getInt(1);
				rs.close();
			}catch(Exception e){ e.printStackTrace(); }
		
		return count;
	}
//나의 게시글 가져오기
	public List<BoardDto> getMyArticles(int start, int end, String nick){
		List<BoardDto> articleList=null;
		String sql="SELECT * FROM (SELECT ROW_NUMBER() OVER(ORDER BY regdate DESC) r,bbsNum, bbsWriter, bbsInd, bbsSubject, bbsContent, regDate, readCount, recommend "
				+ "FROM bbsTb WHERE bbsWriter=?)WHERE r BETWEEN ? AND ?";
		
		try(Connection con = getConnection();
			PreparedStatement pstmt	=con.prepareStatement(sql)){
			
			pstmt.setString(1, nick);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
			
			ResultSet rs= pstmt.executeQuery();
			
			if(rs != null) 
				articleList = new ArrayList<BoardDto>();
			
			while(rs.next()){
				BoardDto dto = new BoardDto();	
				dto.setBbsNum(rs.getInt("bbsNum"));
				dto.setBbsWriter(rs.getString("bbsWriter"));
				dto.setBbsInd(rs.getString("bbsInd"));
				dto.setBbsSubject(rs.getString("bbsSubject"));
				dto.setBbsContent(rs.getString("bbsContent"));
				dto.setRegDate(rs.getDate("regDate"));
				dto.setReadCount(rs.getInt("readCount"));
				dto.setRecommend(rs.getInt("recommend"));
				articleList.add(dto);
			}
			
			rs.close();
		}catch(Exception e){
			e.printStackTrace();
		}
		return articleList;
	}
//나의 댓글 가져오기
	public List<CommentDto> getMyComments(int start, int end, String nick){
		List<CommentDto> commentList=null;
		String sql="SELECT * FROM (SELECT ROW_NUMBER() OVER(ORDER BY Cregdate DESC) r,bbsCNum, bbsCWriter, bbsCContent, CregDate, bbsNum\r\n"
				+ "FROM BBSCOMMENT WHERE bbsCWriter=?)WHERE r BETWEEN ? AND ?";
		
		try(Connection con = getConnection();
			PreparedStatement pstmt	=con.prepareStatement(sql)){
			
			pstmt.setString(1, nick);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
			
			ResultSet rs= pstmt.executeQuery();
			
			if(rs != null) 
				commentList = new ArrayList<CommentDto>();
			
			while(rs.next()){
				CommentDto Cdto = new CommentDto();	
				Cdto.setBbsCNum(rs.getInt("bbsCNum"));
				Cdto.setBbsCWriter(rs.getString("bbsCWriter"));
				Cdto.setBbsCContent(rs.getString("bbsCContent"));
				Cdto.setCregDate(rs.getDate("CregDate"));
				Cdto.setBbsNum(rs.getInt("bbsNum"));
				commentList.add(Cdto);
			}
			
			rs.close();
		}catch(Exception e){
			e.printStackTrace();
		}
		return commentList;
	}
//댓글의 bbsNum에 따른 글제목
	public String getFromComment(int bbsNum) {
		String bbsSubject="";
		String sql="SELECT bbsSubject FROM bbsTb where bbsNum=?";
		
		try(Connection con = getConnection();
			PreparedStatement pstmt	=con.prepareStatement(sql)){
			
			pstmt.setInt(1, bbsNum);

			ResultSet rs= pstmt.executeQuery();
			
			while(rs.next()){
				bbsSubject = rs.getString("bbsSubject");	
			}
			
			rs.close();
			}catch(Exception e){
				e.printStackTrace();
			}
		return bbsSubject;
	}
//검색한 게시글에서 정보 빼오는 메소드
	public List<BoardDto> getArticles_search(int start, int end, String board, String select, String searchFor){
		List<BoardDto> articleList=null;
		String sql="";
		if(board=="전체") {
			if(select.equals("전체")) {
				sql = "SELECT * FROM (select ROWNUM r, bbsNum, bbsWriter, bbsInd, bbsSubject, bbsContent, regDate, readCount, recommend "
						+ "from (SELECT * FROM bbsTb where bbsSubject LIKE '%"+searchFor+"%' OR BBSWRITER LIKE '%"+searchFor+"%' OR BBSCONTENT LIKE '%"+searchFor+"%') "
						+ "where bbsInd='전체' or bbsInd='힐링' or bbsInd='공포' or bbsInd='협동' order by bbsNum desc) where r >= ?  and r <= ?";
			}else if(select.equals("작성자")) {
				sql = "SELECT * FROM (select ROWNUM r, bbsNum, bbsWriter, bbsInd, bbsSubject, bbsContent, regDate, readCount, recommend "
						+ "from (SELECT * FROM bbsTb where BBSWRITER LIKE '%"+searchFor+"%') "
						+ "where bbsInd='전체' or bbsInd='힐링' or bbsInd='공포' or bbsInd='협동' order by bbsNum desc) where r >= ?  and r <= ?";
			}else if(select.equals("내용")) {
				sql = "SELECT * FROM (select ROWNUM r, bbsNum, bbsWriter, bbsInd, bbsSubject, bbsContent, regDate, readCount, recommend "
						+ "from (SELECT * FROM bbsTb where BBSCONTENT LIKE '%"+searchFor+"%') "
						+ "where bbsInd='전체' or bbsInd='힐링' or bbsInd='공포' or bbsInd='협동' order by bbsNum desc) where r >= ?  and r <= ?";
			}else if(select.equals("제목")) {
				sql = "SELECT * FROM (select ROWNUM r, bbsNum, bbsWriter, bbsInd, bbsSubject, bbsContent, regDate, readCount, recommend "
						+ "from (SELECT * FROM bbsTb where bbsSubject LIKE '%"+searchFor+"%') "
						+ "where bbsInd='전체' or bbsInd='힐링' or bbsInd='공포' or bbsInd='협동' order by bbsNum desc) where r >= ?  and r <= ?";
			}
		}else {//board가 전제가 아닌 경우
			if(select.equals("전체")) {
				sql = "SELECT * FROM (select ROWNUM r, bbsNum, bbsWriter, bbsInd, bbsSubject, bbsContent, regDate, readCount, recommend "
						+ "from (SELECT * FROM bbsTb where bbsSubject LIKE '%"+searchFor+"%' OR BBSWRITER LIKE '%"+searchFor+"%' OR BBSCONTENT LIKE '%"+searchFor+"%') "
						+ "where bbsInd='"+board+"' order by bbsNum desc) where r >= ?  and r <= ?";
			}else if(select.equals("작성자")) {
				sql = "SELECT * FROM (select ROWNUM r, bbsNum, bbsWriter, bbsInd, bbsSubject, bbsContent, regDate, readCount, recommend "
						+ "from (SELECT * FROM bbsTb where BBSWRITER LIKE '%"+searchFor+"%') "
						+ "where bbsInd='"+board+"' order by bbsNum desc) where r >= ?  and r <= ?";
			}else if(select.equals("내용")) {
				sql = "SELECT * FROM (select ROWNUM r, bbsNum, bbsWriter, bbsInd, bbsSubject, bbsContent, regDate, readCount, recommend "
						+ "from (SELECT * FROM bbsTb where BBSCONTENT LIKE '%"+searchFor+"%') "
						+ "where bbsInd='"+board+"' order by bbsNum desc) where r >= ?  and r <= ?";
			}else if(select.equals("제목")) {
				sql = "SELECT * FROM (select ROWNUM r, bbsNum, bbsWriter, bbsInd, bbsSubject, bbsContent, regDate, readCount, recommend "
						+ "from (SELECT * FROM bbsTb where bbsSubject LIKE '%"+searchFor+"%') "
						+ "where bbsInd='"+board+"' order by bbsNum desc) where r >= ?  and r <= ?";
			}
		}	
		try(Connection con = getConnection();
			PreparedStatement pstmt	=con.prepareStatement(sql)){
			
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			
			ResultSet rs= pstmt.executeQuery();
			
			if(rs != null) 
				articleList = new ArrayList<BoardDto>();
			
			while(rs.next()){
				BoardDto dto = new BoardDto();	
				dto.setBbsNum(rs.getInt("bbsNum"));
				dto.setBbsWriter(rs.getString("bbsWriter"));
				dto.setBbsInd(rs.getString("bbsInd"));
				dto.setBbsSubject(rs.getString("bbsSubject"));
				dto.setBbsContent(rs.getString("bbsContent"));
				dto.setRegDate(rs.getDate("regDate"));
				dto.setReadCount(rs.getInt("readCount"));
				dto.setRecommend(rs.getInt("recommend"));
				articleList.add(dto);
			}
			
			rs.close();
		}catch(Exception e){
			e.printStackTrace();
		}
		return articleList;
	}
//게시글에서 추천순으로 정보 빼오는 메소드
	public List<BoardDto> getArticles_rec(int start, int end, String board){
		List<BoardDto> articleList=null;
		String sql="";
		if(board=="전체") {
			sql = "SELECT * FROM ("
					+ "  SELECT ROW_NUMBER() OVER(ORDER BY recommend DESC) r,bbsNum, bbsWriter, bbsInd, bbsSubject, bbsContent, regDate, readCount, recommend"
					+ "  FROM bbsTb WHERE bbsInd='전체' OR BBSIND='힐링' OR BBSIND='공포' OR BBSIND='협동' "
					+ ")WHERE r BETWEEN ? AND ?";
		}else {
			sql = "SELECT * FROM ("
					+ "  SELECT ROW_NUMBER() OVER(ORDER BY recommend DESC) r,bbsNum, bbsWriter, bbsInd, bbsSubject, bbsContent, regDate, readCount, recommend"
					+ "  FROM bbsTb where bbsInd='"+board
					+ "')WHERE r BETWEEN ? AND ?";
		}
		
		try(Connection con = getConnection();
			PreparedStatement pstmt	=con.prepareStatement(sql)){
			
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			
			ResultSet rs= pstmt.executeQuery();
			
			if(rs != null) 
				articleList = new ArrayList<BoardDto>();
			
			while(rs.next()){
				BoardDto dto = new BoardDto();	
				dto.setBbsNum(rs.getInt("bbsNum"));
				dto.setBbsWriter(rs.getString("bbsWriter"));
				dto.setBbsInd(rs.getString("bbsInd"));
				dto.setBbsSubject(rs.getString("bbsSubject"));
				dto.setBbsContent(rs.getString("bbsContent"));
				dto.setRegDate(rs.getDate("regDate"));
				dto.setReadCount(rs.getInt("readCount"));
				dto.setRecommend(rs.getInt("recommend"));
				articleList.add(dto);
			}
			
			rs.close();
		}catch(Exception e){
			e.printStackTrace();
		}
		return articleList;
	}
//게시글에서 조회순으로 정보 빼오는 메소드
	public List<BoardDto> getArticles_hit(int start, int end, String board){
		List<BoardDto> articleList=null;
		String sql="";
		if(board=="전체") {
			sql = "SELECT * FROM ("
					+ "  SELECT ROW_NUMBER() OVER(ORDER BY readcount DESC) r,bbsNum, bbsWriter, bbsInd, bbsSubject, bbsContent, regDate, readCount, recommend"
					+ "  FROM bbsTb WHERE bbsInd='전체' OR BBSIND='힐링' OR BBSIND='공포' OR BBSIND='협동' "
					+ ")WHERE r BETWEEN ? AND ?";
		}else {
			sql = "SELECT * FROM ("
					+ "  SELECT ROW_NUMBER() OVER(ORDER BY readcount DESC) r,bbsNum, bbsWriter, bbsInd, bbsSubject, bbsContent, regDate, readCount, recommend"
					+ "  FROM bbsTb where bbsInd='"+board
					+ "')WHERE r BETWEEN ? AND ?";
		}
		
		try(Connection con = getConnection();
			PreparedStatement pstmt	=con.prepareStatement(sql)){
			
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			
			ResultSet rs= pstmt.executeQuery();
			
			if(rs != null) 
				articleList = new ArrayList<BoardDto>();
			
			while(rs.next()){
				BoardDto dto = new BoardDto();	
				dto.setBbsNum(rs.getInt("bbsNum"));
				dto.setBbsWriter(rs.getString("bbsWriter"));
				dto.setBbsInd(rs.getString("bbsInd"));
				dto.setBbsSubject(rs.getString("bbsSubject"));
				dto.setBbsContent(rs.getString("bbsContent"));
				dto.setRegDate(rs.getDate("regDate"));
				dto.setReadCount(rs.getInt("readCount"));
				dto.setRecommend(rs.getInt("recommend"));
				articleList.add(dto);
			}
			
			rs.close();
		}catch(Exception e){
			e.printStackTrace();
		}
		return articleList;
	}
	
	
	public BoardDto getArticle(int bbsNum){
		BoardDto dto = null;
		String sql = "select * from bbsTb where bbsNum =?";//글번호에 대한 게시글 데이터를 가져오는 SQL문을 작성하시오.
		try(Connection con = getConnection();
			PreparedStatement pstmt	=con.prepareStatement(sql)){

			pstmt.setInt(1, bbsNum);
			ResultSet rs= pstmt.executeQuery();
						
			while(rs.next()){
				dto = new BoardDto();
				dto.setBbsNum(rs.getInt("bbsNum"));
				dto.setBbsWriter(rs.getString("bbsWriter"));
				dto.setBbsInd(rs.getString("bbsInd"));
				dto.setBbsSubject(rs.getString("bbsSubject"));
				dto.setBbsContent(rs.getString("bbsContent"));
				dto.setRegDate(rs.getDate("regDate"));
				dto.setReadCount(rs.getInt("readCount"));
				dto.setRecommend(rs.getInt("recommend"));
			}
			
			rs.close();
		}catch(Exception e){e.printStackTrace();}
		
		return dto;
	}
//랜덤으로 게시글의 정보를 가져오는 메소드
	public int getArticleRandom() {
		int result=0;
		String sql = "SELECT * FROM (SELECT * FROM bbsTb where bbsInd='전체' or bbsInd='힐링' or bbsInd='공포' or bbsInd='협동' ORDER BY DBMS_RANDOM.VALUE)WHERE ROWNUM < 2";
		try(Connection con = getConnection();
				PreparedStatement pstmt	=con.prepareStatement(sql)){
				ResultSet rs= pstmt.executeQuery();
							
				while(rs.next()){
					result = rs.getInt("bbsNum");
				}
				
				rs.close();
			}catch(Exception e){e.printStackTrace();}
		return result;
	}
//조회수 증가
	public void updateReadCount(int num) {
		String sql = "update bbsTb set readCount=(readCount+1) where bbsNum =?";
		try(Connection con = getConnection();
			PreparedStatement pstmt	=con.prepareStatement(sql)){
			pstmt.setInt(1, num);
	        pstmt.executeUpdate();
	        
		}catch(Exception e){e.printStackTrace();}
	}
//최근 댓글이 달린 최근 5개의 게시글 정보 저장하는 메소드
	public List<BoardDto> getTop5Comment(){
		List<BoardDto> articleList=null;
		String sql = "SELECT * FROM bbsTb WHERE bbsNum IN (SELECT bbsNum FROM (SELECT DISTINCT BBSNUM, MAX(cregdate) from BBSCOMMENT GROUP BY BBSNUM ORDER BY MAX(cregdate) DESC) WHERE ROWNUM < 6)";
		
		try(Connection con = getConnection();
			PreparedStatement pstmt	=con.prepareStatement(sql);
			ResultSet rs= pstmt.executeQuery()){
			
			if(rs != null) 
				articleList = new ArrayList<BoardDto>();
			
			while(rs.next()){
				
				BoardDto dto = new BoardDto();	
				dto.setBbsNum(rs.getInt("bbsNum"));
				dto.setBbsWriter(rs.getString("bbsWriter"));
				dto.setBbsInd(rs.getString("bbsInd"));
				dto.setBbsSubject(rs.getString("bbsSubject"));
				dto.setBbsContent(rs.getString("bbsContent"));
				dto.setRegDate(rs.getDate("regDate"));
				dto.setReadCount(rs.getInt("readCount"));
				dto.setRecommend(rs.getInt("recommend"));
				articleList.add(dto);
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}
		return articleList;
	}
//권한
	public int getAuth(String id) {
		int result=0;
		System.out.println(id);
		if(id.equals("운영자")) {
			result=2;
		}else {
			result=0;
		}
		return result;	
	}

}