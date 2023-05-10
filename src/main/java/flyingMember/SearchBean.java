package flyingMember;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class SearchBean {
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	// MySql 연결
	String jdbcDriver = "com.mysql.cj.jdbc.Driver";
	String jdbcUrl = "jdbc:mysql://192.168.219.196:3306/flyingdb?serverTimezone=UTC";
	
	// DB 연결
	void connect() {
		try {
			Class.forName(jdbcDriver);
			conn = DriverManager.getConnection(jdbcUrl, "root", "flying");
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			System.out.println("jdbc 연결 실패!");
		}
	}
	
	// 연결 해제
	void disconnect() {
		if(pstmt != null) {
			try {
				pstmt.close();
			} catch(SQLException e) {
				e.printStackTrace();
			}
		}
		if(conn != null) {
			try {
				conn.close();
			} catch(SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	// 특정 회원 정보
	public MemberInfo memberSearch(String memId) {
		connect();
		
		String sql = "select * from membertable where memberid=?";
		MemberInfo meminfo = new MemberInfo();
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,memId);
			ResultSet rs = pstmt.executeQuery();
			
			rs.next();
			meminfo.setMemberId(rs.getString("memberId"));
			meminfo.setMemberPassword(rs.getString("memberPassword"));
			meminfo.setMemberName(rs.getString("memberName"));
			meminfo.setMemberType(rs.getString("memberType"));
			meminfo.setPhoneNumber(rs.getString("phoneNumber"));
			meminfo.setMemberEmail(rs.getString("memberEmail"));
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			disconnect();
		}
		return meminfo;
	}
	
	// 모든 회원 목록
	public ArrayList<MemberInfo> memberList() {
		connect();
		
		ArrayList<MemberInfo> memberDB = new ArrayList<MemberInfo>();
		String sql = "select * from membertable order by memberid desc";
		
		try {
			pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				MemberInfo meminfo = new MemberInfo();
				
				meminfo.setMemberId(rs.getString("memberId"));
				meminfo.setMemberPassword(rs.getString("memberPassword"));
				meminfo.setMemberName(rs.getString("memberName"));
				meminfo.setMemberType(rs.getString("memberType"));
				meminfo.setPhoneNumber(rs.getString("phoneNumber"));
				meminfo.setMemberEmail(rs.getString("memberEmail"));
			}
			rs.close();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			disconnect();
		}
		return memberDB;
	}
	
	public boolean confirmId(String uid) {
		connect();
		
		String sql = "SELECT memberid FROM membertable WHERE memberid=?";
		boolean result = false;
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, uid);
			rs = pstmt.executeQuery();
			if(rs.next())
				result = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null) try { rs.close(); } catch(SQLException e) {}
			if(pstmt != null) try { pstmt.close(); } catch(SQLException e) {}
			if(conn != null) try { conn.close(); } catch(SQLException e) {}
		}
		return result;
	}
}