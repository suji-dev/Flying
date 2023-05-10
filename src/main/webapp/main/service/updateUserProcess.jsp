<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
	request.setCharacterEncoding("utf-8");

	String memName = (String)session.getAttribute("memberName");
	String memId = (String)session.getAttribute("memID"); // 회원의 기존 아이디 이름
	
	String newPw = (String)request.getParameter("updatePassword");
	String newName = (String)request.getParameter("updateName");
	String newPhoneNumber = (String)request.getParameter("updatePhoneNumber");
	String newEmail = (String)request.getParameter("updateEmail"); // 변경할 사항들
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	String jdbcDriver = "jdbc:mysql://192.168.219.196:3306/flyingdb?characterEncoding=utf-8";
	String dbUser = "root";
	String dbPass = "flying";
	
	Class.forName("com.mysql.jdbc.Driver");
	
	conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
	String sql ="UPDATE membertable SET password=?, membername=?, phonenumber=?, email=? where memberid=?";
	try {
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, newPw); // 입력된 수정 정보들
		pstmt.setString(2, newName);
		pstmt.setString(3, newPhoneNumber);
		pstmt.setString(4, newEmail);
		pstmt.setString(5, memId);
		pstmt.executeUpdate();
	}
	
	finally {
		if (pstmt != null) try { pstmt.close();} catch(SQLException ex) {}
		if (conn != null) try { conn.close();} catch(SQLException ex) {}
	}
	
	if(newName != memName) // 이름 변경시 바꾸는 코드
		session.setAttribute("memberName", newName);
%>
<script>
	alert("회원정보변경이 완료되었습니다!");
	location.href = 'myPage.jsp';
</script>