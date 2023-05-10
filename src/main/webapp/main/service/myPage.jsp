<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ page import="java.sql.*" %>

<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="stylesheet" type="text/css" href="../css/myPage.css">
<% 
	String memName = (String)session.getAttribute("memberName");
	String memberID = (String)session.getAttribute("memID");
%>

<%
	Class.forName("com.mysql.jdbc.Driver");
		
	Connection conn = null;
	PreparedStatement pstmt= null;
	ResultSet rs = null;
	
	String sql ="select * from membertable where memberid=?";
	
	String jdbcDriver = "jdbc:mysql://192.168.219.196:3306/flyingdb?"+
	"characterEncoding=utf-8";
	String dbUser = "root";
	String dbPass = "flying";
	
	try {
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
		pstmt= conn.prepareStatement(sql);
		pstmt.setString(1, memberID);
		rs = pstmt.executeQuery();
		while(rs.next()) {
%>	

<!DOCTYPE html>
<html>
<head>
<style>
</style>
<meta charset="UTF-8">
<title>flying</title>
</head>
<body>
<header>
    <jsp:include page="../module/header2.jsp" flush="false" />
</header>
<div id="title1">
	<img src="../img/mainlogo.png" width="345" height="105" alt="로고">
	<h1><%out.print(memName);%>님의 MyPage</h1>
</div>
<div id="tableLayout">
	<table class="myInfo">
		<thead>
			<tr>
				<th scope="cols">회원정보</th>
				<th scope="cols">내용</th>
			</tr>
		</thead>
		
		<tbody>
			<tr>
				<th scope="row">회원이름</th>
				<td><%= rs.getString("membername") %></td>
			</tr>
			<tr>
				<th scope="row">회원아이디</th>
				<td><%= rs.getString("memberid") %></td>
			</tr>
			<tr>
				<th scope="row">회원비밀번호</th>
				<td><%= rs.getString("password") %></td>
			</tr>
			<tr>
				<th scope="row">회원등급</th>
				<td>일반회원</td>
			</tr>
			<tr>
				<th scope="row">회원타입</th>
				<td><%= rs.getString("membertype") %></td>
			</tr>
			<tr>
				<th scope="row">회원전화번호</th>
				<td><%= rs.getString("phonenumber") %></td>
			</tr>
			<tr>
				<th scope="row">회원이메일</th>
				<td><%= rs.getString("email") %></td>
			</tr>
		<% } %>
	  
<% } catch(SQLException ex) {
		out.println(ex.getMessage());
		ex.printStackTrace();
	} finally {
		if (rs != null) try { rs.close();} catch(SQLException ex) {}
		if (pstmt != null) try { pstmt.close();} catch(SQLException ex) {}
		if (conn != null) try { conn.close();} catch(SQLException ex) {}
	}
%>
		</tbody>
	</table>
	<div id="allButton">	
	</div>
	 <div id="membutton1">
		 <form action="updateUser.jsp">
		 	<input type="submit" value="회원정보수정" id="button1">
		 </form>
	</div>
	
	<div id="membutton2">
		<script type="text/javascript">
		function button_event() {
			if (confirm("정말 flying을 탈퇴하시겠습니까??") == true)    
				location.href = 'deleteUser.jsp';
			else
			    return;
		}
		</script>
		<input type="submit" value="flying탈퇴" id="button2"  onclick="button_event();">
	</div>
</div>
<footer>
	<jsp:include page="../module/footer.jsp" />
</footer>
</body>
</html>