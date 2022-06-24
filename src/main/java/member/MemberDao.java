package member;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import jdbc.DBConnection;

//db를 사용해 데이터 조작(DML)
	public class MemberDao {
		public Connection getConnection() {
			Connection conn=null;
			try {
				Class.forName("oracle.jdbc.driver.OracleDriver");//jdbc 드라이브 로딩
				conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "system", "1234");
				System.out.println("DB 연결 성공");
				//연결 객체(conn)이용해 db의 데이터를 수정하거나 삭제하거나 할 수 있음
			} catch (ClassNotFoundException | SQLException e) {
				System.out.println("DB 연결 실패");
			}
			return conn;
		}
//회원가입		
	public int joinMember(MemberDto dto) {
		int result=0; //0:회원정보 입력실패
    	String sql ="insert into memberTb values(memberSeq.nextval,?,?,?,?,?,0,sysdate)";

    	try(Connection conn = getConnection();
	    	PreparedStatement pstmt = conn.prepareStatement(sql)){
	    	pstmt.setString(1,dto.getMemberId());//1:첫번째 ?를 의미함
	    	pstmt.setString(2,dto.getMemberPw());
	    	pstmt.setString(3,dto.getMemberName());
	    	pstmt.setString(4,dto.getMemberNick());
	    	pstmt.setString(5,dto.getPhoneNo());
	    	
	    	pstmt.executeUpdate();
	    	result = 1;//1:회원정보 입력 성공
    	}catch(Exception e) {e.printStackTrace();}
    	
    	
    	return result;
	}
//로그인
	public int login(String id,String pw) {
		int result=0; //0:로그인 실패
		String sql = "select count(*) from memberTb where memberId=? and memberPw=?";
		
		try (Connection conn = DBConnection.getConnection();
			PreparedStatement pstmt = conn.prepareStatement(sql)){
			pstmt.setString(1, id);
			pstmt.setString(2, pw);
			ResultSet rs = pstmt.executeQuery();
			
			if (rs.next())  result = rs.getInt(1); //1:count(*) 존재 -> 즉, 로그인 성공
			rs.close();
		}catch(Exception e) {e.printStackTrace();}
		return result;
		   
	}
//회원탈퇴
	public int withdrawalMember(String id) {
		int result=0; //0:회원탈퇴 실패
		String sql = "delete from memberTb where memberId=?";
		
		try (Connection conn = DBConnection.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql)){
				pstmt.setString(1, id);
				pstmt.executeUpdate();
				result = 1; //1:회원탈퇴 성공
		}catch(Exception e) {e.printStackTrace();}
		
		return result;
	}
	public MemberDto getMemberInfo(String id, MemberDto dto) {
		String sql = "select memberId, memberPw, memberName, memberNick, phoneNo from memberTb where memberId=?";
		
		try(Connection conn = DBConnection.getConnection();
			PreparedStatement pstmt = conn.prepareStatement(sql)){
				
				pstmt.setString(1, id);
				ResultSet rs = pstmt.executeQuery();
				rs.next();
				
				//dto클래스에 세팅해줌
				dto.setMemberId(rs.getString("memberId"));
				dto.setMemberPw(rs.getString("memberPw"));
				dto.setMemberName(rs.getString("memberName"));
				dto.setMemberNick(rs.getString("memberNick"));
				dto.setPhoneNo(rs.getString("phoneNo"));
				
				
				rs.close();
		}catch(Exception e) {e.printStackTrace();}
		return dto; //레코드 한 행이 반환된다.
	}
	//아이디 중복 체크
	public int idCheck(String id) {
		int result = 0; //0:오류발생
		String sql = "select memberId from memberTb where memberId=?";
		try(Connection conn = getConnection();
		    	PreparedStatement pstmt = conn.prepareStatement(sql)){
		    	pstmt.setString(1, id);
		    	ResultSet rs = pstmt.executeQuery();
		    	if(rs.next()) {
		    		result=0; //존재할 경우
		    	}else {
		    		result=1; //존재하지 않을 경우
		    	}
	    	}catch(Exception e) {e.printStackTrace();}
	    	return result;
	}
	//회원정보 수정
	public int updateMemberInfo(MemberDto dto) {
		int result=0; //0:회원정보 수정 실패
		String sql = "update memberTb set memberId=?,memberPw=?,memberName=?,memberNick=?,phoneNo=? where memberId=?";
    	try(Connection conn = getConnection();
	    	PreparedStatement pstmt = conn.prepareStatement(sql)){
	    	pstmt.setString(1,dto.getMemberId());//1:첫번째 ?를 의미함
	    	pstmt.setString(2,dto.getMemberPw());
	    	pstmt.setString(3,dto.getMemberName());
	    	pstmt.setString(4,dto.getMemberNick());
	    	pstmt.setString(5,dto.getPhoneNo());
	    	pstmt.setString(6,dto.getMemberId());
	    	
	    	pstmt.executeUpdate();
	    	result = 1;//1:회원정보 수정 성공
    	}catch(Exception e) {e.printStackTrace();}
    	
    	
    	return result;
	}
	
	
}
