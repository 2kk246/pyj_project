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

public class FileDao {
	
//DBCP를 이용한 데이터베이스 연결객체 얻기
	public Connection getConnection() throws Exception{
		Context initCtx = new InitialContext();//톰캣 자체의 Context정보를 얻어오는 부분
		Context envCtx = (Context)initCtx.lookup("java:comp/env");//java:comp/env: Resource정의 Context까지 접근하는 정해진 이름(JNDI)
		DataSource ds = (DataSource)envCtx.lookup("jdbc/OracleDB");//context.xml에 정의한 DataSource객체를 얻어오는 부분
		Connection conn = ds.getConnection();//ConnectionPool에서 Connection객체를 얻어오는 부분
		return conn;
	}
//파일 추가
	public int insert(FileDto Fdto, String id, String bbsFRoute, String bbsFRoute2, int bbsNum){
		int result = 0;//0:게시글 입력 실패 
		String sql="insert into bbsFile"
				+ "(bbsFNum, bbsFWriter, bbsFRoute, bbsFRoute2, bbsNum) "
				+ "values(bbsFSeq.nextval,?,?,?,?)";//게시글을 입력하는 SQL문을 작성하시오.
		try(Connection con = getConnection();
			PreparedStatement pstmt	= con.prepareStatement(sql)){

			pstmt.setString(1, id);
			pstmt.setString(2, bbsFRoute);
			pstmt.setString(3, bbsFRoute2);
			pstmt.setInt(4, bbsNum);
			
			pstmt.executeUpdate();
			result=1;//1:게시글 입력 성공 
		}catch(Exception e){ e.printStackTrace(); }
		
        return result;
	}
//파일 삭제
	public void deleteAll(int bbsNum) {
		String sql = "delete from bbsFile where bbsNum =?";
		try(Connection con = getConnection();
			PreparedStatement pstmt	= con.prepareStatement(sql)){
		
			pstmt.setInt(1, bbsNum);
	        pstmt.executeUpdate();
	        
		}catch(Exception e){e.printStackTrace();}
	}
//파일 찾기
	public String findBbsFRoute(int bbsNum) {
		String result= "";
		String sql = "select bbsFRoute from bbsFile where bbsNum=?";
		try(Connection con = getConnection();
				PreparedStatement pstmt	= con.prepareStatement(sql)){
				pstmt.setInt(1, bbsNum);
				ResultSet rs= pstmt.executeQuery();
				rs = pstmt.executeQuery();
				while(rs.next()) {
					result = rs.getString("bbsFRoute");
				}
			}catch(Exception e){ e.printStackTrace(); }
			
		return result;
	}
}
