<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*"  %>
<% request.setCharacterEncoding("utf-8"); %>
<link rel="stylesheet" type="text/css" href="../css/signUpProcess.css">
<jsp:useBean class="flyingMember.MemberInfo" id="memInfo" scope="session"/>
<jsp:setProperty name="memInfo" property="*" />
<jsp:useBean class="flyingMember.InsertBean" id="memInsert" scope="session"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Flying</title>
</head>
<body>
<header>
    <jsp:include page="../module/header2.jsp" flush="false" />
</header>
<div id=title1>
	<img src="../img/mainlogo.png" width="300" height="100" alt="로고">
	<h1>가입완료!</h1>
</div>
<form action="loginBack.jsp" method="post">
	<div id="messagebox">
		<div id="message1">
		저희 Flying의 회원이 되신것을 진심으로 축하드립니다.<br>
		회원님들에게 보다 좋은 서비스를 제공할 수 있도록 끊임없이 노력하겠습니다.<br>
		감사합니다.   
		</div>
		<div id="message2">
			<h2>회원가입을 축하드립니다!</h2>
		</div>
		<div id="signupbtn">
			<input type="submit" value="로그인페이지로 이동" id="button3">
		</div>
	</div>
</form>

<%
 	memInsert.memberInsert(memInfo);
%>

<footer>
    <jsp:include page="../module/footer.jsp"></jsp:include>
</footer>
</body>
</html>