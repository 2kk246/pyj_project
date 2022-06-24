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

public class CommentDao {
	
	//DBCP를 이용한 데이터베이스 연결객체 얻기
		public Connection getConnection() throws Exception{
			Context initCtx = new InitialContext();//톰캣 자체의 Context정보를 얻어오는 부분
			Context envCtx = (Context)initCtx.lookup("java:comp/env");//java:comp/env: Resource정의 Context까지 접근하는 정해진 이름(JNDI)
			DataSource ds = (DataSource)envCtx.lookup("jdbc/OracleDB");//context.xml에 정의한 DataSource객체를 얻어오는 부분
			Connection conn = ds.getConnection();//ConnectionPool에서 Connection객체를 얻어오는 부분
			return conn;
		}
	//게시글에 연결된 댓글 삭제 메소드
		public void deleteAll(int bbsNum) {
			String sql = "delete from bbsComment where bbsNum =?";
			try(Connection con = getConnection();
				PreparedStatement pstmt	= con.prepareStatement(sql)){
			
				pstmt.setInt(1, bbsNum);
		        pstmt.executeUpdate();
		        
			}catch(Exception e){e.printStackTrace();}
		}
	//댓글 삭제 메소드
		public void delete(int bbsCNum) {
			String sql = "delete from bbsComment where bbsCNum =?";
			try(Connection con = getConnection();
				PreparedStatement pstmt	= con.prepareStatement(sql)){
			
				pstmt.setInt(1, bbsCNum);
		        pstmt.executeUpdate();
		        
			}catch(Exception e){e.printStackTrace();}
		}
	//댓글의 개수 세는 메소드
		public int countComments(int bbsNum){
			int count=0;
			//게시글의 총 댓글 수를 조회
			String sql = "select count(bbsCNum) from bbsComment where bbsNum="+bbsNum;
			
			try(Connection con = getConnection();
					PreparedStatement pstmt	=con.prepareStatement(sql);
					ResultSet rs= pstmt.executeQuery()){
					
					if(rs != null) 
						rs.next();

					count=rs.getInt(1);
					
				}catch(Exception e){ e.printStackTrace(); }
			
			return count;
		}
	//댓글에서 정보 빼오는 메소드
		public List<CommentDto> getComments(int bbsNum){
			List<CommentDto> commentList=null;
			String sql = "SELECT * FROM (SELECT * FROM bbsComment ORDER BY bbsCNum) where bbsNum=?";
			
			try(Connection con = getConnection();
				PreparedStatement pstmt	=con.prepareStatement(sql)){
				pstmt.setInt(1, bbsNum);
				ResultSet rs= pstmt.executeQuery();
				
				if(rs != null) 
					commentList = new ArrayList<CommentDto>();
				
				while(rs.next()){
					CommentDto Cdto = new CommentDto();
					Cdto.setBbsCWriter(rs.getString("bbsCWriter"));
					Cdto.setBbsCContent(rs.getString("bbsCContent"));
					Cdto.setCregDate(rs.getDate("CregDate"));
					Cdto.setBbsCNum(rs.getInt("bbsCNum"));
					commentList.add(Cdto);
				}
				
				rs.close();
			}catch(Exception e){
				e.printStackTrace();
			}
			return commentList;
		}
		
		
}