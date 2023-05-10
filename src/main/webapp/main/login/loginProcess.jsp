<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
<%
	String id = request.getParameter("id");
	String pw = request.getParameter("password");
	Class.forName("com.mysql.jdbc.Driver");

	Connection conn = null;	
	Statement stmt= null;
	ResultSet rs = null;

	try {
		String jdbcUrl = "jdbc:mysql://192.168.219.196:3306/flyingdb?useUnicode=true&CharacterEncoding=utf-8";
		String dbUser = "root";
		String dbPass = "flying";
			
		String sql ="select * from membertable where memberid = '" + id + "'";
	
		conn = DriverManager.getConnection(jdbcUrl, dbUser, dbPass);
		stmt = conn.createStatement();
		rs = stmt.executeQuery(sql);
		
		if(rs.next()) {
			rs.getString("memberid");
			rs.getString("password");
			rs.getString("membername");
		}

		if(id.equals(rs.getString("memberid")) && pw.equals(rs.getString("password"))) {
			if(request.getParameter("idSave") == null) 
				session.removeAttribute("memSave");
			else
				session.setAttribute("memSave", "check");
				session.setAttribute("memberName", rs.getString("membername"));
				session.setAttribute("memLogin","OK");
				session.setAttribute("memID", rs.getString("memberid"));
				response.sendRedirect("../index.jsp");
		} else {
			%>
	         <script>
	            alert("아이디 혹은 비밀번호가 일치하지 않습니다.");
	            location.href="loginPage.jsp";
	         </script>
	  <% }
	} catch(SQLException e) {
			out.println(e.getMessage());
			e.printStackTrace();
	} finally {
		if (rs != null) try { rs.close();} catch(SQLException ex) {}
		if (stmt != null) try { stmt.close();} catch(SQLException ex) {}
		if (conn != null) try { conn.close();} catch(SQLException ex) {}
  	}
%>
</body>
</html>