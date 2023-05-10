<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>

<%
	request.setCharacterEncoding("utf-8");
	
	String memberID = (String)session.getAttribute("memID"); // 입력된 회원의 memberid

	Class.forName("com.mysql.jdbc.Driver");
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	int a=0;

	String jdbcDriver = "jdbc:mysql://192.168.219.196:3306/flyingdb?characterEncoding=utf-8";
	String dbUser="root";
	String dbPass="flying";
		
	conn= DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
	
	
	String sql="delete from membertable where memberid=?";
	try {
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, memberID); // PK인 입력된 회원의 memberid 삭제 -> 회원 탈퇴
		pstmt.executeUpdate();
	} finally {
		if (pstmt != null) try { pstmt.close();} catch(SQLException ex) {}
		if (conn != null) try { conn.close();} catch(SQLException ex) {}
	}
	
	session.removeAttribute("memLogin"); // 회원탈퇴로 인한 로그인 유지 세션 삭제.
	
	session.removeAttribute("memberName");
%>
<script>
	alert("회원탈퇴가 완료되었습니다. Flying을 이용해주셔서 감사합니다.");
	location.href = '../index.jsp';
</script>